import 'package:flutter/material.dart';
import 'package:project_flutter/utillity/my_constant.dart';
import 'package:project_flutter/widgets/show_image.dart';
import 'package:project_flutter/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            BuildImage(size),
            buildAppName(),
          ],
        ),
      ),
    );
  }

  Row buildAppName() {
    return Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: Myconstant.appName,
                textStyle: Myconstant().h1style(),
              ),
            ],
          );
  }

  Row BuildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: size * 0.75, child: ShowImage(pathImage: Myconstant.image1)),
      ],
    );
  }
}
