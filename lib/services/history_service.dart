import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/qr_code_model.dart';

class HistoryService {
  static const String _fileName = 'qr_history.json';

  Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<List<QrCodeRecord>> loadHistory() async {
    try {
      final file = await _file;
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      if (contents.isEmpty) return [];

      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.map((json) => QrCodeRecord.fromMap(json)).toList();
    } catch (e) {
      print('Error loading history: $e');
      return [];
    }
  }

  Future<void> saveHistory(List<QrCodeRecord> history) async {
    try {
      final file = await _file;
      final jsonList = history.map((record) => record.toMap()).toList();
      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      print('Error saving history: $e');
    }
  }
}
