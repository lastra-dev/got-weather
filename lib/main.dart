import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return MaterialApp(
      title: 'GOT Weather',
      home: const WeatherPage(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(),
          subtitle1: GoogleFonts.poppins(),
          button: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}
