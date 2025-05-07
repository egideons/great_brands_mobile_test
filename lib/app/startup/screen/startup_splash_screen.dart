// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/controllers/auth_controller.dart';
import '../content/startup_splash_android_scaffold.dart';

class StartupSplashScreen extends StatelessWidget {
  const StartupSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(AuthController());

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: const StartupSplashScreenScaffold(),
        );
      },
    );
  }
}
