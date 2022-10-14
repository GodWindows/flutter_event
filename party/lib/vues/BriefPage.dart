import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:party/globals.dart' as global;
import 'package:party/vues/HomePage.dart';

class BriefPage extends StatefulWidget {
  const BriefPage({super.key});

  @override
  State<BriefPage> createState() => _BriefPageState();
}

class _BriefPageState extends State<BriefPage> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          global.h_box(_screenHeight / 4),
          Text(
            "Gérer vos tickets pour tous vos évènements depuis cette app",
            textAlign: TextAlign.center,
          ),
          global.h_box(_screenHeight / 4),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const HomePage();
                }));
              },
              child: Text("Démarrer"))
        ],
      ),
    );
  }
}
