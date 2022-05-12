// ignore_for_file: avoid_print, duplicate_ignore, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:chanatran/models/response_false_model.dart';
import 'package:chanatran/models/response_true_model.dart';
import 'package:chanatran/models/user_model.dart';
import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/utility/my_dialog.dart';
import 'package:chanatran/widges/show_botton.dart';
import 'package:chanatran/widges/show_form.dart';
import 'package:chanatran/widges/show_from_phone.dart';
import 'package:chanatran/widges/show_image.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? yearRegis, gentype = 'M', phonenumber, ifriedid = '';

  @override
  void initState() {
    super.initState();
    findYear();
  }

  void findYear() {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year + 543;
    yearRegis = year.toString();
    print('yearRegis = $yearRegis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          lable: 'สมัครสมาชิก ผ่าน Server',
          textStyle: MyConstant().h2Style(),
        ),
        elevation: 0,
        foregroundColor: MyConstant.dark,
        backgroundColor: MyConstant.orang,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Container(
          decoration: MyConstant().planBox(), //พื้นหลัง
          child: Center(
            child: LayoutBuilder(builder: (context, Constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: Constraints.maxWidth * 0.75,
                      child: const ShowImage(
                        path: 'images/register.png',
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: ShowText(
                        lable: 'Year = $yearRegis',
                        textStyle: MyConstant().h4Style(),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: ShowText(
                        lable: 'GenType = $gentype',
                        textStyle: MyConstant().h4Style(),
                      ),
                    ),
                    ShowFormPhone(
                      label: 'Phone :',
                      iconData: Icons.phone_android,
                      changeFunc: (String string) {
                        phonenumber = string.trim();
                      },
                    ),
                    ShowBotton(
                        label: 'Register',
                        pressFunc: () {
                          if (phonenumber?.isEmpty ?? true) {
                            MyDialog(context: context).normalDialog(
                                title: 'Phone ?', subTitle: 'Please Phone');
                          } else if (phonenumber!.length != 10) {
                            MyDialog(context: context).normalDialog(
                                title: 'Phoe 10 digit',
                                subTitle: 'Please Phone 10 digit');
                          } else if (phonenumber!.contains(' ')) {
                            MyDialog(context: context).normalDialog(
                                title: 'มีช่องว่างแทรก',
                                subTitle: 'ห้ามมีช่องว่างแทรก');
                          } else {
                            processRegister();
                          }
                        })
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> processRegister() async {
    // ignore: avoid_print
    print('phonenumber ==> $phonenumber');
    UserModel userModel = UserModel(
        year: yearRegis!,
        gentype: gentype!,
        phonenumber: phonenumber!,
        infriendid: '');

    Map<String, dynamic> map = userModel.toMap();
    print('map ==> $map');

    await Dio().post(MyConstant.pathRegister, data: map).then((value) {
      print('Suscess Register value ==> $value');

      ResponseFalseModel responseFalseModel =
          ResponseFalseModel.fromMap(value.data);

      print('responseFalseModel ==> ${responseFalseModel.toMap()}');

      if (responseFalseModel.ResponseStatus == 'Failed') {
        MyDialog(context: context).normalDialog(
            title: 'Cannot Register ',
            subTitle: responseFalseModel.ResponseMessages);
      } else {
        //register Success

        print('Register Success value ==> $value');

        ResponseTrueModel responseTrueModel =
            ResponseTrueModel.fromJson(value.data);

        print('responsTrueModel ===> ${responseTrueModel.toJson()}');

        MyDialog(context: context).normalDialog(
            title: 'Your Login',
            subTitle: 'โปรดเก็บค่านี้ไว้ Login',
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShowText(
                    lable:
                        'rollerid ==> ${responseTrueModel.responseData![0].rollerid}'),
                ShowText(
                    lable:
                        'username ==> ${responseTrueModel.responseData![0].username}'),
                ShowText(
                    lable:
                        'password ==> ${responseTrueModel.responseData![0].password}'),
              ],
            ),
            pressFunc: () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
      }
    }).catchError((onError) {
      print('onError ==> ${onError.toString()}');
    });
  }
}
