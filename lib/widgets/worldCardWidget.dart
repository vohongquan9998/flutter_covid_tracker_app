import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/constrant/constant.dart';
import 'package:flutter_covid_tracker_app/src/countryPage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorldCard extends StatelessWidget {
  final bool isLight;
  final widget;
  final cases;
  final deaths;
  const WorldCard({Key key, this.widget, this.cases, this.deaths, this.isLight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                CountriesInfoScreen(
              countryVirusData: widget.countriesData,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeScaleTransition(animation: animation, child: child);
            },
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: xMargin(4), vertical: yMargin(1)),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                    left: xMargin(1),
                    top: yMargin(1),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: isLight
                            ? [Colors.grey[100], Colors.grey[400]]
                            : [Colors.indigo[200], Colors.indigo[600]]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/icons/PlainMap.png",
                        height: yMargin(18),
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        top: yMargin(7),
                        right: xMargin(4.5),
                        child: Image.asset(
                          "assets/icons/fever.png",
                          height: yMargin(10),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isLight
                                ? Colors.grey[100].withOpacity(.9)
                                : Colors.indigo[200].withOpacity(.9),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Tổng trên toàn thế giới",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: yMargin(1.7),
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Số ca: $cases\nTử vong: $deaths",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: yMargin(1.8),
                                      color: isLight
                                          ? Colors.black
                                          : Colors.indigo[900]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
