import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_weather/features/weather/presentation/widgets/loading_widget.dart';
import 'package:got_weather/features/weather/presentation/widgets/message_display.dart';
import 'package:got_weather/features/weather/presentation/widgets/weather_display.dart';

import '../../../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/weather_controls.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GOT Weather'),
      ),
      body: const SingleChildScrollView(child: Body()),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherBloc>(),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const WeatherControls(),
                const SizedBox(height: 20),
                BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                  if (state is WeatherInitial) {
                    return const MessageDisplay(message: 'Search weather!');
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return WeatherDisplay(weather: state.weather);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  return Container();
                }),
              ],
            )),
      ),
    );
  }
}
