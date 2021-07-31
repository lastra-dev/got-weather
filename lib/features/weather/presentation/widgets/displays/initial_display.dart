import 'package:flutter/material.dart';

import '../display_widgets/big_text.dart';

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
              height: MediaQuery.of(context).size.height / 8.0,
              child: Image.asset('assets/images/coloredWeatherIcon.jpg'),
              // child: const Placeholder(),
            ),
          ),
          const BigText('I KNOW\nNOTHING\nBUT WEATHER'),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.0,
            child: Image.asset('assets/images/jonCat.jpg'),
            // child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
