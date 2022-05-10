import 'package:chanatran/widges/show_text.dart';
import 'package:flutter/material.dart';

class ShowTextButton extends StatelessWidget {
  const ShowTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowText(lable: 'Non Account ?');
  }
}
