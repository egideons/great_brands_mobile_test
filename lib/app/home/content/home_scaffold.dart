import 'package:blott_mobile_test/app/home/content/back_ground_colors.dart';
import 'package:blott_mobile_test/app/home/content/home_content.dart';
import 'package:blott_mobile_test/src/constants/consts.dart';
import 'package:blott_mobile_test/src/controllers/home_controller.dart';
import 'package:blott_mobile_test/src/controllers/url_launch_controller.dart';
import 'package:blott_mobile_test/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScaffold extends GetView<HomeController> {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      floatingActionButton: Obx(
        () => controller.isScrollToTopBtnVisible.value
            ? FloatingActionButton.small(
                onPressed: controller.scrollToTop,
                backgroundColor: kPrimaryColor,
                foregroundColor: kLightBackgroundColor,
                child: const Icon(Icons.keyboard_arrow_up),
              )
            : const SizedBox(),
      ),
      appBar: AppBar(
        backgroundColor: kHomeTopBackgroundColor,
        toolbarHeight: 90,
        elevation: 0,
        toolbarOpacity: 1,
        title: Text(
          "Hey ${controller.firstName}",
          style: defaultTextStyle(
            color: kTextWhiteColor,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: Stack(
            children: [
              backgroundColors(),
              GetBuilder<HomeController>(
                init: HomeController(),
                builder: (controller) {
                  if (controller.isLoading.value) {
                    return CupertinoActivityIndicator(color: kPrimaryColor);
                  }
                  if (controller.hasError.value) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Something went wrong. Please try again later.",
                        textAlign: TextAlign.start,
                        style: defaultTextStyle(
                          color: kTextWhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: controller.displayedMarketNews.length +
                          (controller.hasMoreData.value ? 1 : 0),
                      controller: controller.scrollController,
                      padding: const EdgeInsets.all(10),
                      separatorBuilder: (context, index) => kSizedBox,
                      itemBuilder: (context, index) {
                        var news = controller.marketNews[index];
                        return homeContent(
                          source: news.source,
                          date: formatUNIXTime(news.datetime),
                          imageSource: news.image,
                          title: news.headline,
                          onTap: () {
                            UrlLaunchController.launchWeb(
                              news.url,
                              LaunchMode.externalApplication,
                            );
                          },
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
