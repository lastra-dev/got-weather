import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_weather/features/weather/presentation/bloc/weather_bloc.dart';

class BigText extends StatelessWidget {
  final String message;
  const BigText(
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial || state is Error) {
          return buildBigText(
            context,
            color: Theme.of(context).primaryColor,
          );
        } else if (state is Loaded) {
          return buildBigText(context);
        }
        return Container();
      },
    );
  }

  SizedBox buildBigText(
    BuildContext context, {
    Color color = Colors.white,
  }) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Text(
        message,
        style: TextStyle(
          height: 1,
          color: color,
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
