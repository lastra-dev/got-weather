import 'package:flutter/material.dart';
import 'features/weather/presentation/pages/weather_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GOT Weather',
      home: WeatherPage(),
    );
  }
}
