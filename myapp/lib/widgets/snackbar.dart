import 'package:flutter/material.dart';

void showSnackBAR(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message)
      ),
  );
}