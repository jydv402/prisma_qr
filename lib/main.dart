import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'controllers/history_controller.dart';
import 'services/settings_service.dart';
import 'controllers/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize and inject Settings Service
  final settingsService = await SettingsService().init();
  Get.put(settingsService);

  // Initialize Settings Controller
  Get.put(SettingsController(Get.find<SettingsService>()));

  Get.put(HistoryController());

  runApp(const PrismaQrApp());
}

class PrismaQrApp extends StatelessWidget {
  const PrismaQrApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
        Get.find<SettingsController>();

    return GetMaterialApp(
      title: 'Prisma QR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: AppRoutes.main,
      getPages: AppRoutes.routes,
    );
  }
}
