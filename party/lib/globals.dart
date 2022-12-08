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

void grey_toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
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

String api_url = "http://localhost/party";

String accords_confidentialite =
    """Sauf dispositions contraires dans le présent Accord, les Fonctionnalités de l'application resteront la propriété exclusive de Party App et les informations ne seront utilisées par le Testeur qu’aux fins permises. Le Testeur n’utilisera pas les informations sur les Fonctionnalités de l'application à des fins qui pourraient directement ou indirectement porter préjudice aux développeurs.

Les développeurs et les Testeurs conviennent que la présente clause représente pour eux un caractère substantiel.

A cet effet, le Testeur s’engage à :

-  Ce que les Fonctionnalités de l'applications soient protégées et gardées confidentielles ;

-  Ne pas utiliser les Fonctionnalités de l'application dans un but autre que la réalisation des Tests utilisateurs;

-  Maintenir les formules de copyright, de confidentialité, d’interdiction de copie, ou toutes autres mentions de propriété ou de confidentialité, figurant sur les différents éléments communiqués, qu’il s’agisse des originaux ou des copies.

En outre, le Testeur s’interdit :

-  Toute divulgation quelle qu’elle soit, à quelque tiers que ce soit, des Fonctionnalités de l'application, sauf accord écrit exprès et préalable des développeurs;

-  D’utiliser et/ou d’exploiter en tout ou en partie les Fonctionnalités de l'application à d’autres fins que la réalisation des Tests utilisateurs pour lesquels il a été choisi;

-  De déposer en leur seul nom une demande de brevet sur les Fonctionnalités de l'application dont il n’est pas titulaire, et plus généralement un titre de propriété industrielle quel qu’il soit ;

-  D’effectuer des copies, reproductions ou duplications de tout ou partie des Fonctionnalités de l'application, sauf accord écrit exprès et préalable des développeurs;
-  De se prévaloir, du fait de la communication des Fonctionnalités de l'application, d’une quelconque cession, concession de licence ou d’un quelconque droit de possession antérieur, tel que défini par le Code de la propriété intellectuelle, sur les Informations confidentielles.
-  Le Testeur se porte fort du respect des présents engagements par toute personne, physique ou morale, à laquelle il aurait communiqué les Fonctionnalités de l'application. """;
