
import 'package:flutter/material.dart';

class SnackHelper{

  static void showContentSnack(String content,BuildContext context){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 800),
      content: Text(
        content,
        style: TextStyle(
            color: const Color(0xff3061D7),
            fontWeight: FontWeight.w700,
            fontFamily: 'Nunito'),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.grey.shade200,
    ));

  }

}