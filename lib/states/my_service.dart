// ignore_for_file: prefer_const_constructors, unused_import

import 'package:chanatran/bodys/get_location.dart';
import 'package:chanatran/bodys/read_api_token.dart';
import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/utility/my_dialog.dart';
import 'package:chanatran/utility/show_listtile.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String? token;
  var widgets = <Widget>[];
  int indexWidget = 0;
  bool load = true;

  @override
  void initState() {
    super.initState();
    findToken();
  }

  Future<void> findToken() async {
    print('work');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString(MyConstant.keyToken);
    print('## token ที่ใช้งาน ==> $token');
    widgets.add(ReadApiToken(
      token: token!,
    ));
    widgets.add(const GetLocationShowMap());
    load = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowText(
          lable: 'My Service',
          textStyle: MyConstant().h2Style(),
        ),
        elevation: 0,
        foregroundColor: MyConstant.dark,
        backgroundColor: MyConstant.orang,
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      indexWidget = 0;
                    });
                  },
                  child: ShowListTile(
                    title: 'ReadAPI',
                    subTitle: 'Read API by Token',
                    path: 'images/API.png',
                    size: 36,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      indexWidget = 1;
                    });
                  },
                  child: ShowListTile(
                    title: 'GetLocaion  ',
                    subTitle: 'Get Location and show Map',
                    path: 'images/map.png',
                    size: 36,
                  ),
                )
              ],
            ),
            newSingOunt(context: context),
          ],
        ),
      ),
      body: load
          ? Center(child: CircularProgressIndicator())
          : widgets[indexWidget],
    );
  }

  Column newSingOunt({required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        InkWell(
          onTap: () {
            MyDialog(context: context).twoWayDialog(
                title: 'Confirm Singout',
                subtitle: 'Are you Sure ?',
                label1: 'Singout',
                label2: 'Cancel',
                pressFunc1: () {
                  processSigOut(context: context);
                },
                pressFunc2: () {});
          },
          child: ShowListTile(
              size: 48,
              title: 'Sing Out',
              subTitle: 'Sing Out and Move To Authen',
              path: 'images/logout.png'),
        ),
      ],
    );
  }

  Future<void> processSigOut({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
    });
  }
}
