import 'package:flutter/material.dart';
import 'package:project_flutter/screen/authen.dart';
import 'package:project_flutter/screen/category.dart';
import 'package:project_flutter/screen/create.dart';
import 'package:project_flutter/screen/myservice.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => Create(),
  '/myservice': (BuildContext context) => Myservice(),
  '/Category': (BuildContext context) => Category(),
};
