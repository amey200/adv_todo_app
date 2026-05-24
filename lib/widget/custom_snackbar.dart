
import 'package:flutter/material.dart';


class CustomSnackbar{
  
  showCustomSnackbar(BuildContext context , { required String? message, required Color? bgColor}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!), backgroundColor: bgColor));
  }

}