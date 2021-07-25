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

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 12,
          child: TextField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            cursorColor: primaryColor,
            controller: controller,
            decoration: InputDecoration(
              border: _buildOutlineInputBorder(primaryColor),
              enabledBorder: _buildOutlineInputBorder(primaryColor),
              focusedBorder: _buildOutlineInputBorder(primaryColor),
              suffixIcon: Icon(
                Icons.search,
                color: primaryColor,
              ),
              hintText: 'Enter a city...',
            ),
            onEditingComplete: _dispatchFromCity,
            onSubmitted: (_) => _dispatchFromCity,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: primaryColor),
                onPressed: _dispatchFromCity,
                child: const Text('SEARCH'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primaryColor),
                ),
                label: Text(
                  'SEARCH BY LOCATION',
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
                icon: Icon(
                  Icons.location_pin,
                  size: 20,
                  color: primaryColor,
                ),
                onPressed: _dispatchFromLocation,
              ),
            ),
          ],
        ),
      ],
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(Color primaryColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
      ),
    );
  }

  void _dispatchFromCity() {
    if (controller.text.isEmpty) {
      _showErrorSnackBar();
      return;
    }
    BlocProvider.of<WeatherBloc>(context)
        .add(GetWeatherForCity(controller.text));
    controller.clear();
    FocusScope.of(context).unfocus();
  }

  void _dispatchFromLocation() {
    controller.clear();
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherForLocation());
    FocusScope.of(context).unfocus();
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Please enter a city name...'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
  }
}
