import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:party/globals.dart' as global;
import 'package:party/model/variables.dart';
import 'package:party/vues/ListInvites.dart';
import 'package:party/vues/ajoutInvites.dart';
import 'package:party/vues/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:party/vues/BriefPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginState state = LoginState.connection;

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: global.appbar1,
      body: Container(
        child: SingleChildScrollView(
          child: (state == LoginState.connection)
              ? Connection_Widget(_screenWidth, _screenHeight)
              : Container(),
        ),
      ),
    );
  }

  Widget Connection_Widget(double _screenWidht, double _screenHeight) {
    TextEditingController email_controller = TextEditingController();
    TextEditingController password_controller = TextEditingController();
    return Container(
      padding: EdgeInsets.fromLTRB(40, 80, 40, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "CONNEXION",
              textAlign: TextAlign.center,
            ),
          ),
          global.h_box(_screenHeight / 20),
          TextFormField(
            controller: email_controller,
            decoration: InputDecoration(labelText: "Email"),
          ),
          global.h_box(_screenHeight / 20),
          TextFormField(
            controller: password_controller,
            decoration: InputDecoration(labelText: "Mot de passe"),
          ),
          global.h_box(_screenHeight / 10),
          ElevatedButton(
              onPressed: () {
                //CreateAccount();
              },
              child: Text("Créez vos évènements"))
        ],
      ),
    );
  }
}
