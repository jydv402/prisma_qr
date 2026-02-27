import 'package:get/get.dart';
import '../models/qr_code_model.dart';
import '../services/history_service.dart';

class HistoryController extends GetxController {
  final HistoryService _historyService = HistoryService();

  // Observable lists for scanned and saved (generated) codes
  var scannedHistory = <QrCodeRecord>[].obs;
  var generatedHistory = <QrCodeRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final allRecords = await _historyService.loadHistory();
    scannedHistory.value = allRecords.where((r) => r.type == 'scan').toList();
    generatedHistory.value = allRecords
        .where((r) => r.type == 'generate')
        .toList();

    // Sort latest first
    scannedHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    generatedHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<QrCodeRecord> addRecord(QrCodeRecord record) async {
    QrCodeRecord finalRecord;
    if (record.type == 'scan') {
      int index = scannedHistory.indexWhere((r) => r.data == record.data);
      if (index != -1) {
        var existing = scannedHistory[index];
        scannedHistory.removeAt(index);
        finalRecord = existing.copyWith(
          timestamp: record.timestamp,
          title: record.title ?? existing.title,
        );
        scannedHistory.insert(0, finalRecord);
      } else {
        scannedHistory.insert(0, record);
        finalRecord = record;
      }
    } else {
      int index = generatedHistory.indexWhere((r) => r.data == record.data);
      if (index != -1) {
        var existing = generatedHistory[index];
        generatedHistory.removeAt(index);
        finalRecord = existing.copyWith(
          timestamp: record.timestamp,
          title: record.title ?? existing.title,
        );
        generatedHistory.insert(0, finalRecord);
      } else {
        generatedHistory.insert(0, record);
        finalRecord = record;
      }
    }
    await _saveCurrentState();
    return finalRecord;
  }

  Future<void> updateRecord(QrCodeRecord updatedRecord) async {
    if (updatedRecord.type == 'scan') {
      int index = scannedHistory.indexWhere((r) => r.id == updatedRecord.id);
      if (index != -1) {
        scannedHistory[index] = updatedRecord;
      }
    } else {
      int index = generatedHistory.indexWhere((r) => r.id == updatedRecord.id);
      if (index != -1) {
        generatedHistory[index] = updatedRecord;
      }
    }
    await _saveCurrentState();
  }

  Future<void> clearHistory() async {
    scannedHistory.clear();
    generatedHistory.clear();
    await _historyService.clearHistory();
    await _saveCurrentState();
  }

  Future<void> _saveCurrentState() async {
    final allRecords = [...scannedHistory, ...generatedHistory];
    await _historyService.saveHistory(allRecords);
  }

  Future<void> deleteRecord(String id) async {
    scannedHistory.removeWhere((r) => r.id == id);
    generatedHistory.removeWhere((r) => r.id == id);
    await _historyService.deleteRecord(id);
    await _saveCurrentState();
  }
}
