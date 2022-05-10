import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/widges/show_botton.dart';
import 'package:chanatran/widges/show_form.dart';
import 'package:chanatran/widges/show_icon_button.dart';
import 'package:chanatran/widges/show_image.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  var typeUsers = MyConstant.typeUsers;
  String? typeUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          lable: 'Create New Account',
          textStyle: MyConstant().h2Style(),
        ),
        elevation: 0,
        foregroundColor: MyConstant.dark,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          newCenter(widget: newAvatar()),
          newCenter(
            widget: ShowForm(
                label: 'Name :',
                iconData: Icons.person,
                changeFunc: (String string) {}),
          ),
          newCenter(
            widget: newTypeUser(),
          ),
          newCenter(
            widget: ShowForm(
                label: 'E-mail :',
                iconData: Icons.email_outlined,
                changeFunc: (String string) {}),
          ),
          newCenter(
            widget: ShowForm(
                label: 'Password :',
                iconData: Icons.lock_outline,
                changeFunc: (String string) {}),
          ),
          newCenter(
            widget: ShowForm(
                label: 'Re-Password :',
                iconData: Icons.lock,
                changeFunc: (String string) {}),
          ),
          newCenter(
            widget: ShowBotton(
              label: 'Create New Account',
              pressFunc: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget newTypeUser() {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: MyConstant().curveBorderBox(),
      width: 250,
      height: 40,
      child: DropdownButton<dynamic>(
          hint: const ShowText(lable: 'Please Choose TypeUser'),
          value: typeUser,
          items: typeUsers
              .map(
                (e) => DropdownMenuItem(
                  child: ShowText(lable: e),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              typeUser = value.toString();
            });
          }),
    );
  }

  Widget newAvatar() {
    return Container(
      margin: const EdgeInsets.only(top: 36, bottom: 5),
      width: 250,
      height: 250,
      child: Stack(
        children: [
          const ShowImage(
            path: 'images/avatar_icon.png',
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: ShowIconButton(
              size: 48,
              iconData: Icons.add_a_photo,
              pressFunc: () {},
            ),
          ),
        ],
      ),
    );
  }

  Row newCenter({required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget,
      ],
    );
  }
}
