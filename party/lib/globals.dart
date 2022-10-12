import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

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

void red_toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future getStoragePermission(BuildContext context) async {
  if (await Permission.storage.request().isGranted) {
  } else if (await Permission.storage.request().isPermanentlyDenied) {
    red_toast(
        "Vous devez autoriser l'accès à votre stockage pour l'enregistrement des tickets");
    await openAppSettings();
  } else if (await Permission.storage.request().isDenied) {
    Navigator.pop(context);
    red_toast(
        "Vous devez autoriser l'accès à votre stockage pour l'enregistrement des tickets");
  }
}
