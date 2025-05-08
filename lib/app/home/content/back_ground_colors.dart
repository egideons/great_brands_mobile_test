import 'package:flutter/material.dart';
import 'package:great_brands_mobile_test/theme/colors.dart';

backgroundColors() {
  return Column(
    children: [
      Container(
        height: 80,
        decoration: BoxDecoration(
          color: kHomeTopBackgroundColor,
        ),
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(color: kDarkBackgroundColor),
        ),
      ),
    ],
  );
}
