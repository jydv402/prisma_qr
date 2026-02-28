import 'package:flutter/material.dart';

/// Build a section header with title
///
/// [title] - The title to display on the header
/// Used in qr_display.dart, settings_screen.dart
Widget buildSectionHeader(BuildContext context, String title) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Padding(
    padding: const EdgeInsets.only(left: 8, bottom: 12),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(
        color: isDark ? Colors.grey[500] : Colors.grey[600],
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
    ),
  );
}
