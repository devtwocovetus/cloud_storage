import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../colors/app_color.dart';

class BaseCardView extends StatelessWidget {
  const BaseCardView(
      {super.key,
      required this.cardWidth,
      required this.cardHeight,
      required this.backgroundColor,
      required this.image,
      required this.heading,
      required this.subHeading,
      required this.onTap,
      // required this.sub2Heading
      });

  final double cardWidth;
  final double cardHeight;
  final Color backgroundColor;
  final String image;
  final String heading;
  final String subHeading;
  // final String sub2Heading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: backgroundColor, width: 1.0.h),
            borderRadius: BorderRadius.circular(15),
          ),
          color: backgroundColor,
          child: Padding(
            padding: App.appSpacer.edgeInsets.all.sm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SVGAssetImage(
                  url: image,
                  height: 60.h,
                  width: 90.h,
                ),
                App.appSpacer.vHxs,
                CustomTextField(
                    textAlign: TextAlign.center,
                    text: heading,
                    fontSize: 18.0.sp,
                    fontColor: kAppBlack,
                    fontWeight: FontWeight.w400),
                App.appSpacer.vHxs,
                CustomTextField(
                    textAlign: TextAlign.center,
                    text: subHeading,
                    line: 4,
                    isMultyline: true,
                    fontSize: 12.0.sp,
                    fontColor: kAppBlack,
                    fontWeight: FontWeight.w400),
                // CustomTextField(
                //     textAlign: TextAlign.center,
                //     text: sub2Heading,
                //     fontSize: 12.0.sp,
                //     fontColor: kAppBlack,
                //     fontWeight: FontWeight.w400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
