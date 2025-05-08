import 'package:flutter/material.dart';
import 'package:great_brands_mobile_test/theme/colors.dart';

import 'startup_splash_screen_content.dart';

class StartupSplashScreenScaffold extends StatelessWidget {
  const StartupSplashScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      body: SafeArea(
        child: startupSplashScreenContent(media, colorScheme),
      ),
    );
  }
}
