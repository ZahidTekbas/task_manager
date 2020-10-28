import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:task_manager/constants/shared_pref_functions.dart';
import 'package:task_manager/models/app_builder.dart';
import 'package:task_manager/screens/persistent_nav_bar.dart';
import 'package:task_manager/screens/welcome_screen.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashScreen(
          title: Text('Welcome Task Manager', style: TextStyle(fontSize: 32.0)),
          loaderColor: Colors.blue[100],
          seconds: 3,
          navigateAfterSeconds:
              login == true ? BottomNavBar() : WelcomeScreen(),
        ),
      ),
    );
  }
}
