import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather_bloc.dart';
import '../display_widgets/big_text.dart';

class InitialDisplay extends StatefulWidget {
  const InitialDisplay({Key? key}) : super(key: key);

  @override
  _InitialDisplayState createState() => _InitialDisplayState();
}

class _InitialDisplayState extends State<InitialDisplay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is Error) {
          showErrorMessage(state.message);
        }
        return Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            const BigText('HOW\nDOES IT\nFEEL LIKE?'),
          ],
        );
      },
    );
  }

  void showErrorMessage(
    String message,
  ) {
    SchedulerBinding.instance!.addPostFrameCallback(
      (duration) => showDialog(
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
