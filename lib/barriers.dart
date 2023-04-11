import 'package:flappy_bird/bird_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Barrier extends ConsumerWidget {
  final double height;
  final double width;
  final int index;
  final bool isBottomBarrier;
  const Barrier(
      {required this.height,
      required this.index,
      required this.width,
      required this.isBottomBarrier,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (_, __, ___) {
      final barrierLocations =
          ref.watch(birdControllerProvider).barrierLocations;
      return GestureDetector(
        onTap: ref.read(birdControllerProvider).jump,
        child: Container(
          alignment: Alignment(
            (2 * barrierLocations[index][0] + width) / (2 - width),
            isBottomBarrier ? 1 : -1,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft:
                      isBottomBarrier ? const Radius.circular(8) : Radius.zero,
                  topRight:
                      isBottomBarrier ? const Radius.circular(8) : Radius.zero,
                  bottomLeft:
                      !isBottomBarrier ? const Radius.circular(8) : Radius.zero,
                  bottomRight:
                      !isBottomBarrier ? const Radius.circular(8) : Radius.zero,
                ),
                border: Border.all(color: Colors.black12, width: 2.0)),
            height: MediaQuery.of(context).size.height * 3 / 4 * height / 2,
            width: MediaQuery.of(context).size.width * width / 2,
          ),
        ),
      );
    });
  }
}
