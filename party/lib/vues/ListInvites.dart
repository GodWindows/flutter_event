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
  String str = "babe";
  bool _isloading = true;
  bool _is_searching = false;
  String search_value = "";
  void getData() async {
    var donnees = await http.post(
        Uri.parse("http://godwindows.infinityfreeapp.com/party/read.php"),
        body: {
          "api_key": "ghdtb81t8dt8r",
        });
    setState(() {
      json = jsonDecode(donnees.body);
      _isloading = false;
    });
    print(donnees.body);
  }

  var _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    getData();
    return Scaffold(
        appBar: global.appbar1,
        body: (_isloading)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: _screenWidth * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        global.h_box(20),
                        CupertinoSearchTextField(
                          onChanged: (value) {
                            if (value != "") {
                              setState(() {
                                search_value = value.toLowerCase();
                                _is_searching = true;
                              });
                            } else {
                              setState(() {
                                _is_searching = false;
                              });
                            }
                          },
                          controller: _search,
                        ),
                        global.h_box(15),
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            itemCount: json.length,
                            itemBuilder: (!_is_searching)
                                ? (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                              "${json[index]['first_name']} ${json[index]['last_name']}"),
                                        ),
                                        Divider(
                                          height: 5,
                                          thickness: 2,
                                        )
                                      ],
                                    );
                                  }
                                : (context, index) {
                                    if ((json[index]['first_name']
                                                .toString()
                                                .toLowerCase() +
                                            " " +
                                            json[index]['last_name']
                                                .toString()
                                                .toLowerCase())
                                        .contains(search_value)) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                                "${json[index]['first_name']} ${json[index]['last_name']}"),
                                          ),
                                          Divider(
                                            height: 5,
                                            thickness: 2,
                                          )
                                        ],
                                      );
                                    }
                                    return Container();
                                  }),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
