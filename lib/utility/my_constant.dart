import 'package:flutter/material.dart';

class MyConstant {
//field
  static Color primary = Color.fromARGB(255, 255, 9, 9);
  static Color dark = Color.fromARGB(255, 210, 26, 5);
  static Color light = Color.fromARGB(255, 223, 180, 88);

  static List<String> typeUsers = [
    'Owner',
    'Customer',
    'Driver',
  ];

//method

  BoxDecoration curveBorderBox() => BoxDecoration(
    border: Border.all(color: MyConstant.dark),
  borderRadius: BorderRadius.circular(30),

  );

  //BoxDecoration planBox() => BoxDecoration(color: light.withOpacity(0.5));
  BoxDecoration imagebox() => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/zombie_BK1.png'),
        ),
      );

  BoxDecoration planBox() => const BoxDecoration(
      color: Color.fromARGB(255, 247, 195, 204)); //Backgroud

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
} //class
