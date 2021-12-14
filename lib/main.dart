import 'package:flutter/material.dart';
import 'package:project_flutter/states/admin.dart';
import 'package:project_flutter/states/authen.dart';
import 'package:project_flutter/states/create.dart';
import 'package:project_flutter/states/user.dart';
import 'package:project_flutter/utillity/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => Create(),
  '/User': (BuildContext context) => User(),
  '/Admin': (BuildContext context) => Admin(),
};

String? initlaRoute;

void main() {
  initlaRoute = Myconstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Myconstant.appName,
      routes: map,
      initialRoute: initlaRoute,
    );
  }
}
