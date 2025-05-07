// ignore_for_file: unrelated_type_equality_checks

import 'package:blott_mobile_test/app/home/content/home_scaffold.dart';
import 'package:blott_mobile_test/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialise controller`
    Get.put(HomeController());

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const HomeScaffold(),
    );
  }
}
