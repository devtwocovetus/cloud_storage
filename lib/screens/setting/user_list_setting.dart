import 'dart:io';

import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/res/components/cards/user_info_card_setting.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/setting/userlistsetting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/services/app_services.dart';

class UserListSetting extends StatelessWidget {
  UserListSetting({super.key});

  final controller = Get.put(UserlistsettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (controller.comeFrom.value == 'Normal') {
                          Get.back();
                        } else {
                          Get.offAllNamed(RouteName.homeScreenView,
                              arguments: []);
                        }
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'User List',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(
                        () => IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                              Get.toNamed(RouteName.profileDashbordSetting)!
                                  .then((value) {});
                            },
                            icon: AppCachedImage(
                                roundShape: true,
                                height: 20,
                                width: 20,
                                url: UserPreference.profileLogo.value)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'none', y: 's'),
          child: Column(
            children: [
              // App.appSpacer.vHs,
              if (Utils.decodedMap['add_user'] == true) ...[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Utils.deviceWidth(context) * 0.04,
                      0,
                      Utils.deviceWidth(context) * 0.04,
                      0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Utils.deviceWidth(context) * 0.81,
                        child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Add new user',
                            fontSize: 16.0,
                            fontColor: kAppBlack,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (controller.userLeftCount.value > 0) {
                            Get.toNamed(RouteName.userCreateSetting);
                          } else {
                            Utils.isCheck = true;
                            Utils.snackBar('Error', 'No user left');
                          }
                        },
                        child: Image.asset(
                            width: 30,
                            height: 30,
                            'assets/images/ic_add_new.png'),
                      ),
                    ],
                  ),
                ),
                App.appSpacer.vHxxs,
              ],
              Obx(
                () => ListView.builder(
                  padding: App.appSpacer.edgeInsets.all.xs,
                  itemCount: controller.userList!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    UsersList user = controller.userList![index];

                    return UserInfoCardSettingView(
                      cardWidth: App.appQuery.responsiveWidth(50),
                      cardHeight: App.appQuery.responsiveWidth(60),
                      user: user,
                    );
                  },
                ),
              ),
              _leftUserWarning,
              App.appSpacer.vHxxsl,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _leftUserWarning {
    return Obx(() {
      if (controller.userLeftCount.value > 0) {
        return Column(
          children: [
            App.appSpacer.vHs,
            CustomTextField(
                textAlign: TextAlign.center,
                text:
                    '${controller.userLeftCount.value}/${controller.totalUserCount.value} seats available',
                fontSize: 15.0,
                fontColor: kAppBlack,
                fontWeight: FontWeight.w500),
            App.appSpacer.vHs,
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
