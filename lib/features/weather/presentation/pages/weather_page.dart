import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1546514355-7fdc90ccbd03?ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NnwxNjc1Mzk1fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('GOT Weather', style: GoogleFonts.poppins()),
        ),
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
      ),
    );
  }
}
