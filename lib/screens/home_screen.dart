import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Icon(Icons.add, size: 32.0, color: Colors.white),
        onPressed: () {
          /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeNav()));*/
        },
      ),
    );
  }
}
