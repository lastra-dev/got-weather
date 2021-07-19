import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather_bloc.dart';
import '../display_widgets/weather_controls.dart';
import '../displays/initial_display.dart';
import '../displays/message_display.dart';
import '../displays/weather_display.dart';

class WeatherPageBody extends StatelessWidget {
  const WeatherPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const WeatherControls(),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitial) {
                      return const InitialDisplay();
                    } else if (state is Loaded) {
                      return WeatherDisplay(
                        weather: state.weather,
                        gotWeather: state.gotWeather,
                      );
                    } else if (state is Error) {
                      return MessageDisplay(message: state.message);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
