import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:party/globals.dart' as global;

class ListInvites extends StatefulWidget {
  const ListInvites({super.key});

  @override
  State<ListInvites> createState() => _ListInvitesState();
}

class _ListInvitesState extends State<ListInvites> {
  var json;
  void getData() async {
    var donnees =
        await http.post(Uri.parse("http://172.27.48.1/party/read.php"), body: {
      "api_key": "ghdtb81t8dt8r",
    });
    setState(() {
      json = jsonDecode(donnees.body);
    });
    // print(donnees.body);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: global.appbar1,
        body: ListView.builder(
            itemCount: json.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                        "${json[index]['first_name']} ${json[index]['last_name']}"),
                  ),
                  Divider(
                    height: 5,
                  )
                ],
              );
            }));
  }
}
