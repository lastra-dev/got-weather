import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_themes.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'features/weather/presentation/screens/home_screen.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

class GOTWeatherApp extends StatelessWidget {
  const GOTWeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImages(context);
    return BlocBuilder<WeatherBloc, WeatherState>(
        buildWhen: (_, state) => state is! Loading,
        builder: (context, state) {
          return MaterialApp(
            title: 'GOT Weather',
            theme: state is Loaded
                ? appThemeData[state.gotWeather.appTheme]
                : appThemeData[AppTheme.initial],
            home: const HomeScreen(),
          );
        });
  }

  void precacheImages(BuildContext context) {
    precacheImage(const AssetImage("assets/images/winterfellBg.jpg"), context);
    precacheImage(const AssetImage("assets/images/dorneBg.jpg"), context);
    precacheImage(
        const AssetImage("assets/images/kingsLandingBg.jpg"), context);
    precacheImage(
        const AssetImage("assets/images/beyondTheWallBg.jpg"), context);
    precacheImage(const AssetImage("assets/images/highgardenBg.jpg"), context);
  }
}
