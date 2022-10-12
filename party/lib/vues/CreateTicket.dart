import 'dart:math';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:party/globals.dart' as global;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:english_words/english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> write() async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('File created by Party App');
  }

  @override
  Widget build(BuildContext context) {
    init();
    global.getStoragePermission(context);
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    String code = generateCode();
    ScreenshotController screenshotController = ScreenshotController();
    write();
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
                        child: const Center(
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
                                          child: const Center(
                                            child: Text(
                                              "Erreur! Impossible de générer le code QR",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      }),
                                  global.h_box(30),
                                  const Center(
                                    child: Text(
                                      "Ce code représente votre ticket. Ne le partagez avec personne!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  global.h_box(150),
                                  const Center(
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
                        print(result);
                      });
                      //String? path = await NativeScreenshot.takeScreenshot();
                    },
                    child: const Text("Enregistrer ce ticket"))
              ],
            ),
          ),
        ));
  }
}
