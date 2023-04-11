import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/bird_controller.dart';
import 'package:flappy_bird/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'titanOne',
        ),
        home: const Home(),
      ),
    ),
  );
}

TextStyle? get mainFontTheme {
  return const TextStyle(
    fontSize: 32,
    color: Colors.white,
    fontFamily: 'titanOne',
  );
}

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late BirdController _controller;
  late Utils _utils;
  @override
  void initState() {
    super.initState();
    _controller = ref.read(birdControllerProvider);
    _utils = Utils();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Consumer(
                      builder: (_, __, ___) {
                        final birdLocation = ref.watch(birdLocationProvider);
                        return GestureDetector(
                          onTap: () {
                            if (_controller.hasGameStarted) {
                              _controller.jump();
                            } else {
                              _controller.startGame(context);
                            }
                          },
                          child: AnimatedContainer(
                              alignment: Alignment(0.0, birdLocation),
                              color: Colors.lightBlue,
                              duration: const Duration(milliseconds: 0),
                              child: Bird(
                                height: _utils.birdHeight,
                                width: _utils.birdWidth,
                                birdLocation: birdLocation,
                              )),
                        );
                      },
                    ),
                    Barrier(
                      height: _utils.barriers[0][0],
                      width: _utils.barrierWidth,
                      isBottomBarrier: false,
                      index: 0,
                    ),
                    Barrier(
                      height: _utils.barriers[0][1],
                      width: _utils.barrierWidth,
                      isBottomBarrier: true,
                      index: 0,
                    ),
                    Barrier(
                      height: _utils.barriers[1][0],
                      width: _utils.barrierWidth,
                      isBottomBarrier: false,
                      index: 1,
                    ),
                    Barrier(
                      height: _utils.barriers[1][1],
                      width: _utils.barrierWidth,
                      isBottomBarrier: true,
                      index: 1,
                    ),
                    Barrier(
                      height: _utils.barriers[2][0],
                      width: _utils.barrierWidth,
                      isBottomBarrier: false,
                      index: 2,
                    ),
                    Barrier(
                      height: _utils.barriers[2][1],
                      width: _utils.barrierWidth,
                      isBottomBarrier: true,
                      index: 2,
                    ),
                    Consumer(
                      builder: (_, __, ___) {
                        final hasGameStarted = _controller.hasGameStarted;
                        return !hasGameStarted
                            ? Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "T A P   T O   P L A Y",
                                    style: mainFontTheme,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
                child: Container(color: Colors.green),
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer(builder: (_, __, ___) {
                          final score = ref.read(birdControllerProvider).score;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Score',
                                style: mainFontTheme,
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Text(
                                '$score',
                                style: mainFontTheme,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
