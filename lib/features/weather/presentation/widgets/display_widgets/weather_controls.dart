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
              hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                  side: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                label: const Text(
                  'SEARCH BY LOCATION',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                icon: const Icon(
                  Icons.location_pin,
                  size: 20,
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
        width: 2,
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
        content: const Text(
          'Please enter a city name...',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
  }
}
