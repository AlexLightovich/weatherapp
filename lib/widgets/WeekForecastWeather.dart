import 'package:flutter/material.dart';
import 'package:weatherapp/entity/WeatherInfo.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
class WeekForecastWeather extends StatefulWidget {

  const WeekForecastWeather({super.key, required this.weatherInfo});
  final WeatherInfo weatherInfo;
  @override
  State<StatefulWidget> createState() => _WeekForecastWeather(weatherInfo: weatherInfo);

}

Container _createWeekCard(String degrees, String icon, String time) {
  return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(time),
                    const Padding(padding: EdgeInsets.all(10)),
                    Image.network(icon, height: 32, width: 32),
                    const Padding(padding: EdgeInsets.all(10)),
                    Text(degrees),
                  ],

                ),
              )
          )
        ],
      )
  );
}

class _WeekForecastWeather extends State<WeekForecastWeather> {

  final WeatherInfo _weatherInfo;
  _WeekForecastWeather({required WeatherInfo weatherInfo}) : _weatherInfo = weatherInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting('ru');
  }
  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListView.separated(
        itemCount: _weatherInfo.forecastInfo.forecastDay.length,
        separatorBuilder: (context, index) => Divider(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _createWeekCard(
              "${_weatherInfo.forecastInfo.forecastDay[index].day.avgTemp.toStringAsFixed(0)} °C",
              _weatherInfo.forecastInfo.forecastDay[index].day.condition.icon,
              DateFormat("EEE", "ru").format(DateFormat("yyyy-MM-dd HH:mm").parse(_weatherInfo.forecastInfo.forecastDay[index].hour[0].time)));
        }

      ),
    );
  }

}