import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:party/globals.dart' as global;

class ListInvites extends StatefulWidget {
  const ListInvites({super.key});

  @override
  State<ListInvites> createState() => _ListInvitesState();
}

class _ListInvitesState extends State<ListInvites> {
  void getData() async {
    var donnees = await http
        .post(Uri.parse("http://172.27.48.1/party/read.php"), body: {});
    var json = donnees.body;
    print(donnees.body);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: global.appbar1,
      body: Center(
        child: Text("Voici tous les invités! "),
      ),
    );
  }
}
