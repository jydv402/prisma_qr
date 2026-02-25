import 'package:get/get.dart';
import '../screens/main_screen.dart';
import '../screens/settings_screen.dart';

class AppRoutes {
  static const String main = '/';
  static const String settings = '/settings';

  static final routes = [
    GetPage(name: main, page: () => const MainScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
  ];
}
