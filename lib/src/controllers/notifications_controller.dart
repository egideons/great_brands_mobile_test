import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:great_brands_mobile_test/app/home/screen/home.dart';
import 'package:great_brands_mobile_test/main.dart';
import 'package:great_brands_mobile_test/src/controllers/api_processor_controller.dart';
import 'package:great_brands_mobile_test/src/service/notification_service.dart';

class NotificationsController extends GetxController {
  static NotificationsController get instance {
    return Get.find<NotificationsController>();
  }

  var isNotificationGranted = prefs.getBool("isNotificationGranted") ?? false;

  void requestPermissionToSendNotifications() async {
    if (isNotificationGranted) {
      ApiProcessorController.successSnack("Notifications are already enabled");
      Get.offAll(
        () => const Home(),
        routeName: "/home",
        predicate: (route) => false,
        curve: Curves.easeInOut,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    } else {
      await NotificationService.instance.initialize();
      isNotificationGranted = true;
      prefs.setBool("isNotificationGranted", true);
      ApiProcessorController.successSnack("Notifications are enabled");

      Get.offAll(
        () => const Home(),
        routeName: "/home",
        predicate: (route) => false,
        curve: Curves.easeInOut,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    }
  }
}
