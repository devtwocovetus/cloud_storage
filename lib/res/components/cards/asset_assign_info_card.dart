import 'dart:developer';

import 'package:cold_storage_flutter/models/cold_asset/asset_history_model.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user/userlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../view_models/services/app_services.dart';
import '../../colors/app_color.dart';

class AssetAssignInfoCardView extends StatelessWidget {
  const AssetAssignInfoCardView({
    super.key,
    required this.cardWidth,
    required this.cardHeight,
    required this.history,
  });

  final double cardWidth;
  final double cardHeight;
  final History history;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        // height: cardHeight,
        width: cardWidth,
        child: Card(
          margin: App.appSpacer.edgeInsets.symmetric(x: 'xxs', y: 'xs'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side:
                const BorderSide(style: BorderStyle.solid, color: kCardBorder),
          ),
          color: kAppWhite,
          child: Padding(
            padding: App.appSpacer.edgeInsets.symmetric(x: 's', y: 'xs'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            history.assignToUserName.toString()),
                        fontSize: 16.0.sp,
                        fontColor: kAppBlack,
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    SizedBox(
                      width: App.appQuery.responsiveWidth(8),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                         dialogReturn(context,history);
                          },
                          icon: SVGAssetImage(
                            height: 30.h,
                            width: 30.h,
                            url: 'assets/images/default/ic_info.svg',
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                const Divider(height: 1,),
                SizedBox(height: 2.h,),
                _headingWidget,
                SizedBox(height: 2.h,),
                _infoWidget,
                SizedBox(height: 2.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
dialogReturn(BuildContext context,History history) {
    log('HISTORYYY : ${history.toJson()}');
    log('HISTORYYY 2 : ${history.note}');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(15),
            backgroundColor: const Color(0xffffffff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child:CustomTextField(
                          textAlign: TextAlign.center,
                          text: 'Details',
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                        ),
                      SizedBox(height: 12.h,),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Assign By',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      SizedBox(height: 4.h,),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: Utils.textCapitalizationString(history.assignedBy.toString()),
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff808080)),
                      SizedBox(height: 12.h,),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Usage',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      SizedBox(height: 4.h,),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: Utils.textCapitalizationString(history.usages.toString()),
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff808080)),
                      SizedBox(height: 12.h,),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Note',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      SizedBox(height: 4.h,),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: history.note != null ? Utils.textCapitalizationString(history.note.toString()) : 'NA',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff808080)),
                      SizedBox(height: 24.h,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appQuery.responsiveWidth(5),
                            0,
                            App.appQuery.responsiveWidth(5),
                            0),
                        child: Align(
                          alignment: Alignment.center,
                          child: MyCustomButton(
                               textColor: const Color(0xff000000),
                                backgroundColor: const Color(0xffD9D9D9),
                                width: App.appQuery
                                    .responsiveWidth(30) /*312.0*/,
                                height: 45.h,
                                borderRadius: BorderRadius.circular(10.0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                text: 'Close',
                              ),
                        ),
                      ),
                    ],
                  
                ),
              ),
            ),
          );
        });
  }

  Widget get _headingWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: CustomTextField(
              textAlign: TextAlign.left,
              text: 'From',
              fontSize: 15.0.sp,
              fontColor: kAppGreyB,
              fontWeight: FontWeight.w400),
        ),
        Expanded(flex: 1, child: App.appSpacer.vWxs),
        Expanded(
          flex: 3,
          child: CustomTextField(
              textAlign: TextAlign.left,
              text: 'To',
              fontSize: 15.0.sp,
              fontColor: kAppGreyB,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget get _infoWidget {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      history.fromLocationOrEntityName.toString()),
                  fontSize: 15.0.sp,
                  fontColor: kAppBlack,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 8.h,),
              CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.dateFormate(history.startDate.toString()),
                  fontSize: 15.0,
                  fontColor: kAppGreyB,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: SVGAssetImage(
              height: 25.h,
              width: 25.h,
              url: 'assets/images/default/ic_forward_blue_arrow.svg',
            )),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      history.toLocationOrEntityName.toString()),
                  fontSize: 15.0.sp,
                  fontColor: kAppBlack,
                  fontWeight: FontWeight.w500),
              SizedBox(height: 8.h,),
              CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.dateFormateNew(history.endDate.toString()),
                  fontSize: 15.0.sp,
                  fontColor: kAppGreyB,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ],
    );
  }
}
