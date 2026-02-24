import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import '../models/qr_code_model.dart';
import 'history_controller.dart';
import 'package:uuid/uuid.dart';
import '../screens/scan_result_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings_controller.dart';

class QrScannerController extends GetxController {
  // Initialize the mobile scanner controller from the MobileScanner package
  final MobileScannerController mobileController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  // Observable variables
  var isTorchOn = false.obs; //Turn on the flashlight
  var isScanning = true.obs; //Status of scan. True => Scanning, False => Paused

  // Controllers
  final HistoryController _historyController = Get.find();
  final SettingsController _settingsController = Get.find();
  final _uuid = const Uuid();

  // Dispose the controller when the screen is closed
  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }

  // Toggle the torch
  void toggleTorch() {
    mobileController.toggleTorch();
    isTorchOn.toggle();
  }

  // Handle barcode detection
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
        if (_settingsController.hapticFeedback.value) {
          bool canVibrate = await Vibrate.canVibrate;
          if (canVibrate) {
            Vibrate.feedback(FeedbackType.success);
          }
        }

        if (_settingsController.scanSounds.value) {
          // Placeholder for beep sound execution
        }

        // Determine format roughly
        String format = 'Text';
        if (rawValue.startsWith('http://') || rawValue.startsWith('https://')) {
          format = 'URL';
        } else if (rawValue.startsWith('WIFI:')) {
          format = 'Wi-Fi';
        } else if (rawValue.startsWith('BEGIN:VCARD')) {
          format = 'Contact';
        }

        // Save to history
        final record = QrCodeRecord(
          id: _uuid.v4(),
          data: rawValue,
          type: 'scan',
          format: format,
          timestamp: DateTime.now(),
        );
        await _historyController.addRecord(record);

        // Auto Copy hook
        if (_settingsController.autoCopy.value) {
          Clipboard.setData(ClipboardData(text: rawValue));
          Get.snackbar(
            'Copied',
            'Data auto-copied to clipboard',
            snackPosition: SnackPosition.TOP,
          );
        }

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
