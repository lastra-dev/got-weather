import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather_bloc.dart';
import '../display_widgets/weather_controls.dart';
import '../displays/loading_display.dart';
import '../displays/message_display.dart';
import '../displays/weather_display.dart';

class WeatherPageBody extends StatelessWidget {
  const WeatherPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () => BlocProvider.of<WeatherBloc>(context).retry(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const WeatherControls(),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitial || state is Error) {
                      return const MessageDisplay(
                          message: 'HOW\nDOES IT\nFEEL LIKE?');
                    } else if (state is Loading) {
                      return const LoadingDisplay();
                    } else if (state is Loaded) {
                      return WeatherDisplay(
                        weather: state.weather,
                        gotWeather: state.gotWeather,
                      );
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
