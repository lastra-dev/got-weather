import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText(
    this.message, {
    Key? key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
