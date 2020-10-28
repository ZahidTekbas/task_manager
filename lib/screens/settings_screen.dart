import 'package:flutter/material.dart';
import 'package:task_manager/constants/shared_pref_functions.dart';
import 'package:task_manager/constants/theme.dart';
import 'package:task_manager/models/app_builder.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  toggleTheme() {
    setState(() {
      darkThemeEnabled = !darkThemeEnabled;
    });
  }

  String username;

  @override
  void initState() {
    getUserName().then((value) => {
          setState(() {
            username = value;
          }),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.all(16.0),
              color: Colors.white,
              child: ListTile(
                title: Center(child: Text('$username', style: tileStyleLight,)),
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png'),
                ), // CachedNetworkImageProvider
                trailing: Icon(Icons.edit),
              ),
            ),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SwitchListTile(
                    title: Text('Dark Mode', style: tileStyleLight),
                    activeColor: Colors.blue[200],
                    inactiveTrackColor: Colors.grey,
                    value: darkThemeEnabled,
                    onChanged: (value) {
                      toggleTheme();
                      setState(() {
                        AppBuilder.of(context).rebuild();
                        setState(() {});
                      });
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {}, // action
                    title: Text('Privacy Policy',style: tileStyleLight),
                    leading: Icon(Icons.perm_device_information),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    onTap: () {}, // action
                    title: Text('Terms & Conditions',style: tileStyleLight),
                    leading: Icon(Icons.info),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    onTap: () {}, // action
                    title: Text('About Task Manager',style: tileStyleLight),
                    leading: Icon(Icons.insert_drive_file),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    onTap: () {}, // action
                    title: Text('Exit',style: tileStyleLight),
                    leading: Icon(Icons.exit_to_app),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
