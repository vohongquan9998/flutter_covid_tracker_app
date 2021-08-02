import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/constrant/constant.dart';
import 'package:flutter_covid_tracker_app/models/country_virus_model.dart';
import 'package:flutter_covid_tracker_app/models/virus_model.dart';
import 'package:flutter_covid_tracker_app/src/chartPage.dart';
import 'package:flutter_covid_tracker_app/src/detailPage.dart';
import 'package:flutter_covid_tracker_app/src/mapWidget.dart';
import 'package:flutter_covid_tracker_app/widgets/drawerWidget.dart';
import 'package:flutter_covid_tracker_app/widgets/infomationCard.dart';
import 'package:flutter_covid_tracker_app/widgets/perventionCard.dart';
import 'package:flutter_covid_tracker_app/widgets/widgetCard.dart';
import 'package:flutter_covid_tracker_app/widgets/worldCardWidget.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {this.locationVirusData,
      this.virusData,
      this.countriesData,
      this.statesData});
  final virusData;
  final locationVirusData;
  final countriesData;
  final statesData;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VirusData data;
  CountryVirusData locationData;
  int index = 0;
  List<CountryVirusData> countriesData = [];
  bool isLight = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    updateUI(widget.virusData);
    updateLocationUI(widget.locationVirusData);
    updateCountriesUI(widget.countriesData);
    super.initState();
  }

  void updateUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        data = VirusData(
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
        );
        return;
      }

      data = VirusData(
          confirmedCases: virusData['cases'],
          recovered: virusData['recovered'],
          deaths: virusData['deaths'],
          active: virusData['active']);
    });
  }

  void updateCountriesUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
        );
        print('null');
        return;
      }
      for (var eachData in virusData) {
        final countryData = CountryVirusData(
            country: eachData['country'],
            confirmedCases: eachData['cases'],
            recovered: eachData['recovered'],
            deaths: eachData['deaths'],
            flagUrl: eachData['countryInfo']['flag'],
            active: eachData['active']);
        countriesData.add(countryData);
      }
    });
  }

  void updateLocationUI(dynamic virusData) {
    setState(() {
      if (virusData == null) {
        locationData = CountryVirusData(
          country: 'none',
          confirmedCases: 0,
          recovered: 0,
          deaths: 0,
          active: 0,
        );
        return;
      }

      locationData = CountryVirusData(
          country: virusData['country'],
          confirmedCases: virusData['cases'],
          recovered: virusData['recovered'],
          deaths: virusData['deaths'],
          active: virusData['active']);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
              color: isLight ? Colors.red : Colors.white.withOpacity(.9)),
          title: Text(
            "Theo dõi tình hình Covid-19",
            style: TextStyle(
              color: isLight ? Colors.red : Colors.white,
              fontSize: yMargin(2.5),
              fontFamily: 'Titillium',
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  isLight
                      ? AdaptiveTheme.of(context).setDark()
                      : AdaptiveTheme.of(context).setLight();
                  setState(() {
                    isLight = !isLight;
                  });
                })
          ],
        ),
        drawer: ClipPath(
          clipper: MyCustomClipper(),
          child: buildDrawer(context, isLight, widget),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: yMargin(3),
            ),
            Container(
              padding: EdgeInsets.only(
                left: xMargin(1),
                right: xMargin(1),
                top: yMargin(0.2),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: isLight
                        ? [Colors.grey[200], Colors.grey[400]]
                        : [Colors.indigo[200], Colors.indigo[600]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Wrap(
                  spacing: xMargin(3),
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: yMargin(2),
                  children: <Widget>[
                    InfoCard(
                      title: "Số ca nhiễm",
                      color: isLight ? Colors.red[400] : Colors.red[800],
                      effectedNum: locationData.confirmedCases,
                    ),
                    InfoCard(
                      title: "Số ca tử vong",
                      color: isLight ? Colors.grey : Colors.blueGrey[800],
                      effectedNum: locationData.deaths,
                      spot: "death",
                    ),
                    InfoCard(
                      title: "Số ca hồi phục",
                      color: isLight ? Colors.green[400] : Colors.green[900],
                      effectedNum: locationData.recovered,
                    ),
                    InfoCard(
                      title: "Đang điều trị",
                      color: isLight ? Colors.blue[400] : Colors.blue[800],
                      effectedNum: locationData.active,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: xMargin(4)),
                          child: TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChartsScreen(
                                  countryName: '${locationData.country}',
                                  cases: double.parse(
                                      '${locationData.confirmedCases}'),
                                  deaths:
                                      double.parse('${locationData.deaths}'),
                                  recovered:
                                      double.parse('${locationData.recovered}'),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Biểu đồ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        isLight ? Colors.black : Colors.white70,
                                  ),
                                ),
                                SizedBox(
                                  width: yMargin(2),
                                ),
                                SvgPicture.asset(
                                  "assets/icons/increase.svg",
                                  width: yMargin(2),
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width * .9,
                          height: xMargin(15),
                          decoration: BoxDecoration(
                            color: isLight ? Colors.indigo[200] : Colors.indigo,
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Đất nước: ${locationData.country}",
                                  style: TextStyle(fontSize: yMargin(2)),
                                ),
                                Text(
                                  "Lần cập nhật cuối: ${DateTime.now().toString().substring(0, 10)}",
                                  style: TextStyle(
                                    fontSize: yMargin(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            WorldCard(
              widget: widget,
              cases: data.confirmedCases,
              deaths: data.deaths,
              isLight: isLight,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: xMargin(5)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       TextButton(
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (BuildContext
            //                       context) /*=> AboutCovid()*/ {}));
            //         },
            //         child: WidgetCard(
            //           srcAsset: "assets/icons/virus.svg",
            //           title: "COVID-19",
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () => Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => MapsScreen(),
            //           ),
            //         ),
            //         child: WidgetCard(
            //             srcAsset: "assets/icons/live-map.svg",
            //             title: "Live Map"),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Container(
                    width: xMargin(20),
                    height: yMargin(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: xMargin(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isLight
                                    ? [Colors.grey[100], Colors.blueGrey[200]]
                                    : [Colors.grey[600], Colors.indigo[400]],
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Phoenix.rebirth(context);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: isLight ? Colors.indigo : Colors.white70,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: yMargin(1),
                        ),
                        Expanded(
                          child: Container(
                            width: xMargin(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isLight
                                    ? [Colors.grey[100], Colors.blueGrey[200]]
                                    : [Colors.grey[600], Colors.indigo[400]],
                              ),
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapsScreen(),
                                ),
                              ),
                              icon: Icon(
                                Icons.map,
                                color: isLight ? Colors.indigo : Colors.white70,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PreventionCard(
                  isLight: isLight,
                ),
              ],
            )
          ],
        ));
  }
}
