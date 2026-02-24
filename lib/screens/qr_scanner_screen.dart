import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'settings_screen.dart';
import '../controllers/qr_scanner_controller.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the scanner controller that will be active while this screen is built
    final QrScannerController controller = Get.put(QrScannerController());

    return Scaffold(
      backgroundColor: Colors.black, // Dark background for camera
      body: Stack(
        children: [
          // 1. Camera View
          Positioned.fill(
            child: MobileScanner(
              controller: controller.mobileController,
              onDetect: controller.handleBarcode,
            ),
          ),

          // Background dimming around the scanner hole (simulated here via a gradient/color overlay)
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),

          // 2. Top Bar (Title and Options)
          Positioned(
            top: 60,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scanner',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Text(
                      'Point at a QR code',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Get.to(() => const SettingsScreen());
                    },
                  ),
                ),
              ],
            ),
          ),

          // 3. Scanner Frame
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildScannerFrame(),
                const SizedBox(height: 48),
                // 4. Flash and Gallery Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => _buildActionButton(
                        icon: controller.isTorchOn.value
                            ? Icons.flash_off
                            : Icons.flash_on,
                        label: 'Flash',
                        onTap: () => controller.toggleTorch(),
                      ),
                    ),
                    const SizedBox(width: 32),
                    _buildActionButton(
                      icon: Icons.image,
                      label: 'Gallery',
                      onTap:
                          () {}, // Gallery scanning to be implemented if needed
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 5. Recent Scan Card (Floating above bottom nav)
          Positioned(
            bottom: 120, // Above bottom nav
            left: 24,
            right: 24,
            child: _buildRecentScanCard(context),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerFrame() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.8),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Corner accents
          _buildCorner(Alignment.topLeft),
          _buildCorner(Alignment.topRight),
          _buildCorner(Alignment.bottomLeft),
          _buildCorner(Alignment.bottomRight),

          // Simulated scanning line
          Positioned(
            top: 20, // This would be animated
            left: 16,
            right: 16,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 15,
                  ),
                ],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 32,
        height: 32,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: _getBorder(alignment),
          borderRadius: _getBorderRadius(alignment),
        ),
      ),
    );
  }

  Border _getBorder(Alignment alignment) {
    const BorderSide b = BorderSide(color: Colors.white, width: 4);
    if (alignment == Alignment.topLeft) return const Border(top: b, left: b);
    if (alignment == Alignment.topRight) return const Border(top: b, right: b);
    if (alignment == Alignment.bottomLeft)
      return const Border(bottom: b, left: b);
    return const Border(bottom: b, right: b); // bottomRight
  }

  BorderRadius _getBorderRadius(Alignment alignment) {
    const r = Radius.circular(12);
    if (alignment == Alignment.topLeft)
      return const BorderRadius.only(topLeft: r);
    if (alignment == Alignment.topRight)
      return const BorderRadius.only(topRight: r);
    if (alignment == Alignment.bottomLeft)
      return const BorderRadius.only(bottomLeft: r);
    return const BorderRadius.only(bottomRight: r);
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentScanCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1C1C1E).withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: isDark ? 0.3 : 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.link, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'nixtio.com/design',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Scanned just now',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward,
              size: 16,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
