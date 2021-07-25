import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_weather/features/weather/presentation/bloc/weather_bloc.dart';

import '../bodies/weather_page_body.dart';

const initialBg = 'initialBg';

class WeatherPageScaffold extends StatefulWidget {
  final String background;

  const WeatherPageScaffold({
    this.background = initialBg,
    Key? key,
  }) : super(key: key);

  @override
  _WeatherPageScaffoldState createState() => _WeatherPageScaffoldState();
}

class _WeatherPageScaffoldState extends State<WeatherPageScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(
              widget.background == initialBg ? 0 : 0.3,
            ),
            BlendMode.darken,
          ),
          image: AssetImage('assets/images/${widget.background}.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: const [
              Text('GOT Weather'),
              SizedBox(width: 10),
              Icon(Icons.ac_unit),
            ],
          ),
        ),
        body: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is Error) {
              showErrorMessage(state.message);
            }
          },
          child: const WeatherPageBody(),
        ),
      ),
    );
  }

  void showErrorMessage(String message) {
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('An Error Occured'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Okay'),
            ),
          ],
        ),
      ),
    );
  }
}
