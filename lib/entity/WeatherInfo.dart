import 'dart:core';

class WeatherInfo {
    final LocationInfo location;
    final CurrentWeather current;
    final ForecastInfo forecastInfo;

  WeatherInfo({required this.location, required this.current, required this.forecastInfo});
}

class CurrentWeather {
  CurrentWeather({
        required this.temperature,
        required this.condition,
        required this.feelsLike,
        required this.windSpeed,
        required this.windDirection,
        required this.sunriseAt,
        required this.pressure,
        required this.uvIndex,
        required this.humidity
      }
      );
  final double temperature;
  final int humidity;
  final Condition condition;
  final double feelsLike;
  final double windSpeed;
  final String windDirection;
  final double pressure;
  final String sunriseAt;
  final double uvIndex;
}

class Condition {
    final String text;
    final String icon;

  Condition({required this.text, required this.icon});
}

class ForecastInfo {
    final List<ForecastDay> forecastDay;

  ForecastInfo({required this.forecastDay});
}

class ForecastDay {
    final Astro astro;
    final List<Hour> hour;
    final Day day;

  ForecastDay({required this.astro, required this.hour, required this.day});
}

class Day {
    final double avgTemp;
    final Condition condition;

  Day({required this.avgTemp, required this.condition});
}

class Astro {
  Astro({required this.sunrise});
  final String sunrise;
}

class Hour {
    final String time;
    final double temperature;
    final Condition condition;

  Hour({required this.time, required this.temperature, required this.condition});
}

class LocationInfo {
  final String cityName;

  LocationInfo({required this.cityName});
}