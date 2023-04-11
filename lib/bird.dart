import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final double birdLocation;
  final double height;
  final double width;
  const Bird(
      {required this.birdLocation,
      required this.height,
      required this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdLocation + height) / (2 - height)),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 3 / 4 * height / 2,
      width: MediaQuery.of(context).size.width * width / 2,
    );
  }
}
