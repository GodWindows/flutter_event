import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:party/globals.dart' as global;
import 'package:party/vues/ListInvites.dart';

void sendData() async {
  var donnees = await http.post(
      Uri.parse("http://godwindows.infinityfreeapp.com/party/create.php"),
      body: {
        "api_key": "ghdtb81t8dt8r",
        "fname": "${last_name_controller.text}",
        "lname": "${name_controller.text}"
      });
  var json = donnees.body;
  //print(donnees.body);
}

TextEditingController name_controller = TextEditingController();
TextEditingController last_name_controller = TextEditingController();

class AjoutInvites extends StatefulWidget {
  const AjoutInvites({super.key});

  @override
  State<AjoutInvites> createState() => _AjoutInvitesState();
}

class _AjoutInvitesState extends State<AjoutInvites> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: IconButton(
          color: Colors.deepPurple,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const ListInvites();
            }));
          },
          icon: Icon(Icons.people)),
      appBar: global.appbar1,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: _screenWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                global.h_box(15),
                Center(
                  child: Text("Ajoutez un invité à l'évènement"),
                ),
                global.h_box(15),
                TextFormField(
                  decoration: InputDecoration(label: Text("Nom")),
                  controller: name_controller,
                ),
                global.w_box(15),
                TextFormField(
                  decoration: InputDecoration(label: Text("Prénom")),
                  controller: last_name_controller,
                ),
                global.h_box(40),
                ElevatedButton(
                    onPressed: () {
                      sendData();
                      name_controller.text = "";
                      last_name_controller.text = "";
                    },
                    child: Text("Ajouter"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
