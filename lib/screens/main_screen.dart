import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';
import 'qr_scanner_screen.dart';
import 'qr_maker_history_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'scan_saved_history_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final BottomNavController controller = Get.put(BottomNavController());

    final List<Widget> pages = [
      const QrScannerScreen(),
      const QrMakerHistoryScreen(),
      const ScanSavedHistoryScreen(), // Example mapping to history button
    ];

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            // The current active page
            IndexedStack(index: controller.currentIndex.value, children: pages),

            // Floating bottom navigation bar
            const Positioned(
              bottom: 32.0,
              left: 0,
              right: 0,
              child: BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
