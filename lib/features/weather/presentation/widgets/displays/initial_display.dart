import 'package:flutter/material.dart';

import '../display_widgets/big_text.dart';
import '../display_widgets/subtitle_text.dart';

class InitialDisplay extends StatelessWidget {
  const InitialDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          Scaffold.of(context).appBarMaxHeight! -
          162,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 9.0,
              width: MediaQuery.of(context).size.width / 5.0,
              child: Image.asset('assets/images/weather_icons/02d.png'),
            ),
          ),
          const BigText(
            'THE GOT\nWEATHER\nFORECAST',
          ),
          const SubtitleText(
            'I KNOW NOTHING BUT WEATHER...',
          ),
        ],
      ),
    );
  }
}
