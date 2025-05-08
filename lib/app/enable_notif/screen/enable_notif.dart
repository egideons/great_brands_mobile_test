// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:great_brands_mobile_test/app/enable_notif/content/enable_notif_scaffold.dart';
import 'package:great_brands_mobile_test/src/controllers/notifications_controller.dart';

class EnableNotif extends StatelessWidget {
  const EnableNotif({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialise controller
    Get.put(NotificationsController());

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const EnableNotifScaffold(),
    );
  }
}
