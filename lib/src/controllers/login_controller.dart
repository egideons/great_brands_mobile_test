import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:great_brands_mobile_test/src/constants/consts.dart';
import 'package:great_brands_mobile_test/src/controllers/api_processor_controller.dart';
import 'package:great_brands_mobile_test/src/controllers/user_controller.dart';
import 'package:hive/hive.dart';

import '../../app/enable_notif/screen/enable_notif.dart';

class LoginController extends GetxController {
  static LoginController get instance {
    return Get.find<LoginController>();
  }

  //=========== Variables =============\\
  var formKey = GlobalKey<FormState>();
  final userBox = Hive.box('userBox');
  var userController = UserController.instance;

  //=========== Booleans =============\\
  var formIsValid = false.obs;
  var isLoading = false.obs;

  //=========== Controllers =============\\
  var firstNameEC = TextEditingController();
  var lastNameEC = TextEditingController();

  //=========== Focus Nodes =============\\
  var firstNameFN = FocusNode();
  var lastNameFN = FocusNode();

  //=========== On Changed =============\\
  firstNameOnChanged(String value) {
    if (value.isEmpty) {
      formIsValid.value = false;
    } else {
      if (lastNameEC.text.isEmpty) {
        formIsValid.value = false;
      } else {
        formIsValid.value = true;
      }
    }
  }

  lastNameOnChanged(String value) {
    if (value.isEmpty) {
      formIsValid.value = false;
    } else {
      if (firstNameEC.text.isEmpty) {
        formIsValid.value = false;
      } else {
        formIsValid.value = true;
      }
    }
  }

  onFieldSubmitted(String value) {
    if (formIsValid.value) {
      login();
    }
    return;
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      var nameRegExp = RegExp(namePattern);

      if (firstNameEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your first name");
        return;
      } else if (lastNameEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your last name");
        return;
      } else if (!nameRegExp.hasMatch(firstNameEC.text)) {
        ApiProcessorController.errorSnack(
          "First name must be at least 3 characters",
        );
        return;
      } else if (!nameRegExp.hasMatch(lastNameEC.text)) {
        ApiProcessorController.errorSnack(
          "Last name must be at least 3 characters",
        );
        return;
      }

      isLoading.value = true;
      update();

      //Store user details to hive storage (local storage)
      userController.storeUserDetails(firstNameEC.text, lastNameEC.text);

      await Future.delayed(const Duration(milliseconds: 800));
      String firstName = userController.getFirstName() ?? "";
      String lastName = userController.getLastName() ?? "";

      if (firstName.isNotEmpty && lastName.isNotEmpty) {
        log(
          "User's first and last name: $firstName $lastName",
          name: "User's Name",
        );
        ApiProcessorController.successSnack("Login successful");
        await Get.offAll(
          () => const EnableNotif(),
          routeName: "/enable-notifications",
          fullscreenDialog: true,
          curve: Curves.easeInOut,
          predicate: (routes) => false,
          popGesture: false,
          transition: Get.defaultTransition,
        );
      }

      isLoading.value = false;
      update();
    }
  }
}
