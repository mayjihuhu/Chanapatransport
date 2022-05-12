// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:chanatran/models/authen_model.dart';
import 'package:chanatran/models/success_authen_model.dart';
import 'package:chanatran/states/authen.dart';
import 'package:chanatran/states/my_service.dart';
import 'package:chanatran/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/myService': (context) => const MyService(),
};

String? firstState; //หน้าแรกเป็น Null

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString(MyConstant.keyToken);
  print('## token at main ==> $token');

  if (token?.isEmpty ?? true) {
    firstState = '/authen';
    runApp(const MyApp());
  } else {
    AuthenModel authenModel = AuthenModel(
        rollerid: preferences.getString(MyConstant.keyRollerId)!,
        username: preferences.getString(MyConstant.keyUserName)!,
        password: preferences.getString(MyConstant.keyPassword)!);

    await Dio()
        .post(MyConstant.pathAuthen, data: authenModel.toMap())
        .then((value) async {
      SuccessAuthenModel successAuthenModel =
          SuccessAuthenModel.fromJson(value.data);
      String newToken = successAuthenModel.responseData![0].token.toString();
      print('newToken ==> $newToken');

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(MyConstant.keyToken, newToken).then((value){
        firstState = '/myService';
        runApp(const MyApp());
      });
    });
  }

  
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState ?? '/authen',
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
