import 'package:flutter/material.dart';
import 'package:weatherapp/entity/WeatherInfo.dart';
import 'package:weatherapp/utils/GetWeatherInfo.dart';
import 'package:weatherapp/widgets/TodayHoursWeather.dart';
import 'package:weatherapp/widgets/WeatherPageView.dart';
import 'package:weatherapp/widgets/WeekForecastWeather.dart';

class HomePage extends StatefulWidget{
  final String position;
  const HomePage({super.key, required this.position});

  @override
  State<StatefulWidget> createState() => _HomePage(position: position);
}

class _HomePage extends State<HomePage> {
  final String _position;
  _HomePage({required String position}) : _position = position;

  WeatherInfo? _weatherInfo;

  @override
  void initState() {
    _getWeatherInfo(_position);
    super.initState();

  }



  void _getWeatherInfo(String position) async {
    _weatherInfo = await GetWeatherInfo(position: position).getWeatherInfo();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_weatherInfo == null)
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                  height: 350,
                  child: WeatherPageView(weatherInfo: _weatherInfo!)
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(childCount: 1, (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: const Text("Почасовой прогноз",style: TextStyle(fontSize: 28)),
              );
            }
            )
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 180,
                child: TodayHoursWeather(weatherInfo: _weatherInfo!),
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(childCount: 1, (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: const Text("Прогноз на неделю",style: TextStyle(fontSize: 28)),
              );
            }
            )
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 180,
                child: WeekForecastWeather(weatherInfo: _weatherInfo!,),
              ),
            ),
          ],
        )
    );
  }

}