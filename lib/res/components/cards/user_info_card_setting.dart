import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/setting/userlistsetting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../view_models/services/app_services.dart';
import '../../colors/app_color.dart';

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
                    App.appSpacer.vWxs,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                            textAlign: TextAlign.left,
                            text: Utils.textCapitalizationString(
                                user.name.toString()),
                            fontSize: 16.0,
                            fontColor: kAppBlack,
                            fontWeight: FontWeight.bold),
                        CustomTextField(
                            textAlign: TextAlign.left,
                            text: user.role == 2
                                ? 'Admin'
                                : user.role == 3
                                    ? 'Manager'
                                    : 'Employee',
                            fontSize: 12.0,
                            fontColor: kAppGreyB,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                    const Spacer(),
                    trailingWidget(context),
                  ],
                ),
                App.appSpacer.vHxs,
                const Divider(),
                App.appSpacer.vHxs,
                _statusWidget,
                App.appSpacer.vHxs,
                _phoneNumberWidget,
                App.appSpacer.vHxs,
                _emailWidget,
                App.appSpacer.vHxs,
                if (user.role != 2) ...[
                  const CustomTextField(
                      textAlign: TextAlign.left,
                      text:
                          '.................................................................................................................................................................................................................................................',
                      fontSize: 13.0,
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

                              Get.toNamed(RouteName
                                      .entityListAssignUserSettingScreen)!
                                  .then((value) {});
                            },
                            child: Column(
                              children: [
                                App.appSpacer.vHxs,
                                const CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: 'Assign',
                                  fontSize: 14.0,
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
      url: '',
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
        App.appSpacer.vWxs,
        if (user.role != 2) ...[
          SizedBox(
            width: App.appQuery.responsiveWidth(8),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                DialogUtils.showDeleteConfirmDialog(
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
          // App.appSpacer.vWxs,
          SizedBox(
            width: App.appQuery.responsiveWidth(8),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.toNamed(RouteName.updateUserView,
                  arguments: {
                    'user' : user
                  });
                },
                icon: SVGAssetImage(
                  height: App.appQuery.responsiveWidth(6),
                  width: App.appQuery.responsiveWidth(6),
                  url: 'assets/images/default/ic_edit_icon.svg',
                )),
          ),
        ],
      ],
    );
  }

  Widget get _statusWidget {
    bool status = user.status == '1' ? true : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Status',
            fontSize: 15.0,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400),
        App.appSpacer.vWxs,
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
              text: status ? 'Active' : 'Inactive',
              fontSize: 15.0,
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
        const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Phone Number',
            fontSize: 15.0,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400),
        App.appSpacer.vWxs,
        Expanded(
          child: CustomTextField(
              textAlign: TextAlign.right,
              text:
                  Utils.textCapitalizationString(user.contactNumber.toString()),
              fontSize: 15.0,
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
        const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Email Address',
            fontSize: 15.0,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400),
        App.appSpacer.vWxs,
        Expanded(
          child: CustomTextField(
              textAlign: TextAlign.right,
              text: user.email.toString(),
              fontSize: 15.0,
              fontColor: kAppBlack,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
