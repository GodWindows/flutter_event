import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget h_box(double h) {
  return SizedBox(
    height: h,
  );
}

Widget w_box(double w) {
  return SizedBox(
    width: w,
  );
}

var appbar1 = AppBar(
  backgroundColor: Colors.deepPurple,
  title: Text("Party App"),
  centerTitle: true,
);

void toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
