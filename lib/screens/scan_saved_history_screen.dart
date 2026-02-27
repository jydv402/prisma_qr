import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import '../widgets/scan_result_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

class ScanSavedHistoryScreen extends StatefulWidget {
  const ScanSavedHistoryScreen({super.key});

  @override
  State<ScanSavedHistoryScreen> createState() => _ScanSavedHistoryScreenState();
}

class _ScanSavedHistoryScreenState extends State<ScanSavedHistoryScreen> {
  bool _isScannedTab = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 18,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                // Header Title
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'History',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Scanned & Generated history',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  // Settings Icon button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: isDark ? Colors.white : Colors.grey[800],
                      ),
                      onPressed: () {
                        Get.toNamed('/settings');
                      },
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  // Swipe right to go to generated tab
                  if (details.primaryVelocity! > 0) {
                    setState(() => _isScannedTab = true);
                  } else {
                    setState(() => _isScannedTab = false);
                  }
                },
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 120,
                  ),
                  children: [
                    // Custom Tab Bar (Scanned / Saved)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isScannedTab = true),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _isScannedTab
                                      ? (isDark ? Colors.white : Colors.white)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: _isScannedTab && !isDark
                                      ? [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    'Scanned',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _isScannedTab
                                          ? (isDark
                                                ? Colors.black
                                                : Colors.black)
                                          : (isDark
                                                ? Colors.grey[400]
                                                : Colors.grey[600]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _isScannedTab = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: !_isScannedTab
                                      ? (isDark ? Colors.white : Colors.white)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: !_isScannedTab && !isDark
                                      ? [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    'Generated',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: !_isScannedTab
                                          ? (isDark
                                                ? Colors.black
                                                : Colors.black)
                                          : (isDark
                                                ? Colors.grey[400]
                                                : Colors.grey[600]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Lists matching mockup grouped by dates
                    const SizedBox(height: 8),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: _isScannedTab
                          ? _buildScannedList(context)
                          : _buildSavedList(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannedList(BuildContext context) {
    final HistoryController historyController = Get.find<HistoryController>();
    return Obx(() {
      if (historyController.scannedHistory.isEmpty) {
        return Column(
          key: const ValueKey('scanned'),
          children: const [
            SizedBox(height: 60),
            Center(child: Text('No scanned items yet.')),
          ],
        );
      }
      return Column(
        key: const ValueKey('scanned'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: historyController.scannedHistory.map((record) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  ScanResultBottomSheet(record: record),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              child: _buildHistoryListItem(
                context,
                record.iconName,
                record.title ?? 'Scan ${record.id.substring(0, 4)}',
                record.data,
                timeago.format(record.timestamp),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildSavedList(BuildContext context) {
    final HistoryController historyController = Get.find<HistoryController>();
    return Obx(() {
      if (historyController.generatedHistory.isEmpty) {
        return Column(
          key: const ValueKey('saved'),
          children: const [
            SizedBox(height: 60),
            Center(child: Text('No saved items yet.')),
          ],
        );
      }
      return Column(
        key: const ValueKey('saved'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: historyController.generatedHistory.map((record) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  ScanResultBottomSheet(record: record),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              child: _buildHistoryListItem(
                context,
                record.iconName,
                record.title ?? 'Generated ${record.id.substring(0, 4)}',
                record.data,
                timeago.format(record.timestamp),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildHistoryListItem(
    BuildContext context,
    String iconName,
    String title,
    String subtitle,
    String time,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Convert string iconName to IconData
    IconData icon;
    switch (iconName) {
      case 'qr_code_2':
        icon = Icons.qr_code_2;
        break;
      case 'text_fields':
        icon = Icons.text_fields;
        break;
      case 'contact_page':
        icon = Icons.contact_page;
        break;
      case 'shopping_cart':
        icon = Icons.shopping_cart_outlined;
        break;
      case 'link':
        icon = Icons.link;
        break;
      default:
        icon = Icons.qr_code_2;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.transparent),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[600] : Colors.grey[300],
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
