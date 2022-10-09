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
    return Scaffold(
        appBar: global.appbar1,
        body: SingleChildScrollView(
          child: Center(
            child: QrImage(
                data: "Party test Invité numéro 1",
                version: QrVersions.auto,
                size: 200.0,
                embeddedImage: AssetImage('assets/images/logo.png'),
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
