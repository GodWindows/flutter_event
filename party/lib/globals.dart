import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  backgroundColor: Color.fromARGB(255, 175, 76, 162),
  title: Text("Party App"),
);
