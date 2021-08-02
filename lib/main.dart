import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/src/loading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: 'google'),
      dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          fontFamily: 'google'),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: LoadingScreen(),
      ),
    );
  }
}
