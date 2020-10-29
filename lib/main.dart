import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:task_manager/constants/shared_pref_functions.dart';
import 'package:task_manager/models/app_builder.dart';
import 'package:task_manager/screens/persistent_nav_bar.dart';
import 'package:task_manager/screens/welcome_screen.dart';

import 'constants/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Task Manager'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool login;
  @override
  void initState() {
    getLogin().then((value) => {
          setState(() {
            login = value;
          }),
        });
    getDarkThemeChoice().then((value) => {
          if (value == true)
            {
              setState(() {
                darkThemeEnabled = true;
              }),
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkThemeEnabled ? Colors.black : Colors.white,
      body: Center(
        child: SplashScreen(
          backgroundColor: darkThemeEnabled ? Colors.black : Colors.white ,
          title: darkThemeEnabled
              ? Text('Welcome Task Manager but Darker!', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, color: Colors.white))
              : Text('Welcome Task Manager',
                  style: darkThemeEnabled
                      ? headerTwoStyleDark
                      : headerTwoStyleLight),
          loaderColor: darkThemeEnabled ? Colors.blue[100] : Colors.grey,
          seconds: 3,
          navigateAfterSeconds:
              login == true ? BottomNavBar() : WelcomeScreen(),
        ),
      ),
    );
  }
}
