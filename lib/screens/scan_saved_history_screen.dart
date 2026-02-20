import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_nav_controller.dart';

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
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Navigate back to scanner via bottom nav
                      final BottomNavController controller = Get.find();
                      controller.changeIndex(0);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  Text(
                    'History',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 120,
                ),
                children: [
                  // 2. Custom Tab Bar (Scanned / Saved)
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
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                                        ? (isDark ? Colors.black : Colors.black)
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
                            onTap: () => setState(() => _isScannedTab = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                                  'Saved',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: !_isScannedTab
                                        ? (isDark ? Colors.black : Colors.black)
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

                  // 3. Lists matching mockup grouped by dates
                  const SizedBox(height: 8),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isScannedTab
                        ? _buildScannedList(context)
                        : _buildSavedList(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannedList(BuildContext context) {
    return Column(
      key: const ValueKey('scanned'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Today'),
        _buildHistoryListItem(
          context,
          'qr_code_2',
          'Nixtio Dashboard',
          'https://nixtio.com/dashboard/user...',
          '9:41 AM',
        ),
        const SizedBox(height: 16),
        _buildHistoryListItem(
          context,
          'text_fields',
          'WiFi: Guest_Network',
          'WPA2 • Password: ********',
          '8:30 AM',
        ),
        const SizedBox(height: 32),

        _buildSectionHeader(context, 'Yesterday'),
        _buildHistoryListItem(
          context,
          'contact_page',
          'Contact: John Doe',
          'vCard • +1 (555) 0123-4567',
          '4:15 PM',
        ),
        const SizedBox(height: 16),
        _buildHistoryListItem(
          context,
          'shopping_cart',
          'Product: 890123...',
          'EAN-13 • Amazon Search',
          '11:20 AM',
        ),
        const SizedBox(height: 32),

        _buildSectionHeader(context, 'Older'),
        _buildHistoryListItem(
          context,
          'link',
          'Menu: Cafe Delight',
          'http://cafedelight.com/menu_pdf',
          'Oct 24',
        ),
      ],
    );
  }

  Widget _buildSavedList(BuildContext context) {
    return Column(
      key: const ValueKey('saved'),
      children: const [
        // Placeholder for saved items
        SizedBox(height: 60),
        Center(child: Text('No saved items yet.')),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 16),
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
        icon = Icons.error;
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
              color: Colors.black.withOpacity(0.02),
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

// NOTE: This uses GetX controller to navigate back to Scanner but since MainScreen manages index, that requires an import.
// I will import it conditionally or use Get.find. Included in code above.
