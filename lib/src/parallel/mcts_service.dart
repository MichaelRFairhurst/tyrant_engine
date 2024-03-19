import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:isolate';

import 'package:tyrant_engine/src/algorithm/mcts.dart';
import 'package:tyrant_engine/src/cli/printer.dart';
import 'package:tyrant_engine/src/gameplay/gameplay_engine.dart';
import 'package:tyrant_engine/src/parallel/mcts_request.dart';
import 'package:tyrant_engine/src/parallel/mcts_spec.dart';
import 'package:tyrant_engine/src/parallel/mcts_result.dart';
import 'package:tyrant_engine/tyrant_engine.dart';

class MctsService {
  final channels = <_MctsWorkerChannel>[];
  final MctsSpec spec;
  final _taskQueue = Queue<_PendingTask>();

  MctsService(this.spec);

  Future<void> run() async {
    for (int i = 0; i < spec.threads; ++i) {
      final channel = _MctsWorkerChannel(spec);
      channels.add(channel);
      await channel.start();
    }
  }

  Future<MctsResult> searchGame(dynamic game) async {
    for (int i = 0; i < channels.length; ++i) {
      if (channels[i].busy) {
        continue;
      }
      final result = await channels[i].dispatch(game);
      _keepDraining(channels[i]);
      return result;
    }

    final enqueued = _PendingTask(Completer(), game);
    _taskQueue.add(enqueued);
    return enqueued.completer.future;
  }

  void _keepDraining(_MctsWorkerChannel channel) async {
    while (_taskQueue.isNotEmpty) {
      final enqueued = _taskQueue.removeFirst();
      final result = await channel.dispatch(enqueued.task);
      enqueued.completer.complete(result);
    }
  }
}

class _PendingTask {
  final Completer<MctsResult> completer;
  final MctsRequest task;

  _PendingTask(this.completer, this.task);
}

class _MctsWorkerChannel {
  late final SendPort sendPort;
  final receivePort = ReceivePort();
  final MctsSpec spec;

  Completer<MctsResult>? onDone;

  _MctsWorkerChannel(this.spec) {
    receivePort.listen(onMessage);
    Isolate.spawn(_MctsWorker._spawn, receivePort.sendPort);
  }

  Future<void> start() async {
    // Allow us to receive the sendPort from the other isolate
    await Future.delayed(const Duration(milliseconds: 5));
  }

  bool get busy => onDone != null;

  Future<MctsResult> dispatch(MctsRequest taskMessage) {
    onDone = Completer<MctsResult>();
    sendPort.send(json.encode(taskMessage.toJson()));
    return onDone!.future;
  }

  void onMessage(dynamic message) {
    //print('^^^^^^^ here $message');
    if (message is SendPort) {
      sendPort = message;
      sendPort.send(json.encode(spec.toJson()));
    } else {
      onDone!.complete(MctsResult.fromJson(json.decode(message)));
      onDone = null;
    }
  }
}

class _MctsWorker {
  final SendPort sendPort;
  final receivePort = ReceivePort();
  GameplayEngine? gameplayEngine;
  Mcts? mcts;

  static void _spawn(SendPort port) {
    _MctsWorker(port);
  }

  _MctsWorker(this.sendPort) {
    receivePort.listen(handleMessage);
    //print('^^^^^^ sending');
    sendPort.send(receivePort.sendPort);
    //print('^^^^^^ sent');
  }

  void handleMessage(dynamic message) async {
    if (mcts == null) {
      final spec = MctsSpec.fromJson(json.decode(message));
      final tyrantEngine = TyrantEngine();
      mcts = tyrantEngine.mcts(spec);
      gameplayEngine = tyrantEngine.gameplayEngine(NoopPrinter());
    } else {
      final task = MctsRequest.fromJson(json.decode(message));
      final actions = gameplayEngine!.ruleEngine.playerActions(task.game);
      final result = MctsResult(
          victoryCount: await mcts!
              .countVictoriesForActionIdx(task.game, actions, task.actionIdx));
      sendPort.send(json.encode(result.toJson()));
    }
  }
}
