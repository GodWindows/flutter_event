import 'dart:math';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:party/globals.dart' as global;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:english_words/english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({super.key});

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  late SharedPreferences preferences;
  List<String> les_codes = [];
  init() async {
    preferences = await SharedPreferences.getInstance();
    var tmp = preferences.getStringList('codes');
    if (tmp != null) {
      les_codes = tmp;
    }
  }

  saveCode(String codes) {
    setState(() {
      les_codes.add(codes);
      print(les_codes);
      preferences.setStringList("codes", les_codes);
    });
    global.toast("Enrégistré");
  }

  String generateCode() {
    var random_code = Random().nextInt(100000) * 100;
    final random_word = WordPair.random();
    String generated_code =
        "Party test Invité numéro $random_code ${random_word.asPascalCase}";
    if (les_codes.contains(generated_code)) {
      generated_code = generateCode();
    }
    return generated_code;
  }

  @override
  Widget build(BuildContext context) {
    init();
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    String code = generateCode();
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
        appBar: global.appbar1,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //Text(code),
                global.h_box(_screenHeight / 6),
                QrImage(
                    data: code,
                    foregroundColor: Colors.deepPurple,
                    version: QrVersions.auto,
                    size: 200.0,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Erreur! Impossible de générer le code QR",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                global.h_box(30),
                ElevatedButton(
                    onPressed: () async {
                      saveCode(code);
                      screenshotController
                          .captureFromWidget(
                              Column(
                                children: [
                                  global.h_box(_screenHeight / 6),
                                  QrImage(
                                      data: code,
                                      foregroundColor: Colors.deepPurple,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                      errorStateBuilder: (cxt, err) {
                                        return Container(
                                          child: Center(
                                            child: Text(
                                              "Erreur! Impossible de générer le code QR",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      }),
                                  global.h_box(30),
                                  Center(
                                    child: Text(
                                      "Ce code représente votre ticket. Ne le partagez avec personne!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  global.h_box(150),
                                  Center(
                                    child: Text(
                                      "Code généré par Party App",
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                    ),
                                  ),
                                ],
                              ),
                              pixelRatio: pixelRatio)
                          .then((capturedImage) async {
                        final result = await ImageGallerySaver.saveImage(
                            capturedImage,
                            quality: 60,
                            name: "${code}");
                        //print(result);
                      });
                      //String? path = await NativeScreenshot.takeScreenshot();
                    },
                    child: Text("Enregistrer ce ticket"))
              ],
            ),
          ),
        ));
  }
}
