import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather_bloc.dart';
import '../display_widgets/weather_controls.dart';
import '../displays/initial_display.dart';
import '../displays/loading_display.dart';
import '../displays/weather_display.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).accentColor,
      onRefresh: () => BlocProvider.of<WeatherBloc>(context).retry(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            Scaffold.of(context).appBarMaxHeight!,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const WeatherControls(),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const LoadingDisplay();
                    } else if (state is Loaded) {
                      return WeatherDisplay(
                        weather: state.weather,
                        gotWeather: state.gotWeather,
                      );
                    } else {
                      return Column(
                        children: const [
                          SizedBox(height: 20),
                          InitialDisplay(),
                        ],
                      );
                    }
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
