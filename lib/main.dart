import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:task_manager/screens/persistent_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Task Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: SplashScreen(
          title: Text('Welcome Task Manager', style: TextStyle(fontSize: 32.0)),
          loaderColor: Colors.blue[100],
          seconds: 3,
          navigateAfterSeconds: BottomNavBar(),
        ),
      ),
    );
  }
}
