import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../src/constants/assets.dart';

startupSplashScreenContent(Size media, ColorScheme colorScheme) {
  return Center(
    child: SvgPicture.asset(
      Assets.appIconSvg,
      height: media.height * .074,
      width: media.width * .074,
    ),
  );
}
