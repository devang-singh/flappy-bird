import 'package:flappy_bird/bird_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameOverAlertBox extends ConsumerWidget {
  final int score;
  const GameOverAlertBox({required this.score, Key? key}) : super(key: key);

  TextStyle get _alertBoxTextStyle => const TextStyle(
        fontSize: 50,
        color: Colors.white,
      );

  Widget get _title => Text('Game Over', style: _alertBoxTextStyle);

  Widget get _score => Column(
        children: [
          Text(
            "Score",
            style: _alertBoxTextStyle,
          ),
          Text(
            '$score',
            style: _alertBoxTextStyle,
          ),
        ],
      );

  Widget _newGameButton(BuildContext context, WidgetRef ref) => GestureDetector(
        onTap: () {
          ref.read(birdControllerProvider).resetGame();
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(color: Colors.white, width: 3.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("New Game",
                  style: TextStyle(color: Colors.white, fontSize: 36)),
              SizedBox(width: 20),
              FaIcon(
                FontAwesomeIcons.arrowRotateRight,
                color: Colors.white,
                size: 36,
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title,
              const SizedBox(height: 32),
              _score,
              const SizedBox(height: 40),
              _newGameButton(context, ref),
            ],
          ),
        ),
      ),
    );
  }
}
