import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:party/globals.dart' as global;

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
      title: 'Party App',
      theme: ThemeData(primaryColor: Color.fromARGB(255, 175, 76, 162)),
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
  void getData() async {
    var donnees = await http.post(Uri.parse("http://172.27.48.1/party/add.php"),
        body: {
          "fname": "${last_name_controller.text}",
          "lname": "${name_controller.text}"
        });
    var json = donnees.body;
    print(donnees.body);
  }

  TextEditingController name_controller = TextEditingController();
  TextEditingController last_name_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Party",
        home: Scaffold(
          floatingActionButton: IconButton(
              onPressed: () {
                getData();
                name_controller.text = "";
                last_name_controller.text = "";
              },
              icon: Icon(Icons.people)),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 175, 76, 162),
            title: Text("Party App"),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                global.h_box(15),
                Center(
                  child: Text("Ajoutez quelqu'un à la fête"),
                ),
                global.h_box(15),
                TextFormField(
                  decoration: InputDecoration(label: Text("Nom de famille")),
                  controller: name_controller,
                ),
                global.w_box(15),
                TextFormField(
                  decoration: InputDecoration(label: Text("Prénom")),
                  controller: last_name_controller,
                )
              ],
            ),
          ),
        ));
  }
}
