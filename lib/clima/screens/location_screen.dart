import 'package:flutter/material.dart';
import 'package:navigation/home.dart';
import '../utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen(this.locationWeather, {Key? key}) : super(key: key);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late DateFormat dateFormat;

  late int temp;
  late String city;
  late String description;
  late double windSpeed;
  late int humidity;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMMd('en');
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temp = 0;
      city = 'Undefined';
      description = '';
      windSpeed = 0;
      humidity = 0;
      return;
    }
    double kelvinTemp = weatherData['main']['temp'];
    temp = kelvinTemp.toInt() - 273;
    city = weatherData['name'];
    description = weatherData['weather'][0]['main'];
    windSpeed = weatherData['wind']['speed'];
    humidity = weatherData['main']['humidity'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Home())),
            ),
            title: const Text('Climate')),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment(1.0, -1.0),
                    image: ExactAssetImage('assets/vector.png')),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: <Color>[Color(0xFF47BFDF), Color(0xFF4A91FF)],
                )),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 40),
                          child: Image.asset(
                            'assets/map-pin.png',
                            scale: 0.8,
                          )),
                      Text(city, style: cityTextStyle)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: description == 'Clear'
                      ? Image.asset(
                          'assets/sun.png',
                          width: 165,
                          height: 165,
                        )
                      : description == 'Clouds'
                          ? Image.asset('assets/cloud.png')
                          : description == 'Rain'
                              ? Image.asset('assets/rain.png')
                              : description == 'Snow'
                                  ? Image.asset('assets/snow.png')
                                  : Image.asset(''),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 31),
                  constraints: const BoxConstraints(
                    minHeight: 300.0,
                    minWidth: 353.0,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 2,
                          color: const Color(0xFFFFFFFF).withOpacity(0.3))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                            'Today, ' + dateFormat.format(DateTime.now()),
                            style: currentDayTextStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 30),
                        child: Text(
                          '$temp°',
                          style: tempTextStyle,
                        ),
                      ),
                      Text(
                        description,
                        style: cityTextStyle,
                      ),
                      SizedBox(
                        width: 210,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Image.asset(
                                  'assets/wind.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                            Text('Wind', style: currentDayTextStyle),
                            Text('|', style: currentDayTextStyle),
                            Text('$windSpeed km/h', style: currentDayTextStyle)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 210,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Image.asset('assets/humidity.png'),
                              ),
                            ),
                            Text('Humidity', style: currentDayTextStyle),
                            Text('|', style: currentDayTextStyle),
                            Text('$humidity%', style: currentDayTextStyle)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            )));
  }
}
