//default value
import 'dart:math';

import 'package:blott_mobile_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\s*$';
//Hide Digits pattern
const String hideDigits = r'\d';

const kBigSizedBox = SizedBox(height: kDefaultPadding * 2);
const kBigWidthSizedBox = SizedBox(width: kDefaultPadding * 2);

const kDefaultPadding = 20.0;
const kHalfDefaultPadding = 10.0;

const kHalfSizedBox = SizedBox(height: kDefaultPadding / 2);
const kHalfWidthSizedBox = SizedBox(width: kDefaultPadding / 2);

const kSizedBox = SizedBox(height: kDefaultPadding);
const kSmallSizedBox = SizedBox(height: 5);

const kSmallWidthSizedBox = SizedBox(width: 5);

const kWidthSizedBox = SizedBox(width: kDefaultPadding);

//username pattern
const String namePattern = r'^.{3,}$'; //Min. of 3 characters

defaultTextStyle({
  Color? color,
  Paint? background,
  Color? backgroundColor,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  String? debugLabel,
  String? fontFamily,
  double? fontSize,
  FontStyle? fontStyle,
  FontWeight? fontWeight,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? kFormFieldTextColor,
      background: background,
      backgroundColor: backgroundColor,
      decoration: decoration ?? TextDecoration.none,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      fontFamily: fontFamily ?? "Roboto",
      fontSize: fontSize ?? 14.0,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: fontWeight ?? FontWeight.w600,
      letterSpacing: letterSpacing ?? .60,
    );

String formatUNIXTime(int unixTimestamp) {
  // Convert the UNIX timestamp to DateTime
  DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

  // Format the date to '21 June 2021' using intl package
  String formattedDate = DateFormat('d MMMM yyyy').format(date);
  return formattedDate;
}

List<int> generateRandomNumbers(int limit, int num) {
  Random random = Random();
  List<int> randomNumbers = [];

  for (int i = 0; i < limit; i++) {
    randomNumbers
        .add(random.nextInt(num)); // Generates random number between 0 and 20
  }

  return randomNumbers;
}
