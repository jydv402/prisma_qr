import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:prisma_qr_app/models/qr_code_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDisplayScreen extends StatelessWidget {
  const QrDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    final record = Get.arguments as QrCodeRecord;

    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'QR Display',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            SizedBox(
              width: size * 0.8,
              height: size * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: QrImageView(
                  data: record.data,
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(24),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              record.data,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
