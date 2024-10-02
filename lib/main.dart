import 'package:bhpp/dark_theme.dart';
import 'package:bhpp/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'theme_controller.dart'; // Import the theme controller

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController()); // Initialize the ThemeController

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return Obx(() => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'My Flutter App',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: themeController.isDark.value
                  ? const DarkTheme()
                  : const HomeScreen(),
            ));
      },
    );
  }
}
