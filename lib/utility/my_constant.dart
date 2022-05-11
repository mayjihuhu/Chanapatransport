import 'package:flutter/material.dart';

class MyConstant {
//field
  static Color primary = Color.fromARGB(255, 255, 9, 9);
  static Color dark = Color.fromARGB(255, 210, 26, 5);
  static Color light = Color.fromARGB(255, 143, 106, 24);
  static Color orang = Color.fromARGB(255, 248, 200, 182);

  static List<String> typeUsers = [
    'Owner',
    'Customer',
    'Driver',
  ];

  static String pathRegister =
      'https://www.rollerglobal.com/api/api/Member/register';
  static String pathAuthen =
      'https://www.rollerglobal.com/api/api/Member/login';
//method

  BoxDecoration curveBorderBox() => BoxDecoration(
        border: Border.all(color: MyConstant.dark),
        borderRadius: BorderRadius.circular(30),
      );

  //BoxDecoration planBox() => BoxDecoration(color: light.withOpacity(0.5));
  BoxDecoration imagebox() => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bk.jpg'),
          fit: BoxFit.cover,
          opacity: (0.4),
        ),
      );

  BoxDecoration planBox() => const BoxDecoration(
      color: Color.fromARGB(255, 248, 200, 182)); //Backgroud

  TextStyle h1Style() {
    return TextStyle(color: primary, fontSize: 36, fontWeight: FontWeight.bold);
  }

  TextStyle h2Style() {
    return TextStyle(
      color: dark,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(color: light, fontSize: 15, fontWeight: FontWeight.normal);
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h4Style() {
    return TextStyle(
      color: Color.fromARGB(255, 224, 95, 16),
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );
  }
} //class
