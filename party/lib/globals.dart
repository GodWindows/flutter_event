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
  backgroundColor: Colors.deepPurple,
  title: Text("Party App"),
  centerTitle: true,
);
