import 'package:flutter/material.dart';

class Myconstant {
  //Genernal
  static String appName = 'Fram Mall';

  //Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeUser = '/User';
  static String routeAdmin = '/Admin';

  //image
  static String image1 = 'images/image01.png';
  static String image2 = 'images/image02.png';
  static String image3 = 'images/image03.png';
  static String image4 = 'images/image04.png';
  static String avata = 'images/avata.png';

  //color
  static Color primary = Color(0xffffa600);
  static Color light = Color(0xffffd74a);
  static Color dark = Color(0xffc67700);

  //Style
  TextStyle h1style() =>
      TextStyle(fontSize: 24, color: dark, fontWeight: FontWeight.bold);

  TextStyle h2style() =>
      TextStyle(fontSize: 18, color: dark, fontWeight: FontWeight.w700);

  TextStyle h3style() =>
      TextStyle(fontSize: 14, color: dark, fontWeight: FontWeight.normal);

  //ButtonStyle
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: Myconstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
  //Account
  
}
