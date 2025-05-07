import 'dart:convert';
import 'dart:developer';

import 'package:blott_mobile_test/main.dart';
import 'package:blott_mobile_test/src/constants/consts.dart';
import 'package:blott_mobile_test/src/controllers/api_processor_controller.dart';
import 'package:blott_mobile_test/src/controllers/user_controller.dart';
import 'package:blott_mobile_test/src/models/market_news_list_model.dart';
import 'package:blott_mobile_test/src/models/market_news_model.dart';
import 'package:blott_mobile_test/src/service/api_url.dart';
import 'package:blott_mobile_test/src/service/http_client_service.dart';
import 'package:blott_mobile_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  static HomeController get instance {
    return Get.find<HomeController>();
  }

  @override
  void onInit() async {
    if (!isNotificationGranted) requestPermissionToSendNotifications();
    loadUserFirstName();
    await loadContent();
    await loadInitialData();
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  //================ Controllers =================\\
  var scrollController = ScrollController();

  //================ Booleans =================\\
  var isScrollToTopBtnVisible = false.obs;
  var isLoading = false.obs;
  var hasMoreData = true.obs;
  var hasError = false.obs;

  //================ Variables =================//
  var userController = UserController.instance;
  var firstName = "";
  var apiKey = dotenv.get('APIKEY', fallback: "API_KEY_NOT_FOUND");

  //================ Scroll to Top =================//
  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

//================ Scroll Listener =================//

  void scrollListener() {
    //========= Show action button ========//
    if (scrollController.position.pixels >= 150) {
      isScrollToTopBtnVisible.value = true;
      update();
    }
    //========= Hide action button ========//
    else if (scrollController.position.pixels < 150) {
      isScrollToTopBtnVisible.value = false;
      update();
    }
  }

//================ Check notification permission status =================//
  var isNotificationGranted = prefs.getBool("isNotificationGranted") ?? false;

  void requestPermissionToSendNotifications() async {
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

          Get.close(0);
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

  Future<void> loadUserFirstName() async {
    firstName = userController.getFirstName() ?? "";
    log("User's first name:$firstName");
  }

  //================ Load Content =================//
  var marketNewsListModel = MarketNewsListModel.fromJson(null).obs;
  var marketNewsModel = MarketNewsModel.fromJson(null).obs;
  var marketNews = <MarketNewsModel>[].obs;
  List<MarketNewsModel> displayedMarketNews = [];

  //Load initialContent - First 20
  Future<void> loadInitialData() async {
    displayedMarketNews = marketNews.take(20).toList();
    hasMoreData.value = displayedMarketNews.length < marketNews.length;
    update();
  }

  //Load More Content
  Future<void> loadMore() async {
    int currentLength = displayedMarketNews.length;

    await Future.delayed(const Duration(seconds: 2)); // Simulate loading delay

    displayedMarketNews.addAll(marketNews.skip(currentLength).take(20));
    hasMoreData.value = displayedMarketNews.length < marketNews.length;
    update();
  }

  Future<void> loadContent() async {
    isLoading.value = true;
    update();

    var url = ApiUrl.baseUrl +
        ApiUrl.marketNewsEndpoint +
        ApiUrl.category("general") +
        ApiUrl.token(apiKey);

    log("This is the url: $url");

    //HTTP Client Service
    http.Response? response = await HttpClientService.getRequest(url);

    if (response == null) {
      isLoading.value = false;
      log("The response is null");
      return;
    }
    try {
      // Convert to json
      var responseJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        hasError.value = false;
        update();
        // Map the response to MarketNewsListModel
        List<dynamic> newsJsonList = responseJson as List<dynamic>;
        marketNewsListModel.value = MarketNewsListModel.fromJson(newsJsonList);

        // Assign the individual MarketNewsModel list to marketNews observable
        marketNews.value = marketNewsListModel.value.news;

        // Print the first item in the marketNews list to verify mapping
        if (marketNews.isNotEmpty) {
          log("First news item: ${marketNews.first.headline}");
        }
      } else {
        hasError.value = true;
        update();
        log("Request failed with status: ${response.statusCode}");
        log("Response body: ${response.body}");
      }
    } catch (e) {
      hasError.value = true;
      update();
      log(e.toString());
    }

    isLoading.value = false;
    update();
  }
}
