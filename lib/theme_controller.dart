// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = true.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
  }
}
