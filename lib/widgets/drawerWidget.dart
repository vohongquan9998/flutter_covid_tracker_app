import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/constrant/constant.dart';
import 'package:flutter_covid_tracker_app/src/countryPage.dart';
import 'package:flutter_covid_tracker_app/src/detailPage.dart';
import 'package:flutter_covid_tracker_app/src/mapWidget.dart';
import 'package:flutter_covid_tracker_app/src/prevention.dart';
import 'package:flutter_covid_tracker_app/widgets/perventionCard.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

Drawer buildDrawer(context, isLight, widget) {
  return Drawer(
    child: SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Center(
                child: Image.asset(
                  isLight ? "assets/covid_black.png" : "assets/covid_white.png",
                  width: 160,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home,
                          color: isLight ? Colors.black : Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Trang chính",
                        style: TextStyle(fontSize: yMargin(2.5)),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CountriesInfoScreen(
                          countryVirusData: widget.countriesData,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeScaleTransition(
                              animation: animation, child: child);
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.flag,
                          color: isLight ? Colors.black : Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Thế giới",
                        style: TextStyle(fontSize: yMargin(2.5)),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapsScreen(),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/live-map.svg",
                        height: yMargin(3.3),
                        color: isLight ? Colors.black : Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Bản đồ",
                        style: TextStyle(fontSize: yMargin(2.5)),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PreventionScreen()));
                  },
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/virus.svg",
                        height: yMargin(3.3),
                        color: isLight ? Colors.black : Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Thông tin về Covid-19",
                        style: TextStyle(fontSize: yMargin(2.5)),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Phoenix.rebirth(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.refresh,
                        color: isLight ? Colors.black : Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Cập nhật lại dữ liệu",
                        style: TextStyle(fontSize: yMargin(2.5)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width * 0.8, 0);
    path.quadraticBezierTo(
        280, size.height * 0.6, size.width * .5, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
