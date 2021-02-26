
import 'package:flutter/material.dart';

class SnackHelper{

  static void showContentSnack(String content,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
  }

}