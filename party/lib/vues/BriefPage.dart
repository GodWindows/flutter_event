import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:party/globals.dart' as global;
import 'package:party/vues/HomePage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BriefPage extends StatefulWidget {
  const BriefPage({super.key});

  @override
  State<BriefPage> createState() => _BriefPageState();
}

class _BriefPageState extends State<BriefPage> {
  bool? _isallowed = false;
  bool? _checkbox_value = false;
  String beta_code = "rg8r498j4ryk8ut9q48x16jj17uk484q8g6sgs4@";
  var api_beta_code;
  bool _isloading = false;

  void CheckAuthorizationAndOpenApp(BuildContext context) async {
    setState(() {
      _isloading = true;
    });
    var donnees = await http.post(
        Uri.parse(
            "http://godwindows.infinityfreeapp.com/party/readBetaCodes.php"),
        body: {
          "api_key": "ghdtb81t8dt8r",
        });
    setState(() {
      api_beta_code = donnees.body;
      _isloading = false;
    });

    if (api_beta_code == beta_code) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return const HomePage();
      }));
    } else {
      global.grey_toast(
          "Vous n'êtes plus autorisé à utiliser l'application en version beta. Merci pour votre aimable contribution");
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            global.h_box(50),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    "Obligation de confidentialité\nPartyApp",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
                  ),
                  global.h_box(20),
                  Text(
                    global.accords_confidentialite,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
            global.h_box(_screenHeight / 20),
            (_isloading)
                ? Container(
                    padding: EdgeInsets.all(60),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
            Container(
              child: Row(
                children: [
                  Checkbox(
                      value: _checkbox_value,
                      onChanged: ((value) {
                        setState(() {
                          _checkbox_value = value;
                          _isallowed = value;
                        });
                      })),
                  Text(
                    "J'ai lu et j'accepte les accords de confidentialité\n ci-dessus énoncés.",
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_isallowed == true) {
                    CheckAuthorizationAndOpenApp(context);
                  }
                },
                child: Text("Démarrer")),
            global.h_box(40),
          ],
        ),
      ),
    );
  }
}
