import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:prisma_qr_app/elements/build_bottom_button.dart';
import 'package:prisma_qr_app/elements/build_section_header.dart';
import 'package:prisma_qr_app/models/qr_code_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDisplayScreen extends StatelessWidget {
  const QrDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the theme data
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    // Get the arguments from the directed page
    final record = Get.arguments as QrCodeRecord;

    // Ontain the screen size
    final size = Get.width * 0.9;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'QR Display',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'GSansFlex',
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 32),
          buildSectionHeader(context, 'QR Code'),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size,
                  height: size,
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
              ],
            ),
          ),
          const SizedBox(height: 32),
          buildSectionHeader(context, 'title'),
          Container(
            width: size,
            alignment: .centerStart,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Text(
              record.title ??
                  "${record.type.toUpperCase()} ${record.id.substring(0, 4)}",
              softWrap: true,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),

          buildSectionHeader(context, 'raw data'),
          Container(
            width: size,
            alignment: .centerStart,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Text(
              record.data,
              softWrap: true,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          buildSectionHeader(context, 'options'),
          // TODO: Add options
          SizedBox(height: size * 0.5),
        ],
      ),
    );
  }
}
