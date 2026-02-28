import 'package:flutter/material.dart';

/// Build a divider with a dark color for dark mode and a light color for light mode
///
/// [context] - The context of the widget
/// Used in qr_display.dart, settings_screen.dart
Widget buildDivider(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Divider(
    height: 1,
    indent: 64, // Align with text
    color: isDark ? Colors.grey[800] : Colors.grey[100],
  );
}
