// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:great_brands_mobile_test/src/constants/consts.dart';

import '../../../theme/colors.dart';

class ApiProcessorController extends GetxController {
  static Future<dynamic> errorState(data) async {
    try {
      if (data.statusCode == 200) {
        return data.body;
      }
      // errorSnack("Something went wrong");
      return;
    } catch (e) {
      // errorSnack("Check your internet and try again");
      return;
    }
  }

  static void successSnack(String? msg, {Icon? icon}) {
    var media = MediaQuery.of(Get.context!).size;
    Get.showSnackbar(
      GetSnackBar(
        // titleText: SizedBox(
        //   width: Get.width,
        //   child: Text(
        //     "",
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 4,
        //     style: defaultTextStyle(
        //       color: kWhiteBackgroundColor,
        //       fontSize: 14.0,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        messageText: Text(
          msg ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
          style: defaultTextStyle(
            color: kSuccessColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: icon ??
            Icon(
              Icons.check_circle,
              size: 16,
              color: kSuccessColor,
            ),
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: kLightBackgroundColor,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        maxWidth: media.width - 40,
        duration: const Duration(seconds: 2),
        boxShadows: [
          BoxShadow(
            color: kGreyColor.withOpacity(.2),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withOpacity(0.6)],
        // ),
        // margin: const EdgeInsets.all(60),
        // mainButton: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   color: kWhiteBackgroundColor,
        //   icon: const Icon(
        //     Icons.cancel,
        //     size: 14,
        //   ),
        // ),
      ),
    );
  }

  static void errorSnack(String? msg, {Icon? icon}) {
    var media = MediaQuery.of(Get.context!).size;

    Get.showSnackbar(
      GetSnackBar(
        // titleText: SizedBox(
        //   width: Get.width,
        //   child: Text(
        //     msg,
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 4,
        //     style: defaultTextStyle(
        //       color: kWhiteBackgroundColor,
        //       fontSize: 14.0,
        //       fontWeight: FontWeight.w600,
        //       letterSpacing: -0.40,
        //     ),
        //   ),
        // ),
        messageText: Text(
          msg ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: defaultTextStyle(
            color: kErrorColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.40,
          ),
        ),
        icon: icon ??
            Icon(
              Icons.error_rounded,
              size: 18,
              color: kErrorColor,
            ),
        shouldIconPulse: true,
        isDismissible: true,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        maxWidth: media.width - 40,
        backgroundColor: kLightBackgroundColor,
        duration: const Duration(seconds: 2),
        boxShadows: [
          BoxShadow(
            color: kGreyColor.withOpacity(.2),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withOpacity(0.6)],
        // ),
        // margin: const EdgeInsets.all(60),
        // mainButton: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.cancel,
        //     size: 14,
        //     color: kErrorColor,
        //   ),
        // ),
      ),
    );
  }

  static void warningSnack(String? msg, {Icon? icon}) {
    var media = MediaQuery.of(Get.context!).size;

    Get.showSnackbar(
      GetSnackBar(
        // titleText: SizedBox(
        //   width: Get.width,
        //   child: Text(
        //     msg,
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 4,
        //     style: defaultTextStyle(
        //       color: kWhiteBackgroundColor,
        //       fontSize: 14.0,
        //       fontWeight: FontWeight.w600,
        //       letterSpacing: -0.40,
        //     ),
        //   ),
        // ),
        messageText: Text(
          msg ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: defaultTextStyle(
            color: kWarningColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.40,
          ),
        ),
        icon: icon ??
            Icon(
              Icons.warning_rounded,
              size: 18,
              color: kWarningColor,
            ),
        shouldIconPulse: true,
        isDismissible: true,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        maxWidth: media.width - 40,
        backgroundColor: kLightBackgroundColor,
        duration: const Duration(seconds: 2),
        boxShadows: [
          BoxShadow(
            color: kGreyColor.withOpacity(.2),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withOpacity(0.6)],
        // ),
        // margin: const EdgeInsets.all(60),
        // mainButton: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.cancel,
        //     size: 14,
        //     color: kWarningColor,
        //   ),
        // ),
      ),
    );
  }
}
