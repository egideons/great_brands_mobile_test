import 'package:flutter/material.dart';
import 'package:great_brands_mobile_test/src/constants/consts.dart';
import 'package:great_brands_mobile_test/src/controllers/login_controller.dart';
import 'package:great_brands_mobile_test/src/utils/reusable/android_textformfield.dart';
import 'package:great_brands_mobile_test/theme/colors.dart';

loginForm(
  ColorScheme colorScheme,
  Size media,
  LoginController controller,
) {
  return Form(
    key: controller.formKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AndroidTextFormField(
          controller: controller.firstNameEC,
          hintText: "First Name",
          focusNode: controller.firstNameFN,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.name,
          onChanged: controller.firstNameOnChanged,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          inputBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          validator: (value) {
            return null;
          },
        ),
        kSizedBox,
        AndroidTextFormField(
          controller: controller.lastNameEC,
          hintText: "Last Name",
          focusNode: controller.lastNameFN,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.name,
          onChanged: controller.lastNameOnChanged,
          onFieldSubmitted: controller.onFieldSubmitted,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          inputBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(height: 4),
        SizedBox(height: media.height * .36),
      ],
    ),
  );
}
