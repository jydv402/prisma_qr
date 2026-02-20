import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'controllers/history_controller.dart';

void main() {
  Get.put(HistoryController());
  runApp(const PrismaQrApp());
}

class PrismaQrApp extends StatelessWidget {
  const PrismaQrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Prisma QR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.main,
      getPages: AppRoutes.routes,
    );
  }
}
