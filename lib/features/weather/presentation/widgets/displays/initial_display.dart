import 'package:flutter/material.dart';

import '../display_widgets/big_text.dart';

class InitialDisplay extends StatefulWidget {
  const InitialDisplay({Key? key}) : super(key: key);

  @override
  _InitialDisplayState createState() => _InitialDisplayState();
}

class _InitialDisplayState extends State<InitialDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 8),
        const BigText('HOW\nDOES IT\nFEEL LIKE?'),
      ],
    );
  }
}
