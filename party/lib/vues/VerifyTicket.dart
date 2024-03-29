import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:party/globals.dart' as global;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeScannerWithController extends StatefulWidget {
  const BarcodeScannerWithController({Key? key}) : super(key: key);

  @override
  _BarcodeScannerWithControllerState createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState
    extends State<BarcodeScannerWithController>
    with SingleTickerProviderStateMixin {
  String? barcode;

  late SharedPreferences preferences;
  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    // formats: [BarcodeFormat.qrCode]
    // facing: CameraFacing.front,
  );

  List<String> les_codes = [];
  List<String> les_codes_scannes = [];
  final good_song_player = AudioPlayer();
  final bad_song_player = AudioPlayer();
  final bad_song_player2 = AudioPlayer();
  init() async {
    await good_song_player.setSource(AssetSource('sounds/good.mp3'));
    await bad_song_player.setSource(AssetSource('sounds/bad.mp3'));
    await bad_song_player2.setSource(AssetSource('sounds/bad.mp3'));
    preferences = await SharedPreferences.getInstance();
    var tmp = preferences.getStringList('codes');
    if (tmp != null) {
      les_codes = tmp;
    }
    tmp = preferences.getStringList('codes_scannes');
    if (tmp != null) {
      les_codes_scannes = tmp;
    }
  }

  bool isStarted = true;

  @override
  Widget build(BuildContext context) {
    init();
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,
                // allowDuplicates: true,
                // controller: MobileScannerController(
                //   torchEnabled: true,
                //   facing: CameraFacing.front,
                // ),
                onDetect: (barcode, args) {
                  if (les_codes.contains(barcode.rawValue)) {
                    if (les_codes_scannes.contains(barcode.rawValue)) {
                      bad_song_player.play(AssetSource('sounds/bad.mp3'));
                      global.red_toast("Code déjà scanné!");
                    } else {
                      good_song_player.play(AssetSource('sounds/good.mp3'));
                      global.toast("Code détecté");
                      les_codes_scannes.add(barcode.rawValue!);
                      preferences.setStringList(
                          'codes_scannes', les_codes_scannes);
                    }
                  } else {
                    bad_song_player2.play(AssetSource('assets/sounds/bad.mp3'));
                    global.red_toast("Code non reconnu. Veuillez réésayer");
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.torchState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(
                                Icons.flash_off,
                                color: Colors.grey,
                              );
                            }
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(
                                  Icons.flash_off,
                                  color: Colors.grey,
                                );
                              case TorchState.on:
                                return const Icon(
                                  Icons.flash_on,
                                  color: Colors.yellow,
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.toggleTorch(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: isStarted
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: () => setState(() {
                          isStarted ? controller.stop() : controller.start();
                          isStarted = !isStarted;
                        }),
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 50,
                          child: FittedBox(
                            child: Text(
                              barcode ?? 'Approchez la caméra du ticket!',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.cameraFacingState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(Icons.camera_front);
                            }
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.switchCamera(),
                      ),
                      /* IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.image),
                        iconSize: 32.0,
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            if (await controller.analyzeImage(image.path)) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Barcode found!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No barcode found!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),*/
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
