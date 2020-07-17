import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '32971d451ee41e5dc0f8fb815b587171';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocationData() async {
    Location locationObject = Location();

    await locationObject.getCurrentLocation();

    latitude = locationObject.latitude;
    print(latitude);
    longitude = locationObject.longitude;
    print(latitude);

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    print('hmm');
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blue,
          size: 100.0,
        ),
      ),
    );
  }
}
