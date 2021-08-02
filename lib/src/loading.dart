import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/constrant/constant.dart';
import 'package:flutter_covid_tracker_app/provider/api_provider.dart';
import 'package:flutter_covid_tracker_app/src/homepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/loading';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  ApiData apiData = ApiData();

  @override
  void initState() {
    super.initState();
    getAndSetData();
    HomePage();
  }

  void getAndSetData() async {
    var data = await apiData.getVirusData();
    var locationData = await apiData.getLocationVirusData();
    var countriesData = await apiData.getCountriesVirusData();
    var statesData = await apiData.getStatesData();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(
            countriesData: countriesData,
            locationVirusData: locationData,
            virusData: data,
            statesData: statesData,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeScaleTransition(animation: animation, child: child);
          },
        ));
  }

  final spinKit1 = SpinKitPumpingHeart(
    size: 50,
    color: Colors.red,
    // itemBuilder: (BuildContext context, int index) {
    //   return DecoratedBox(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(50),
    //       color: Colors.red,
    //     ),
    //   );
    // },
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset("assets/icons/covidspash.png",
                height: yMargin(22), fit: BoxFit.fill),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Hệ thống đang xử lý...\n',
                style: TextStyle(fontSize: yMargin(3)),
              ),
              Center(child: spinKit1),
            ],
          ),
        ],
      ),
    );
  }
}
