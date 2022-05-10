// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chanatran/utility/my_constant.dart';
import 'package:flutter/material.dart';

class ShowText extends StatelessWidget {
  final String lable;
  final TextStyle? textStyle;
  const ShowText({
    Key? key,
    required this.lable,
    this.textStyle, String? label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(lable,style: textStyle?? MyConstant().h3Style(),);
  }
}
