import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_manager/constants/shared_pref_functions.dart';
import 'package:task_manager/constants/theme.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/persistent_nav_bar.dart';
import 'package:task_manager/widgets/android/android_alert.dart';
import 'package:task_manager/widgets/ios/ios_alert.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue[100],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('How do you call yourself?', style: headerTwoStyleLight),
                SizedBox(height: 32.0),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'A unicorn',
                  ),
                ),
                SizedBox(height: 64.0),
                FlatButton(
                    onPressed: () {
                      if (controller.text == '') {
                        if (Platform.isAndroid) {
                          showCustomDialogAndroid(context,
                              'You have to enter your name in order to continue');
                        } else {
                          showCustomDialogiOS(context,
                              'You have to enter your name in order to continue');
                        }
                      } else {
                        setLogin(controller.text).then((value) => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavBar()),
                                  ModalRoute.withName("/HomeScreen")),
                            });
                      }
                    },
                    child: Text('Continue'),
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              ],
            ),
          ),
        ));
  }
}
