import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/setting/userlistsetting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../view_models/services/app_services.dart';
import '../../colors/app_color.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class UserInfoCardSettingView extends StatelessWidget {
  UserInfoCardSettingView(
      {super.key,
      required this.cardWidth,
      required this.cardHeight,
      required this.user});

  final double cardWidth;
  final double cardHeight;
  final UsersList user;

  final UserlistsettingViewModel controller = Get.find();
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
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
          color: user.role == 2 ? kBinCardBackground : kAppWhite,
          child: Padding(
            padding: App.appSpacer.edgeInsets.symmetric(x: 's', y: 's'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _profileImageView,
                    SizedBox(width: 8.h,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                              textAlign: TextAlign.left,
                              text: Utils.textCapitalizationString(user.name.toString()),
                              fontSize: 16.0.sp,
                              fontColor: kAppBlack,
                              fontWeight: FontWeight.bold),
                          CustomTextField(
                              textAlign: TextAlign.left,
                              text: user.role == 2
                                  ? 'Admin'
                                  : user.role == 3
                                      ? 'Manager'
                                      : 'Employee',
                              fontSize: 12.0.sp,
                              fontColor: kAppGreyB,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                    // const Spacer(),
                    trailingWidget(context),
                  ],
                ),
                SizedBox(height: 8.h,),
                const Divider(),
                SizedBox(height: 8.h,),
                _statusWidget,
                SizedBox(height: 8.h,),
                _phoneNumberWidget,
                SizedBox(height: 8.h,),
                _emailWidget,
                SizedBox(height: 8.h,),
                if (user.role != 2) ...[
                  CustomTextField(
                      textAlign: TextAlign.left,
                      text:
                          '.................................................................................................................................................................................................................................................',
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xffD4D4D4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: /*Obx(() =>*/
                            Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                  RouteName.entityListAssignUserSettingScreen,
                                  arguments: [
                                    {"userId": user.id.toString()}
                                  ]);

                              // Get.toNamed(RouteName
                              //         .entityListAssignUserSettingScreen)!
                              //     .then((value) {});
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 8.h,),
                                CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: translation.assign,
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w400,
                                  fontColor: kAppPrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // )
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _profileImageView {
    return AppCachedImage.profilePicture(
      url: user.profileImage,
    );
  }

  Widget trailingWidget(BuildContext context) {
    String role = user.role == 2
        ? 'A'
        : user.role == 3
            ? 'M'
            : 'E';

    return Row(
      children: [
        SizedBox(
          height: App.appQuery.responsiveWidth(6),
          width: App.appQuery.responsiveWidth(6),
          child: CircleAvatar(
            backgroundColor: kAppGreen,
            child: Text(
              role,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 8.h,),
        if (user.role != 2) ...[
          if(Utils.decodedMap['delete_user'] == true)...[
  SizedBox(
            width: App.appQuery.responsiveWidth(8),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                DialogUtils.showDeleteConfirmDialog(
                  title: translation.alert,
                  okBtnText: translation.yes,
                  cancelBtnText: translation.no,
                  context,
                  okBtnFunction: () {
                    Get.back(closeOverlays: true);
                    controller.deleteUser(user.id.toString());
                  },
                );
              },
              icon: SVGAssetImage(
                  height: App.appQuery.responsiveWidth(6),
                  width: App.appQuery.responsiveWidth(6),
                  url: 'assets/images/default/ic_delete_icon.svg'),
            ),
          ),
          ],
        if(Utils.decodedMap['edit_user'] == true)...[
          SizedBox(
            width: App.appQuery.responsiveWidth(8),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.toNamed(RouteName.updateUserView,
                  arguments: {
                    'user' : user,
                     'updation_code' : '0'
                  });
                },
                icon: SVGAssetImage(
                  height: App.appQuery.responsiveWidth(6),
                  width: App.appQuery.responsiveWidth(6),
                  url: 'assets/images/default/ic_edit_icon.svg',
                )),
          ),
        ],
          // App.appSpacer.vWxs,
          
        ],
      ],
    );
  }

  Widget get _statusWidget {
    bool status = user.status == '1' ? true : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         CustomTextField(
            textAlign: TextAlign.left,
            text: translation.status,
            fontSize: 15.0.sp,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400),
        SizedBox(width: 8.h,),
        Container(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'sm', y: 'xxs'),
          decoration: BoxDecoration(
              color: status
                  ? kAppGreen.withOpacity(0.2)
                  : kAppError.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  style: BorderStyle.solid,
                  color: status
                      ? kAppGreen.withOpacity(0.5)
                      : kAppError.withOpacity(0.5))),
          child: CustomTextField(
              textAlign: TextAlign.left,
              text: status ? translation.active : translation.inactive,
              fontSize: 15.0.sp,
              fontColor: status ? kAppGreen : kAppError,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget get _phoneNumberWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextField(
            textAlign: TextAlign.left,
            text: translation.phone_number,
            fontSize: 15.0.sp,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400),
        SizedBox(width: 8.h,),
        Expanded(
          child: CustomTextField(
              textAlign: TextAlign.right,
              text:
                  Utils.textCapitalizationString(user.contactNumber.toString()),
              fontSize: 15.0.sp,
              fontColor: kAppBlack,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget get _emailWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextField(
            textAlign: TextAlign.left,
            text: translation.email_address,
            fontSize: 15.0.sp,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400),
        SizedBox(width: 8.h,),
        Expanded(
          child: CustomTextField(
              textAlign: TextAlign.right,
              text: user.email.toString(),
              fontSize: 15.0.sp,
              fontColor: kAppBlack,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
