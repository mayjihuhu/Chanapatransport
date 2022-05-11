// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chanatran/utility/show_listtile.dart';
import 'package:flutter/material.dart';

import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/widges/show_image.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:chanatran/widges/show_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> twoWayDialog({
    required String title,
    required String subtitle,
    required String label1,
    required String label2,
    required Function() pressFunc1,
    required Function() pressFunc2,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ShowListTile(
          title: title,
          subTitle: subtitle,
          path: 'images/avatar_icon.png',
        ),
        actions: [
          ShowTextButton(
            label: label1,
            pressFunc: pressFunc1,
          ),
          ShowTextButton(
            label: label2,
            pressFunc: pressFunc2,
          ),
          ShowTextButton(
            label: 'Cancel',
            pressFunc: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> normalDialog(
      {
      required String title, 
      required String subTitle,
      Function()? pressFunc,
      Widget? widget,
      
      }) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: ShowListTile(
                title: title,
                subTitle: subTitle,
                path: 'images/logo_food.png',
              ),
              actions: [
                ShowTextButton(
                    label: 'OK',
                    pressFunc: pressFunc ?? () {
                      Navigator.pop(context);
                    },
                    )
              ],
              content: widget ?? const SizedBox(),
            ),
            );
  }
}//class
