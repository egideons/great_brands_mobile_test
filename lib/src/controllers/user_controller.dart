import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserController extends GetxController {
  static UserController get instance {
    return Get.find<UserController>();
  }

  final userBox = Hive.box('userBox');

  // Method to store user details
  void storeUserDetails(String firstName, String lastName) {
    userBox.put('firstName', firstName);
    userBox.put('lastName', lastName);
  }

  // Method to retrieve user's first name
  String? getFirstName() {
    return userBox.get('firstName', defaultValue: '') ?? "";
  }

  // Method to retrieve user's last name
  String? getLastName() {
    return userBox.get('lastName', defaultValue: '') ?? "";
  }
}
