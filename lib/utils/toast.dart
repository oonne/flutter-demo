import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/* 
 * Toast
 */
Future<void> toast(String msg) async {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}