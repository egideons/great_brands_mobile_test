import 'dart:async';
import 'dart:developer';

import 'package:blott_mobile_test/src/controllers/api_processor_controller.dart';
import 'package:blott_mobile_test/theme/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityStatusController extends GetxController {
  static ConnectivityStatusController get instance {
    return Get.find<ConnectivityStatusController>();
  }

  var isConnected = false.obs;
  var connectionType = ''.obs;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1));
    // initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    if (result.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      ApiProcessorController.successSnack(
        "Cellular network is connected",
        icon: Icon(
          Icons.signal_cellular_4_bar_rounded,
          size: 16,
          color: kSuccessColor,
        ),
      );
    } else if (result.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      ApiProcessorController.successSnack(
        "Wi-Fi is connected",
        icon: Icon(Icons.signal_wifi_4_bar, size: 16, color: kSuccessColor),
      );
    } else if (result.contains(ConnectivityResult.none)) {
      ApiProcessorController.errorSnack(
        "No internet connection",
        icon: Icon(Icons.signal_wifi_off, size: 16, color: kErrorColor),
      );
    }
    log('Connectivity changed: $_connectionStatus');
  }
}
