import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/constrant/constant.dart';
import 'package:flutter_covid_tracker_app/src/prevention.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreventionCard extends StatelessWidget {
  final bool isLight;
  const PreventionCard({
    Key key,
    this.isLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          return Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 600),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  PreventionScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.scaled,
                );
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: xMargin(4), vertical: yMargin(1)),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                    left: xMargin(0),
                    top: yMargin(2),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: isLight
                            ? [Colors.grey[300], Colors.blueGrey[400]]
                            : [Colors.grey[600], Colors.indigo[400]]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/icons/undraw-home-promo-symptoms.png",
                          width: xMargin(30),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Thông điệp 5K",
                            style: TextStyle(
                              fontSize: yMargin(3),
                              color: isLight ? Colors.indigo : Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: yMargin(1),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: xMargin(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Khẩu trang\nKhử khuẩn\nKhông tụ tập",
                                  style: TextStyle(
                                      color: isLight
                                          ? Colors.black.withOpacity(.9)
                                          : Colors.white.withOpacity(.9)),
                                ),
                                Text(
                                  "Khai báo y tế\nKhoảng cách",
                                  style: TextStyle(
                                      color: isLight
                                          ? Colors.black.withOpacity(.9)
                                          : Colors.white.withOpacity(.9)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: yMargin(2),
                          ),
                        ],
                      ),
                    ],
                  )),

              // Positioned(
              //   top: yMargin(2),
              //   right: xMargin(15),
              //   child: SvgPicture.asset(
              //     "assets/icons/hand-wash.svg",
              //     height: yMargin(3.5),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
