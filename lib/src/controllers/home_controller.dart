import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:great_brands_mobile_test/main.dart';
import 'package:great_brands_mobile_test/src/controllers/user_controller.dart';
import 'package:great_brands_mobile_test/src/models/market_news_list_model.dart';
import 'package:great_brands_mobile_test/src/models/market_news_model.dart';
import 'package:great_brands_mobile_test/src/service/api_url.dart';
import 'package:great_brands_mobile_test/src/service/http_client_service.dart';
import 'package:great_brands_mobile_test/src/service/notification_service.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find<HomeController>();

  //================ Controllers =================\\
  final scrollController = ScrollController();

  //================ Booleans =================\\
  var isScrollToTopBtnVisible = false.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;
  var hasError = false.obs;

  //================ Variables =================//
  var userController = UserController.instance;
  var firstName = "";
  var apiKey = dotenv.get('APIKEY', fallback: "API_KEY_NOT_FOUND");

  var isNotificationGranted = prefs.getBool("isNotificationGranted") ?? false;

  var marketNews = <MarketNewsModel>[].obs;
  var displayedMarketNews = <MarketNewsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserFirstName();
    loadContent();
    scrollController.addListener(scrollListener);
    createNotification();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> createNotification() async {
    await NotificationService.instance.showLocalNotification(
      id: 1,
      title: "Welcome to Great Brands",
      body:
          "Hello $firstName, welcome to Great Brands. We are glad to have you here. Enjoy your stay!",
      payload: "Welcome to Great Brands",
    );
  }

  //================ Load User =================\\
  Future<void> loadUserFirstName() async {
    firstName = userController.getFirstName() ?? "";
    log("User's first name: $firstName");
  }

  //================ Load Content =================\\
  Future<void> loadContent() async {
    isLoading.value = true;
    hasError.value = false;

    final url = ApiUrl.baseUrl +
        ApiUrl.marketNewsEndpoint +
        ApiUrl.category("general") +
        ApiUrl.token(apiKey);

    log("Requesting URL: $url");

    try {
      final response = await HttpClientService.getRequest(url);

      if (response == null) throw Exception("Null response from API");

      if (response.statusCode == 200) {
        final List<dynamic> responseJson = jsonDecode(response.body);
        final List<MarketNewsModel> newsList =
            MarketNewsListModel.fromJson(responseJson).news;

        marketNews.assignAll(newsList);
        displayedMarketNews.assignAll(marketNews.take(20));
        hasMoreData.value = displayedMarketNews.length < marketNews.length;

        log("Loaded ${displayedMarketNews.length} of ${marketNews.length} items");
      } else {
        throw HttpException("Failed with status code ${response.statusCode}");
      }
    } catch (e) {
      log("Error loading content: $e");
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  //================ Load More Content =================\\
  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    isLoadingMore.value = true;

    await Future.delayed(const Duration(seconds: 2)); // Simulate delay

    final currentLength = displayedMarketNews.length;
    final nextItems = marketNews.skip(currentLength).take(20).toList();

    displayedMarketNews.addAll(nextItems);
    hasMoreData.value = displayedMarketNews.length < marketNews.length;

    isLoadingMore.value = false;
  }

  //================ Scroll Handling =================\\
  void scrollListener() {
    if (scrollController.position.pixels >= 150) {
      isScrollToTopBtnVisible.value = true;
    } else {
      isScrollToTopBtnVisible.value = false;
    }

    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore.value &&
        hasMoreData.value) {
      loadMore();
    }
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }
}
