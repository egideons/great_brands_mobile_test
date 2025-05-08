import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:great_brands_mobile_test/app/home/screen/home.dart';
import 'package:great_brands_mobile_test/app/login/screen/login.dart';
import 'package:great_brands_mobile_test/src/controllers/user_controller.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () {
      loadApp();
    });
    super.onInit();
  }

  Future<void> loadApp() async {
    final UserController userController = UserController.instance;

    String firstName = userController.getFirstName() ?? "";

    if (firstName.isEmpty) {
      await Get.offAll(
        () => const Login(),
        routeName: "/intro",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    } else {
      await Get.offAll(
        () => const Home(),
        routeName: "/home",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    }
  }
}
