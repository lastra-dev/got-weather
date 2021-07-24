import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather_bloc.dart';
import '../display_widgets/big_text.dart';

class MessageDisplay extends StatefulWidget {
  final String message;

  const MessageDisplay({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  _MessageDisplayState createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is Error) {
              showErrorMessage(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 8),
        BigText(widget.message),
      ],
    );
  }

  void showErrorMessage(String message) {
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('An Error Occured!'),
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
