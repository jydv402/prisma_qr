import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HistoryItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String format;
  final String type;
  final String time;
  final Color formatColor;
  final Color typeColor;

  const HistoryItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.format,
    required this.type,
    required this.time,
    required this.formatColor,
    required this.typeColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                // Title
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // Subtitle, the data of the QR code
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  spacing: 4,
                  children: [
                    // Format tag
                    _buildTag(format, formatColor, isDark),

                    // Type tag
                    _buildTag(type.toUpperCase(), typeColor, isDark),

                    // Time tag
                    _buildTag(time, Colors.green, isDark),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDark ? Colors.white : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(2),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: QrImageView(
                  data: subtitle,
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.3 : 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isDark ? color.withValues(alpha: 0.9) : color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'GSansFlex',
        ),
      ),
    );
  }
}
