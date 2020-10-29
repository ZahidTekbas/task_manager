import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/constants/shared_pref_functions.dart';
import 'package:task_manager/constants/theme.dart';
import 'package:task_manager/main.dart';
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

  TextEditingController newNameController = TextEditingController();
  String username;
  String newUsername;

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
  void dispose() {
    newNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          darkThemeEnabled ? backgroundColorDark : backgroundColorLight,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: darkThemeEnabled
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(16.0),
                color: darkThemeEnabled ? cardColorDark : cardColorLight,
                child: ListTile(
                  title: Center(
                      child: Text(
                    '$username',
                    style: darkThemeEnabled ? tileStyleDark : tileStyleLight,
                  )),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png'),
                  ), // CachedNetworkImageProvider
                  trailing: GestureDetector(
                    onTap: () {
                      showEditProfileNameDialog();
                    },
                    child: Icon(Icons.edit,
                        color:
                            darkThemeEnabled ? iconColorLight : iconColorDark),
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(16.0),
                color: darkThemeEnabled ? cardColorDark : cardColorLight,
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      title: Text('Dark Mode',
                          style: darkThemeEnabled
                              ? tileStyleDark
                              : tileStyleLight),
                      activeColor: Colors.blueGrey,
                      inactiveTrackColor: Colors.grey,
                      value: darkThemeEnabled,
                      onChanged: (value) {
                        toggleTheme();
                        setDarkThemeChoice(value);
                        setState(() {
                          AppBuilder.of(context).rebuild();
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        });
                      },
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
                color: darkThemeEnabled ? cardColorDark : cardColorLight,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {}, // action
                      title: Text('Privacy Policy',
                          style: darkThemeEnabled
                              ? tileStyleDark
                              : tileStyleLight),
                      leading: Icon(Icons.perm_device_information,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                      trailing: Icon(Icons.arrow_forward,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      onTap: () {}, // action
                      title: Text('Terms & Conditions',
                          style: darkThemeEnabled
                              ? tileStyleDark
                              : tileStyleLight),
                      leading: Icon(Icons.info,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                      trailing: Icon(Icons.arrow_forward,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      onTap: () {}, // action
                      title: Text('About Task Manager',
                          style: darkThemeEnabled
                              ? tileStyleDark
                              : tileStyleLight),
                      leading: Icon(Icons.insert_drive_file,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                      trailing: Icon(Icons.arrow_forward,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      onTap: () {}, // action
                      title: Text('Exit',
                          style: darkThemeEnabled
                              ? tileStyleDark
                              : tileStyleLight),
                      leading: Icon(Icons.exit_to_app,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                      trailing: Icon(Icons.arrow_forward,
                          color: darkThemeEnabled
                              ? iconColorLight
                              : iconColorDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showEditProfileNameDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor:
                darkThemeEnabled ? backgroundColorDark : backgroundColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 200.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Change your name to',
                        style:
                            darkThemeEnabled ? tileStyleDark : tileStyleLight),
                    TextField(
                      style: darkThemeEnabled ? tileStyleDark : tileStyleLight,
                      controller: newNameController,
                      onChanged: (newText) {
                        newUsername = newText;
                      },
                      autofocus: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '$username',
                        hintStyle:
                            darkThemeEnabled ? tileStyleDark : tileStyleLight,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          color:
                              darkThemeEnabled ? fabButtonDark : fabButtonLight,
                          child: Text('CANCEL',
                              style: darkThemeEnabled
                                  ? tileStyleDark
                                  : tileStyleLight),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          color:
                              darkThemeEnabled ? fabButtonDark : fabButtonLight,
                          child: Text('OK',
                              style: darkThemeEnabled
                                  ? tileStyleDark
                                  : tileStyleLight),
                          onPressed: () {
                            if (newNameController.text == '') {
                            } else {
                              setLogin(newNameController.text);
                              setState(() {
                                username = newNameController.text;
                              });
                              newNameController.clear();
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
