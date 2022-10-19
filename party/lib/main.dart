import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:party/globals.dart' as global;
import 'package:party/vues/ListInvites.dart';
import 'package:party/vues/ajoutInvites.dart';
import 'package:party/vues/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:party/vues/BriefPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Party App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool first_use_of_the_app = true;
  init() async {
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    var tmp = preferences.getBool('first_timed');
    if (tmp != null) {
      setState(() {
        first_use_of_the_app = false;
      });
    } else {
      preferences.setBool('first_timed', false);
      tmp = preferences.getBool('first_timed');
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Party App',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: BriefPage());
  }
}
