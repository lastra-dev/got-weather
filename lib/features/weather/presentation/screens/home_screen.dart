import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../widgets/bodies/home_screen_body.dart';

const initialBg = 'initialBg';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previousState, state) => state is! Loading,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(
                  state is Loaded ? 0.3 : 0.0,
                ),
                BlendMode.darken,
              ),
              image: AssetImage(
                  'assets/images/${state is Loaded ? state.gotWeather.background : initialBg}.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('GOT Weather'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
            body: BlocListener<WeatherBloc, WeatherState>(
              listener: (context, state) {
                if (state is Error) {
                  showErrorMessage(state.message);
                }
              },
              child: const HomeScreenBody(),
            ),
          ),
        );
      },
    );
  }

  void showErrorMessage(String message) {
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An Error Occured'),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'Okay',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
