import 'package:flutter/material.dart';

class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 100),
        Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
