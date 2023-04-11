import 'dart:async';

import 'package:flappy_bird/game_over_alert_box.dart';
import 'package:flappy_bird/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final birdControllerProvider = StateProvider<BirdController>((ref) {
  return BirdController(ref);
});
final birdLocationProvider = StateProvider<double>((ref) => 0.0);

final logger = Logger();
final _utils = Utils();

class BirdController {
  final Ref _ref;
  BirdController(this._ref);

  double birdLocation = 0.0;
  double time = 0;
  double initialHeight = 0;
  int scoreCount = 0;
  bool hasGameStarted = false;
  List<List<double>> barrierLocations = [
    [1.5, 0],
    [3, 0],
    [4.5, 0],
  ];

  final barriers = _utils.barriers;
  final birdWidth = _utils.birdWidth;
  final birdHeight = _utils.birdHeight;
  final barrierWidth = _utils.barrierWidth;

  double newBirdLocation(h) {
    return initialHeight - h;
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return GameOverAlertBox(
            score: scoreCount,
          );
        });
  }

  bool birdIsDead() {
    final location = _ref.read(birdLocationProvider);
    if (location > 1 || location < -1) {
      return true;
    }
    for (int i = 0; i < barriers.length; i++) {
      if (barrierLocations[i][0] <= birdWidth &&
          barrierLocations[i][0] + barrierWidth >= -birdWidth &&
          (location <= -1 + barriers[i][0] ||
              location + birdHeight >= 1 - barriers[i][1])) {
        return true;
      }
    }
    return false;
  }

  void jump() {
    initialHeight = _ref.read(birdLocationProvider);
    time = 0;
  }

  void resetGame() {
    hasGameStarted = false;
    scoreCount = 0;
    _ref.read(birdLocationProvider.notifier).state = 0;
    initialHeight = 0;
    time = 0;
    barrierLocations = [
      [1.5, 0],
      [3, 0],
      [4.5, 0],
    ];
    ;
  }

  void startGame(BuildContext context) {
    logger.d("Game Started");
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      double height = 3.0 * time - 4.9 * time * time;
      _ref.read(birdLocationProvider.notifier).state = newBirdLocation(height);

      if (birdIsDead()) {
        logger.d("bird died");
        logger.d(_ref.read(birdLocationProvider));
        timer.cancel();
        _showDialog(context);
      }
      moveBarriers();
      time += 0.04;
    });
  }

  void moveBarriers() {
    for (int i = 0; i < barrierLocations.length; i++) {
      barrierLocations[i][0] -= 0.023;
      if (barrierLocations[i][0] + barrierWidth < 0) {
        if (barrierLocations[i][1] == 0) {
          scoreCount++;
          barrierLocations[i][1] = 1;
        }
      }
      if (barrierLocations[i][0] < -3) {
        barrierLocations[i][1] = 0;
        barrierLocations[i][0] += 4.5;
      }
    }
  }

  int get score => scoreCount;
}
