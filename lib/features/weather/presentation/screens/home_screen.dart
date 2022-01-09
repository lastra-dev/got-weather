import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../widgets/bodies/home_screen_body.dart';
import 'about_screen.dart';
import 'settings_screen.dart';

const initialBg = 'initialBg';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is Error) {
          showErrorMessage(state.message);
        }
      },
      buildWhen: (_, state) => state is! Loading,
      builder: (context, state) {
        // FutureBuilder needed to change between backgrounds
        // without loading black screen
        return FutureBuilder(
          future: buildBackgroundImage(
            'assets/images/${state is Loaded ? state.gotWeather.background : initialBg}.jpg',
          ),
          builder: (_, snapshot) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  image: (snapshot.data ??
                          const AssetImage('assets/images/$initialBg.jpg'))
                      as AssetImage,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: const Text('GOT Weather'),
                  actions: [
                    PopupMenuButton(
                      onSelected: (choice) =>
                          Navigator.of(context).pushNamed(choice.toString()),
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: SettingsScreen.routeName,
                          child: Text('Settings'),
                        ),
                        const PopupMenuItem(
                          value: AboutScreen.routeName,
                          child: Text('About'),
                        ),
                      ],
                    )
                  ],
                ),
                body: const HomeScreenBody(),
              ),
            );
          },
        );
      },
    );
  }

  void showErrorMessage(String message) {
    SchedulerBinding.instance!.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: const [
              Text('An Error Ocured '),
              Icon(
                Icons.error,
                color: Colors.yellow,
              ),
            ],
          ),
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

  Future<AssetImage> buildBackgroundImage(String imageToPrecache) async {
    await precacheImage(AssetImage(imageToPrecache), context);
    return AssetImage(imageToPrecache);
  }
}
