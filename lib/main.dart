import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/weather/presentation/apps/loading_material_app.dart';
import 'features/weather/presentation/apps/weather_material_app.dart';
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
          if (state is WeatherInitial || state is Error) {
            return const WeatherMaterialApp();
          } else if (state is Loading) {
            return const LoadingMaterialApp();
          } else if (state is Loaded) {
            return WeatherMaterialApp(
              primaryColor: Color(state.gotWeather.primaryColor),
            );
          }
          return Container();
        },
      ),
    );
  }
}
