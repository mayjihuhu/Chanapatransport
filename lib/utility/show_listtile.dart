import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/widges/show_image.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:flutter/material.dart';

class ShowListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String path;
  const ShowListTile( {
    Key? key,
    required this.title,
    required this.subTitle,
    required this.path,
    final double? size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 80,
        child: ShowImage(
          path: path,
        ),
      ),
      title: ShowText(
        lable: title,
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowText(lable: subTitle),
    );
  }
}
