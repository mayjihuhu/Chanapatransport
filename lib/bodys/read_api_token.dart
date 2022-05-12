// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, unused_import
import 'package:chanatran/main.dart';
import 'package:chanatran/models/profile_model.dart';
import 'package:chanatran/utility/my_constant.dart';
import 'package:chanatran/widges/show_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReadApiToken extends StatefulWidget {
  final String token;
  const ReadApiToken({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<ReadApiToken> createState() => _ReadApiTokenState();
}

class _ReadApiTokenState extends State<ReadApiToken> {
  String? token;
  ProfileModel? profileModel;
  bool load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = widget.token;
    readProfile();
  }

  Future<void> readProfile() async {
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    Map<String, dynamic> map = {};
    map['id'] = '105';
    map['role'] = 'Roller';

    await dio.post(MyConstant.pathGetProfile, data: map).then((value) {
      print('## value from token ===> $value');

      profileModel = ProfileModel.fromJson(value.data);
      load = false;
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load? const Center(child: CircularProgressIndicator())
      : Column(
        children: [
          ShowText(lable: 'FirstName : ${profileModel!.responseData!.firstname}'),
          ShowText(lable: 'LastName : ${profileModel!.responseData!.lastname}'),
          ShowText(lable: 'MemberType : ${profileModel!.responseData!.membertype}'),
        ],
      ),
      
    );
  }
}
