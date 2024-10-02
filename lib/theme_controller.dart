import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = true.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
  }
}
