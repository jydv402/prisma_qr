import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'extnd.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final MobileScannerController cameraConroller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: MobileScanner(onDetect: (capture) {
        for (var barcode in capture.barcodes) {
          try {
            Map decodedQr = jsonDecode(barcode.rawValue!.toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuPage(),
                ));
            cameraConroller.stop();
          } catch (r) {
            debugPrint("Invalid QR Code");
          }
        }
      }),
    );
  }
}
