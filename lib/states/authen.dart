import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/widges/show_botton.dart';
import 'package:chanatran/widges/show_form.dart';
import 'package:chanatran/widges/show_image.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:chanatran/widges/show_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Authen extends StatelessWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, contraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Container(
            decoration: MyConstant().planBox(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newLeftSide(newLogo(contraints)),
                  newLeftSide(newText()),
                  newEmail(),
                  newPassword(),
                  newButton(),
                  Row(
                    children: [
                      ShowTextButton(),
                      TextButton(
                          onPressed: null,
                          child: ShowText(
                            lable: 'Create Account',
                            textStyle: MyConstant().h3ActiveStyle(),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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
      pressFunc: () {},
    );
  }

  ShowForm newEmail() {
    return ShowForm(
      label: 'E-mail :',
      iconData: Icons.account_circle_outlined,
      changeFunc: (String string) {},
    );
  }

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :',
      iconData: Icons.lock_outline,
      obsecu: true,
      changeFunc: (String string) {},
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
}
