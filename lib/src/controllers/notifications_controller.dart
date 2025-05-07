import 'package:blott_mobile_test/app/home/screen/home.dart';
import 'package:blott_mobile_test/main.dart';
import 'package:blott_mobile_test/src/constants/consts.dart';
import 'package:blott_mobile_test/src/controllers/api_processor_controller.dart';
import 'package:blott_mobile_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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
      Get.defaultDialog(
        backgroundColor: kLightBackgroundColor,
        title: '"Blott" would like to Send You Notifications Denied',
        titleStyle: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        content: Text(
          'Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.',
          textAlign: TextAlign.center,
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        onConfirm: () async {
          PermissionStatus permissionStatus =
              await Permission.notification.request();

          if (permissionStatus.isGranted) {
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
          } else if (permissionStatus.isDenied) {
            Permission.accessNotificationPolicy.request();
          } else if (permissionStatus.isPermanentlyDenied) {
            openAppSettings();
          }
        },
        textConfirm: 'Allow',
        textCancel: "Cancel",
      );
    }
  }
}
