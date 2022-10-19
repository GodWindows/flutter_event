import 'package:flutter/material.dart';
import 'package:party/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'package:party/vues/ajoutInvites.dart';
import 'package:party/vues/CreateTicket.dart';
import 'package:party/vues/VerifyTicket.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: global.appbar1,
      body:SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        global.h_box(_screenHeight / 3),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const AjoutInvites(); //Redirige vers la page d'ajout d'invités
                              }));
                            },
                            child: Text("Ajouter un invité")),
                        global.h_box(30),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const CreateTicket(); //Redirige vers la page de création de tickets
                              }));
                            },
                            child: Text("Créer un ticket")),
                        global.h_box(30),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const BarcodeScannerWithController(); //Redirige vers la page de vérification de tickets
                              }));
                            },
                            child: Text("Vérifier un ticket")),
                      ],
                    ),
                  ),
                ),
    );
  }
}
