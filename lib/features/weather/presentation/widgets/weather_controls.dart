import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_weather/features/weather/presentation/bloc/weather_bloc.dart';

class WeatherControls extends StatefulWidget {
  const WeatherControls({
    Key? key,
  }) : super(key: key);

  @override
  _WeatherControlsState createState() => _WeatherControlsState();
}

class _WeatherControlsState extends State<WeatherControls> {
  final controller = TextEditingController();
  String? inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Search a City...'),
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (_) => dispatchFromCity,
          ),
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: dispatchFromCity,
                    child: const Text('Search City'))),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: dispatchFromLocation,
                child: const Text('Search your Location'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void dispatchFromCity() {
    controller.clear();
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherForCity(inputStr!));
  }

  void dispatchFromLocation() {
    controller.clear();
    BlocProvider.of<WeatherBloc>(context)
        .add(const GetWeatherForLocation(22, -97));
  }
}
