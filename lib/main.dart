import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/states/admin.dart';
import 'package:project_flutter/states/authen.dart';
import 'package:project_flutter/states/create.dart';
import 'package:project_flutter/states/myservice.dart';
import 'package:project_flutter/utillity/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => Create(),
  '/myservice': (BuildContext context) => Myservice(),
  '/Admin': (BuildContext context) => Admin(),
};

String? initlaRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initlaRoute = Myconstant.routeMyservice;
      }
      runApp(MyApp());
    });
  });
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
