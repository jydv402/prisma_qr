import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prisma_qr_app/controllers/history_controller.dart';
import 'package:prisma_qr_app/widgets/confirmation_bottom_sheet.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
        Get.find<SettingsController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        title: Text(
          'Settings',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          // App Info Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.75,
                    heightFactor: 0.75,
                    child: Image.asset('assets/branding/prisma_fore.png'),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Prisma QR',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The simplest way to scan, create, and manage your QR codes. Fast, secure, and privacy-focused.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Scanner Preferences
          _buildSectionHeader(context, 'Scanner Preferences'),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Column(
              children: [
                Obx(
                  () => _buildToggleRow(
                    context,
                    icon: Icons.vibration,
                    label: 'Vibrate on Scan',
                    value: settingsController.hapticFeedback.value,
                    onChanged: (val) =>
                        settingsController.toggleHapticFeedback(val),
                  ),
                ),
                _buildDivider(context),
                Obx(
                  () => _buildToggleRow(
                    context,
                    icon: Icons.volume_up,
                    label: 'Beep on Scan',
                    value: settingsController.scanSounds.value,
                    onChanged: (val) =>
                        settingsController.toggleScanSounds(val),
                  ),
                ),
                _buildDivider(context),
                Obx(
                  () => _buildToggleRow(
                    context,
                    icon: Icons.content_copy,
                    label: 'Auto-Copy to Clipboard',
                    value: settingsController.autoCopy.value,
                    onChanged: (val) => settingsController.toggleAutoCopy(val),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // App Settings
          _buildSectionHeader(context, 'App Settings'),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Column(
              children: [
                Obx(
                  () => _buildNavigationRow(
                    context,
                    icon: Icons.dark_mode,
                    label: 'Theme',
                    valueText: settingsController.isDarkMode.value
                        ? 'Dark'
                        : 'Light',
                    onTap: () {
                      settingsController.toggleTheme(
                        !settingsController.isDarkMode.value,
                      );
                    },
                  ),
                ),
                _buildDivider(context),
                _buildNavigationRow(
                  context,
                  icon: Icons.history,
                  label: 'Clear History',
                  onTap: () => Get.bottomSheet(
                    ConfirmationBottomSheet(
                      header: "Clear History",
                      message: "Are you sure you want to clear your history?",
                      onConfirm: () =>
                          Get.find<HistoryController>().clearHistory(),
                    ),
                  ),
                ),
                _buildDivider(context),
                _buildNavigationRow(
                  context,
                  icon: Icons.privacy_tip,
                  label: 'Privacy Policy',
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Footer Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Service',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Support',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: isDark ? Colors.grey[500] : Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildToggleRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(
              context,
            ).colorScheme.primary, // Black in light mode, primary in dark
            activeTrackColor: isDark
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
                : Colors.black.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    String? valueText,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[700] : Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                if (valueText != null)
                  Text(
                    valueText,
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      height: 1,
      indent: 64, // Align with text
      color: isDark ? Colors.grey[800] : Colors.grey[100],
    );
  }
}
