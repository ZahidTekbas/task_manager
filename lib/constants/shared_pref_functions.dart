import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('name')) {
    return await true;
  } else {
    return await false;
  }
}

Future<bool> setLogin(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = await prefs.setString('name', name);
  return result;
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('name');
  print(name);
  return name;
}
