import 'package:got_weather/core/theme/app_themes.dart';

import '../../domain/entities/got_weather.dart';

enum GOTCity {
  beyondTheWall,
  winterfell,
  highgarden,
  kingsLanding,
  dorne,
  yunkai,
}

const gotWeatherData = {
  GOTCity.beyondTheWall: GOTWeather(
    appTheme: AppTheme.beyondTheWall,
    title: "Feels Like\nBeyond\nthe wall",
    subtitle: 'Looks like an arrowhead...',
    background: 'beyondTheWallBg',
    minTemp: -100,
    maxTemp: 8,
  ),
  GOTCity.winterfell: GOTWeather(
    appTheme: AppTheme.winterfell,
    title: 'Feels\nLike\nWinterfell',
    subtitle: 'Winter is comming...',
    background: 'winterfellBg',
    minTemp: 9,
    maxTemp: 15,
  ),
  GOTCity.highgarden: GOTWeather(
    appTheme: AppTheme.highgarden,
    title: 'Feels Like\nHighgarden',
    subtitle: "I want her to know, it was me...",
    background: 'highgardenBg',
    minTemp: 16,
    maxTemp: 20,
  ),
  GOTCity.kingsLanding: GOTWeather(
    appTheme: AppTheme.kingsLanding,
    title: "Feels Like\nKing's\nLanding",
    subtitle: 'Power is power...',
    background: 'kingsLandingBg',
    minTemp: 21,
    maxTemp: 30,
  ),
  GOTCity.dorne: GOTWeather(
    appTheme: AppTheme.dorne,
    title: 'Feels\nLike\nDorne',
    subtitle: 'You might catch a snake...',
    background: 'dorneBg',
    minTemp: 25,
    maxTemp: 29,
  ),
  GOTCity.yunkai: GOTWeather(
    appTheme: AppTheme.yunkai,
    title: 'Feels\nLike\nYunkai',
    subtitle: 'We shall enslave once more...',
    background: 'yunkaiBg',
    minTemp: 30,
    maxTemp: 100,
  ),
};
