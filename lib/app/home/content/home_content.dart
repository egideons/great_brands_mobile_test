import 'package:flutter/material.dart';
import 'package:great_brands_mobile_test/src/constants/assets.dart';
import 'package:great_brands_mobile_test/src/constants/consts.dart';
import 'package:great_brands_mobile_test/theme/colors.dart';

homeContent({
  void Function()? onTap,
  String? imageSource,
  String? source,
  String? date,
  String? title,
}) {
  return InkWell(
    onTap: onTap ?? () {},
    borderRadius: BorderRadius.circular(4),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageSource!.isNotEmpty
                  ? NetworkImage(imageSource)
                  : const AssetImage(Assets.placeholderImage),
            ),
          ),
        ),
        kHalfWidthSizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // width: media.width / 3,
                    child: Text(
                      "$source".toUpperCase(),
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: kTextWhiteColor.withOpacity(.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "$date".toUpperCase(),
                      textAlign: TextAlign.end,
                      style: defaultTextStyle(
                        color: kTextWhiteColor.withOpacity(.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              kHalfSizedBox,
              Text(
                title ?? "",
                textAlign: TextAlign.start,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: defaultTextStyle(
                  color: kTextWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
