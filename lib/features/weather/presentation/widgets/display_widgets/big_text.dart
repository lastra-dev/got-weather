import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

const colorizeColors = [
  Colors.white,
  Colors.blue,
];

class BigText extends StatelessWidget {
  final String message;
  const BigText(
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      width: MediaQuery.of(context).size.width,
      child: DefaultTextStyle(
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              message,
              speed: const Duration(
                milliseconds: 100,
              ),
            ),
          ],
          repeatForever: true,
          pause: const Duration(seconds: 5),
        ),
      ),
    );
  }
}
