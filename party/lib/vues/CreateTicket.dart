import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:party/globals.dart' as global;
import 'package:qr_flutter/qr_flutter.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({super.key});

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  @override
  Widget build(BuildContext context) {
    String code = "Party test Invité numéro 15165152 Pascal";
    return Scaffold(
        appBar: global.appbar1,
        body: SingleChildScrollView(
          child: Center(
            child: QrImage(
                data: code,
                foregroundColor: Colors.deepPurple,
                version: QrVersions.auto,
                size: 200.0,
                embeddedImage: AssetImage('assets/images/logoo.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(80, 80),
                ),
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
          ),
        ));
  }
}
