import 'package:chanatran/models/authen_model.dart';
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

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? rollerid, username, password;

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
      label: 'Username :',
      iconData: Icons.account_circle_outlined,
      changeFunc: (String string) {
        username = string.trim();
      },
    );
  }

  ShowForm newPassword() {
    return ShowForm(
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
    }).catchError((onError) {
      print('value Authen ==> ${onError.toString()}');
    });
  }
}
