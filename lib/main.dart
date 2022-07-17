import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_themes.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'features/weather/presentation/screens/about_screen.dart';
import 'features/weather/presentation/screens/home_screen.dart';
import 'features/weather/presentation/screens/settings_screen.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.black,
    ),
  );
  await di.init();
  runApp(const MyApp());
}

class GOTWeatherApp extends StatelessWidget {
  const GOTWeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (_, state) => state is! Loading,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GOT Weather',
          theme: state is Loaded
              ? appThemeData[state.gotWeather.appTheme]
              : appThemeData[AppTheme.initial],
          home: const HomeScreen(),
          routes: {
            SettingsScreen.routeName: (ctx) => const SettingsScreen(),
            AboutScreen.routeName: (ctx) => const AboutScreen(),
          },
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return di.sl<WeatherBloc>()..add(GetWeatherForLastCity());
      },
      child: const GOTWeatherApp(),
    );
  }
}
