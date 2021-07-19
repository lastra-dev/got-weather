import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/weather/presentation/apps/initial_material_app.dart';
import 'features/weather/presentation/apps/loading_material_app.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<WeatherBloc>(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const InitialMaterialApp(
              primaryColor: Color.fromRGBO(39, 41, 53, 1),
            );
          } else if (state is Loading) {
            return const LoadingMaterialApp();
          } else if (state is Loaded) {
            return const InitialMaterialApp(
              primaryColor: Color.fromRGBO(149, 3, 48, 1),
            );
          } else if (state is Error) {
            // TODO: Create Error widget
            return Text(state.message);
          }
          return Container();
        },
      ),
    );
  }
}
