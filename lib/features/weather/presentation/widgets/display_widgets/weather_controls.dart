import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather_bloc.dart';

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
          height: MediaQuery.of(context).size.height / 12,
          child: TextField(
            cursorColor: Theme.of(context).primaryColor,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              suffixIcon: const Icon(Icons.search),
              hintText: 'Enter a city...',
            ),
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (_) => dispatchFromCity,
            onEditingComplete: dispatchFromCity,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: dispatchFromCity,
                child: const Text('SEARCH'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                onPressed: dispatchFromLocation,
                label: Text(
                  'SEARCH BY LOCATION',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                icon: Icon(
                  Icons.location_pin,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void dispatchFromCity() {
    controller.clear();
    if (inputStr == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a city name...'),
          action: SnackBarAction(label: 'Ok', onPressed: () {}),
        ),
      );
      return;
    }
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherForCity(inputStr!));
    inputStr = '';
  }

  void dispatchFromLocation() {
    controller.clear();
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherForLocation());
  }
}
