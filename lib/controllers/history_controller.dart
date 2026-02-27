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

  Future<void> addRecord(QrCodeRecord record) async {
    if (record.type == 'scan') {
      int index = scannedHistory.indexWhere((r) => r.data == record.data);
      if (index != -1) {
        var existing = scannedHistory[index];
        scannedHistory.removeAt(index);
        scannedHistory.insert(
          0,
          existing.copyWith(
            timestamp: record.timestamp,
            title: record.title ?? existing.title,
          ),
        );
      } else {
        scannedHistory.insert(0, record);
      }
    } else {
      int index = generatedHistory.indexWhere((r) => r.data == record.data);
      if (index != -1) {
        var existing = generatedHistory[index];
        generatedHistory.removeAt(index);
        generatedHistory.insert(
          0,
          existing.copyWith(
            timestamp: record.timestamp,
            title: record.title ?? existing.title,
          ),
        );
      } else {
        generatedHistory.insert(0, record);
      }
    }
    await _saveCurrentState();
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
}
