import 'package:get/get.dart';
import '../screens/main_screen.dart';

class AppRoutes {
  static const String main = '/';

  static final routes = [GetPage(name: main, page: () => const MainScreen())];
}
