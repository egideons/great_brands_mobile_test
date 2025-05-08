import 'package:blott_mobile_test/src/constants/assets.dart';
import 'package:blott_mobile_test/src/constants/consts.dart';
import 'package:blott_mobile_test/src/utils/button/android_elevated_button.dart';
import 'package:blott_mobile_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../src/controllers/notifications_controller.dart';

class EnableNotifScaffold extends GetView<NotificationsController> {
  const EnableNotifScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kLightBackgroundColor,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: kLightBackgroundColor),
      body: SafeArea(
        child: Center(
          heightFactor: media.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      Assets.notificationSvg,
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      colorFilter: ColorFilter.mode(
                          const Color(0xFFb3b6ba).withOpacity(.8),
                          BlendMode.srcIn),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kSizedBox,
                Text(
                  "Get the most out of Blott ✅",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: defaultTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: kTextTitleColor,
                  ),
                ),
                kSizedBox,
                Text(
                  "Allow notifications to stay in the loop with your payments, requests and groups.",
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: defaultTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: kTextSubtitleColor,
                  ),
                ),
                kSizedBox,
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 26),
        decoration: BoxDecoration(color: kLightBackgroundColor),
        child: Center(
          child: AndroidElevatedButton(
            title: "Continue",
            onPressed: controller.requestPermissionToSendNotifications,
          ),
        ),
      ),
    );
  }
}
