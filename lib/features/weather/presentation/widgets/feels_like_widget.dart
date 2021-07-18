import 'package:flutter/material.dart';

class FeelsLikeWidget extends StatelessWidget {
  const FeelsLikeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: const Text(
        'HOW\nDOES IT\nFEEL LIKE?',
        style: TextStyle(
          height: 1,
          // color: Colors.white,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
