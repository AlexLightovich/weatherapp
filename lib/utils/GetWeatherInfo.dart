import 'package:dio/dio.dart';
import 'package:weatherapp/entity/WeatherInfo.dart';
class GetWeatherInfo {

    final String position;

  GetWeatherInfo({required this.position});

    Future<WeatherInfo> getWeatherInfo() async {
        final response = await Dio().get("http://api.weatherapi.com/v1/forecast.json?key=e61e2f43c0804f5b8bd161528242605&q=${position}4&days=7&aqi=no&alerts=no&lang=ru");
        final data = response.data as Map<String, dynamic>;
        final locationData = data['location'];
        final currentWeatherData = data['current'] as Map<String, dynamic>;
        final forecast = data['forecast'] as Map<String, dynamic>;

        CurrentWeather currentWeather = CurrentWeather(
            temperature: currentWeatherData['temp_c'],
            feelsLike: currentWeatherData['feelslike_c'],
            windSpeed: currentWeatherData['wind_kph'],
            condition: Condition(text: currentWeatherData['condition']['text'].toString(), icon: currentWeatherData['condition']['icon']),
            windDirection: currentWeatherData['wind_dir'],
            humidity: currentWeatherData['humidity'],
            uvIndex: currentWeatherData['uv'],
            pressure: currentWeatherData['pressure_mb'],
            sunriseAt: "sadas"
        );
        var list = (forecast['forecastday'] as List<dynamic>);
        List<ForecastDay> forecastList = [];
        for (int i = 0; i < list.length; i++) {
            var element = list[i] as Map<String, dynamic>;
            var hours = element['hour'] as List<dynamic>;
            List<Hour> hoursList = [];
            for (int j = 0; j < hours.length; j++) {
                var hour = hours[j] as Map<String, dynamic>;
                hoursList.add(Hour(time: hour['time'], temperature: hour['temp_c'], condition: Condition(text: hour['condition']['text'], icon: "https:${hour['condition']['icon']}")));
            }
            forecastList.add(ForecastDay(astro: Astro(sunrise: element['astro']['sunrise']), hour: hoursList, day: Day(condition: Condition(icon: "https:${element['day']['condition']['icon']}", text: element['day']['condition']['text']), avgTemp: element['day']['avgtemp_c'])));
        }
        ForecastInfo forecastInfo = ForecastInfo(forecastDay: forecastList);
        LocationInfo locationInfo = LocationInfo(cityName: locationData['name']);
        return WeatherInfo(location: locationInfo, current: currentWeather, forecastInfo: forecastInfo);
    }
}