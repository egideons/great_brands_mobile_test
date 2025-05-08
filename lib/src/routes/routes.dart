import 'package:get/get.dart';
import 'package:great_brands_mobile_test/app/enable_notif/screen/enable_notif.dart';
import 'package:great_brands_mobile_test/app/home/screen/home.dart';
import 'package:great_brands_mobile_test/app/login/screen/login.dart';
import 'package:great_brands_mobile_test/app/startup/screen/startup_splash_screen.dart';

class Routes {
  //Screens Route Names
  static const startupSplashScreen = "/";
  static const login = "/login";
  static const enableNotifications = "/enable-notifications";
  static const home = "/home";

  //Subroutes

  //========================= GET PAGES ==========================\\
  static final getPages = [
    //Startup Screens
    GetPage(name: startupSplashScreen, page: () => const StartupSplashScreen()),

    //Auth Screen
    GetPage(name: login, page: () => const Login()),
    GetPage(name: enableNotifications, page: () => const EnableNotif()),

    //Main App
    GetPage(name: home, page: () => const Home()),
  ];
}
