import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:party/globals.dart' as global;
import 'package:party/vues/ListInvites.dart';


  void sendData() async {
    var donnees = await http
        .post(Uri.parse("http://172.27.48.1/party/create.php"), body: {
      "fname": "${last_name_controller.text}",
      "lname": "${name_controller.text}"
    });
    var json = donnees.body;
    print(donnees.body);
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
    return Scaffold(
          floatingActionButton: IconButton(
              onPressed: () {
                sendData();
                name_controller.text = "";
                last_name_controller.text = "";
              },
              icon: Icon(Icons.people)),
          appBar: global.appbar1,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                global.h_box(15),
                Center(
                  child: Text("Ajoutez un invité à l'évènement"),
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
                ),
                global.h_box(40),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ListInvites();
                      }));
                    },
                    child: Text("Voir tous les invités"))
              ],
            ),
          ),
        );
  }
}