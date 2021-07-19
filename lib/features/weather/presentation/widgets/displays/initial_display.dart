import 'package:flutter/material.dart';

import '../display_widgets/big_text.dart';

class InitialDisplay extends StatelessWidget {
  const InitialDisplay({
    Key? key,
  }) : super(key: key);

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
