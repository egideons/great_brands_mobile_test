import 'package:blott_mobile_test/theme/colors.dart';
import 'package:flutter/material.dart';

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
