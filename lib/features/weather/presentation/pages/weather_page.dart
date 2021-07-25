import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../widgets/scaffolds/weather_page_scaffold.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previousState, state) => state is! Loading,
      builder: (context, state) {
        if (state is Loaded) {
          return WeatherPageScaffold(background: state.gotWeather.background);
        } else {
          return const WeatherPageScaffold();
        }
      },
    );
  }
}
