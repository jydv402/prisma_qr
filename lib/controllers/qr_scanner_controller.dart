import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import '../models/qr_code_model.dart';
import 'history_controller.dart';
import 'package:uuid/uuid.dart';
import '../screens/scan_result_bottom_sheet.dart';
import 'package:flutter/material.dart';

class QrScannerController extends GetxController {
  final MobileScannerController mobileController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  var isTorchOn = false.obs;
  var isScanning = true.obs;

  final HistoryController _historyController = Get.find();
  final _uuid = const Uuid();

  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }

  void toggleTorch() {
    mobileController.toggleTorch();
    isTorchOn.toggle();
  }

  Future<void> handleBarcode(BarcodeCapture capture) async {
    if (!isScanning.value) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final barcode = barcodes.first;
      final String rawValue = barcode.rawValue ?? '';

      if (rawValue.isNotEmpty) {
        // Pause to prevent multiple detections of the same code
        isScanning.value = false;
        mobileController.stop();

        // Feed back
        bool canVibrate = await Vibrate.canVibrate;
        if (canVibrate) {
          Vibrate.feedback(FeedbackType.success);
        }

        // Determine format roughly
        String format = 'Text';
        if (rawValue.startsWith('http://') || rawValue.startsWith('https://'))
          format = 'URL';
        else if (rawValue.startsWith('WIFI:'))
          format = 'Wi-Fi';
        else if (rawValue.startsWith('BEGIN:VCARD'))
          format = 'Contact';

        // Save to history
        final record = QrCodeRecord(
          id: _uuid.v4(),
          data: rawValue,
          type: 'scan',
          format: format,
          timestamp: DateTime.now(),
        );
        await _historyController.addRecord(record);

        // Show Bottom Sheet here with rawValue
        await Get.bottomSheet(
          ScanResultBottomSheet(record: record),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        );

        // Resume scanning after bottom sheet is dismissed
        resumeScanning();
      }
    }
  }

  void resumeScanning() {
    isScanning.value = true;
    mobileController.start();
  }
}
