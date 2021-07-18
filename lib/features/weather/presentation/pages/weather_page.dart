import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/feels_like_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/weather_controls.dart';
import '../widgets/weather_display.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/initialBg.jpg'),
          fit: BoxFit.fill,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('GOT Weather')),
        body: const Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherBloc>(),
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
                      return Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 8),
                          const FeelsLikeWidget(),
                        ],
                      );
                    } else if (state is Loading) {
                      return const LoadingWidget();
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
