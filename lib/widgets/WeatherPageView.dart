import 'package:flutter/material.dart';
import 'package:weatherapp/entity/WeatherInfo.dart';

class WeatherPageView extends StatefulWidget {
  const WeatherPageView({super.key, required this.weatherInfo});
  final WeatherInfo weatherInfo;
  @override
  State<WeatherPageView> createState() => _WeatherPageViewState(weatherInfo: weatherInfo);
}

class _WeatherPageViewState extends State<WeatherPageView>
    with TickerProviderStateMixin {
  final WeatherInfo weatherInfo;
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;


  _WeatherPageViewState({required this.weatherInfo});
  @override
  void initState() {
    super.initState();

    _pageViewController = PageController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  Widget _getWindDirectionItem(String windDirect) {
    String windDirection;
    IconData iconDirection;
    switch(windDirect) {
      case 'N':{
        windDirection = "Ветер северный";
        iconDirection = Icons.north;
        break;
      }
      case 'NNE':{
        windDirection = "Ветер северный";
        iconDirection = Icons.north;
        break;
      }
      case 'NE':{
        windDirection = "Ветер северо-восточный";
        iconDirection = Icons.north_east;
        break;
      }
      case 'ENE':{
        windDirection = "Ветер северо-восточный";
        iconDirection = Icons.north_east;
        break;
      }
      case 'E':{
        windDirection = "Ветер восточный";
        iconDirection = Icons.east;
        break;
      }
      case 'ESE':{
        windDirection = "Ветер восточный";
        iconDirection = Icons.east;
        break;
      }
      case 'SE':{
        windDirection = "Ветер юго-восточный";
        iconDirection = Icons.south_east;
        break;
      }
      case 'SSE':{
        windDirection = "Ветер юго-восточный";
        iconDirection = Icons.south_east;
        break;
      }
      case 'S':{
        windDirection = "Ветер южный";
        iconDirection = Icons.south;
        break;
      }
      case 'SSW':{
        windDirection = "Ветер южный";
        iconDirection = Icons.south;
        break;
      }
      case 'SW':{
        windDirection = "Ветер юго-западный";
        iconDirection = Icons.south_west;
        break;
      }
      case 'WSW':{
        windDirection = "Ветер юго-западный";
        iconDirection = Icons.south_west;
        break;
      }
      case 'W':{
        windDirection = "Ветер западный";
        iconDirection = Icons.west;
        break;
      }
      case 'WNW':{
        windDirection = "Ветер западный";
        iconDirection = Icons.west;
        break;
      }
      case 'NW':{
        windDirection = "Ветер северо-западный";
        iconDirection = Icons.north_west;
        break;
      }
      case 'NNW':{
        windDirection = "Ветер северо-западный";
        iconDirection = Icons.north_west;
        break;
      }
      default: {
        windDirection = "Невозможно определить направление ветра";
        iconDirection = Icons.not_interested;
        break;
      }
    }
    return _getMoreInfoMenu("$windDirection, ${(weatherInfo.current.windSpeed / 3.6).toStringAsFixed(1)} м/c", iconDirection);
  }

  Widget _getMoreInfoMenu(String title, IconData icon) {
    return Row(
      children: [
        SizedBox(width: 5),
        Row(
          children: [
            Icon(icon)
          ],
        ),
        SizedBox(width: 25),
        Row(
          children: [
            Text(title, textAlign: TextAlign.start,)
          ],
        )
      ],
    );
  }
  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(

          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: <Widget>[

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${weatherInfo.location.cityName}", style: TextStyle(fontSize: 18)),
                  Text("${weatherInfo.current.temperature} °C", style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold)),
                  Text("${weatherInfo.current.condition.text}"),
                  Text("По ощущению: ${weatherInfo.current.feelsLike.toStringAsFixed(0)} °C")
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getWindDirectionItem(weatherInfo.current.windDirection),
                _getMoreInfoMenu("Влажность: ${weatherInfo.current.humidity}%", Icons.water_drop),
                _getMoreInfoMenu("Давление: ${weatherInfo.current.pressure} мбар", Icons.access_alarm),
                _getMoreInfoMenu("Восход в ${weatherInfo.forecastInfo.forecastDay[0].astro.sunrise.split(" ")[0]}", Icons.sunny),
                _getMoreInfoMenu("УФ-Индекс: ${weatherInfo.current.uvIndex}", Icons.accessibility_rounded)
              ],
            ),



          ],
        ),
        PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex
        )
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TabPageSelector(
            indicatorSize: 8,
            controller: tabController,
            color: colorScheme.surface,
            selectedColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}