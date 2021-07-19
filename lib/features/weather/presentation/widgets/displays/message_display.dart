import 'package:flutter/material.dart';

import '../display_widgets/big_text.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 8),
        BigText(message),
      ],
    );
  }
}
