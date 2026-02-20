import 'dart:convert';

class QrCodeRecord {
  final String id;
  final String data;
  final String type; // 'scan' or 'generate'
  final String format; // 'URL', 'Wi-Fi', 'Text', 'Contact', 'Product', etc.
  final DateTime timestamp;

  QrCodeRecord({
    required this.id,
    required this.data,
    required this.type,
    required this.format,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'type': type,
      'format': format,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory QrCodeRecord.fromMap(Map<String, dynamic> map) {
    return QrCodeRecord(
      id: map['id'] ?? '',
      data: map['data'] ?? '',
      type: map['type'] ?? '',
      format: map['format'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory QrCodeRecord.fromJson(String source) =>
      QrCodeRecord.fromMap(json.decode(source));

  /// Helper to determine suitable icon based on format
  String get iconName {
    final fmt = format.toLowerCase();
    if (fmt.contains('url') || fmt.contains('website') || fmt.contains('link'))
      return 'link';
    if (fmt.contains('wifi') || fmt.contains('wi-fi'))
      return 'text_fields'; // mockup uses text_fields for wifi oddly, but we can use wifi too. Let's use 'text_fields' for exact match or 'wifi'. Let's stick to safe strings.
    if (fmt.contains('contact') || fmt.contains('vcard')) return 'contact_page';
    if (fmt.contains('product') || fmt.contains('ean') || fmt.contains('upc'))
      return 'shopping_cart';
    if (fmt.contains('text')) return 'text_fields';
    return 'qr_code_2';
  }
}
