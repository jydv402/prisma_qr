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
      scannedHistory.insert(0, record);
    } else {
      generatedHistory.insert(0, record);
    }
    await _saveCurrentState();
  }

  Future<void> clearHistory() async {
    scannedHistory.clear();
    generatedHistory.clear();
    await _saveCurrentState();
  }

  Future<void> _saveCurrentState() async {
    final allRecords = [...scannedHistory, ...generatedHistory];
    await _historyService.saveHistory(allRecords);
  }
}
