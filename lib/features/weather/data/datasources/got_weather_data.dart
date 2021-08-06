import 'package:got_weather/core/theme/app_themes.dart';

import '../../domain/entities/got_weather.dart';

enum GOTCity {
  beyondTheWall,
  winterfell,
  highgarden,
  kingsLanding,
  dorne,
  yunkai,
  dragonstone,
  dothrakiSea,
}

const gotWeatherData = {
  GOTCity.beyondTheWall: GOTWeather(
    appTheme: AppTheme.beyondTheWall,
    title: "Feels Like\nBeyond\nthe wall",
    subtitle: 'Looks like an arrowhead...',
    background: 'beyondTheWallBg',
    minTemp: -100,
    maxTemp: 5,
  ),
  GOTCity.winterfell: GOTWeather(
    appTheme: AppTheme.winterfell,
    title: 'Feels Like\nWinterfell',
    subtitle: 'Winter is comming...',
    background: 'winterfellBg',
    minTemp: 6,
    maxTemp: 10,
  ),
  GOTCity.highgarden: GOTWeather(
    appTheme: AppTheme.highgarden,
    title: 'Feels Like\nHighgarden',
    subtitle: "I want her to know, it was me...",
    background: 'highgardenBg2',
    minTemp: 11,
    maxTemp: 15,
  ),
  GOTCity.dragonstone: GOTWeather(
    appTheme: AppTheme.dragonstone,
    title: 'Feels Like\nDragonstone',
    subtitle: 'Shall we begin?',
    background: 'dragonstoneBg',
    minTemp: 16,
    maxTemp: 20,
  ),
  GOTCity.kingsLanding: GOTWeather(
    appTheme: AppTheme.kingsLanding,
    title: "Feels Like\nKing's\nLanding",
    subtitle: 'Power is power...',
    background: 'kingsLandingBg',
    minTemp: 21,
    maxTemp: 25,
  ),
  GOTCity.dorne: GOTWeather(
    appTheme: AppTheme.dorne,
    title: 'Feels\nLike\nDorne',
    subtitle: 'You might catch a snake...',
    background: 'dorneBg',
    minTemp: 26,
    maxTemp: 30,
  ),
  GOTCity.yunkai: GOTWeather(
    appTheme: AppTheme.yunkai,
    title: 'Feels\nLike\nYunkai',
    subtitle: 'We shall enslave once more...',
    background: 'yunkaiBg',
    minTemp: 31,
    maxTemp: 35,
  ),
  GOTCity.dothrakiSea: GOTWeather(
    appTheme: AppTheme.dothrakiSea,
    title: 'Feels Like\nDothraki Sea',
    subtitle: 'My sun and stars...',
    background: 'dothrakiSeaBg',
    minTemp: 36,
    maxTemp: 100,
  ),
};
