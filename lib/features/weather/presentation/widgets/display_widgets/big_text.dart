import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String message;
  const BigText(
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Text(
        message,
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.start,
      ),
    );
  }
}
