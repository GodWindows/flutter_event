import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:party/globals.dart' as global;
import 'package:party/vues/ajoutInvites.dart';
import 'package:party/vues/ListInvites.dart';
import 'package:party/vues/CreateTicket.dart';
import 'package:party/vues/VerifyTicket.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: global.appbar1,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              global.h_box(_screenHeight / 3),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const AjoutInvites();
                    }));
                  },
                  child: Text("Ajouter un invité")),
              global.h_box(30),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const CreateTicket();
                    }));
                  },
                  child: Text("Créer un ticket")),
              global.h_box(30),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const BarcodeScannerWithController();
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
