// ignore_for_file: unused_local_variable, unnecessary_import

import 'package:chanatran/models/authen_model.dart';
import 'package:chanatran/models/response_false_model.dart';
import 'package:chanatran/models/success_authen_model.dart';
import 'package:chanatran/states/createaccount.dart';
import 'package:chanatran/states/register.dart';
import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/utility/my_dialog.dart';
import 'package:chanatran/widges/show_botton.dart';
import 'package:chanatran/widges/show_form.dart';
import 'package:chanatran/widges/show_image.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:chanatran/widges/show_text_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? rollerid, username, password;

  TextEditingController rollerIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forTestAuthen();
  }

  void forTestAuthen() {
    rollerIdController.text = '6510000090';
    userNameController.text = '8422588455';
    passwordController.text = '060765';

    rollerid = rollerIdController.text;
    username = userNameController.text;
    password = passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, contraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Container(
            decoration: MyConstant().imagebox(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    newLeftSide(newLogo(contraints)),
                    newLeftSide(newText()),
                    newRollerId(),
                    newUser(),
                    newPassword(),
                    newButton(),
                    newCreateAccount(context: context),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  ShowForm newRollerId() => ShowForm(
      controller: rollerIdController,
      textInputType: TextInputType.number,
      label: 'RollerId :',
      iconData: Icons.account_box_outlined,
      changeFunc: (String string) {
        rollerid = string.trim();
      });

  Row newCreateAccount({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowText(lable: 'Non Account?'),
        ShowTextButton(
          label: 'Create Account',
          pressFunc: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
                ));
          },
        ),
      ],
    );
  }

  Row newLeftSide(Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: widget,
        ),
      ],
    );
  }

  ShowText newLeftSite() => newText();

  ShowBotton newButton() {
    return ShowBotton(
      label: 'Login',
      pressFunc: () {
        if ((rollerid?.isEmpty ?? true) ||
            (username?.isEmpty ?? true) ||
            (password?.isEmpty ?? true)) {
          MyDialog(context: context).normalDialog(
              title: 'Have Space ?', subTitle: 'Please Every Blank');
        } else {
          processCheckAuthen();
        }
      },
    );
  }

  ShowForm newUser() {
    return ShowForm(
      controller: userNameController,
      label: 'Username :',
      iconData: Icons.account_circle_outlined,
      changeFunc: (String string) {
        username = string.trim();
      },
    );
  }

  ShowForm newPassword() {
    return ShowForm(
      controller: passwordController,
      label: 'Password :',
      iconData: Icons.lock_outline,
      obsecu: true,
      changeFunc: (String string) {
        password = string.trim();
      },
    );
  }

  ShowText newText() {
    return ShowText(
      lable: 'Log in',
      textStyle: MyConstant().h1Style(),
    );
  }

  Row newLogo(BoxConstraints contraints) {
    return Row(
      children: [
        SizedBox(
          width: contraints.maxWidth * 0.5,
          child: const ShowImage(),
        ),
      ],
    );
  }

  Future<void> processCheckAuthen() async {
    AuthenModel authenModel = AuthenModel(
        rollerid: rollerid!, username: username!, password: password!);
    await Dio()
        .post(MyConstant.pathAuthen, data: authenModel.toMap())
        .then((value) {
      print('value authen ==> $value');

      ResponseFalseModel responseFalseModel =
          ResponseFalseModel.fromMap(value.data);
      print('ResponseStatus ==> ${responseFalseModel.ResponseStatus}');

      if (responseFalseModel.ResponseStatus == 'Failed') {
        MyDialog(context: context).normalDialog(
            title: 'Login Flase',
            subTitle: responseFalseModel.ResponseMessages);
      } else {
        SuccessAuthenModel successAuthenModel =
            SuccessAuthenModel.fromJson(value.data);
        processSaveUser(successAuthenModel: successAuthenModel);
      }
    }).catchError((onError) {
      print('value Authen ==> ${onError.toString()}');
    });
  }

  Future<void> processSaveUser(
      {required SuccessAuthenModel successAuthenModel}) async {
    String token = successAuthenModel.responseData![0].token.toString();
    print('token ==>> $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(MyConstant.keyRollerId, rollerid!);
    preferences.setString(MyConstant.keyUserName, username!);
    preferences.setString(MyConstant.keyPassword, password!);
    preferences.setString(MyConstant.keyToken, token);

    Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false);
  }
}
