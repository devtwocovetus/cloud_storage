import 'dart:io';

import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/res/components/cards/user_info_card.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user/userlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/services/app_services.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class UserList extends StatelessWidget {
  UserList({super.key});

  final UserlistViewModel controller = Get.put(UserlistViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButton: bottomGestureButtons,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Container(
              height: 60.h,
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
                        exit(0);
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15.h,
                        width: 10.h,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.user_list,
                        fontSize: 18.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(()=> IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20.h,
                              width: 20.h,
                              url: UserPreference.profileLogo.value
                          )
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'none', y: 'smm'),
          child: Column(
            children: [
              SizedBox(height: 12.h,),
              Obx(
                () => ListView.builder(
                  padding: App.appSpacer.edgeInsets.all.xs,
                  itemCount: controller.userList!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    UsersList user = controller.userList![index];

                    return UserInfoCardView(
                      cardWidth: App.appQuery.responsiveWidth(50),
                      cardHeight: App.appQuery.responsiveWidth(60),
                      user: user,
                      screenCode: 1,
                    );
                  },
                ),
              ),
              _leftUserWarning,
              SizedBox(height: 60.h,),
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
            SizedBox(height: 12.h,),
            CustomTextField(
                textAlign: TextAlign.center,
                text:
                    '${controller.userLeftCount.value}/${controller.totalUserCount.value} ${translation.seats_available}',
                fontSize: 15.0.sp,
                fontColor: kAppBlack,
                fontWeight: FontWeight.w500),
            SizedBox(height: 12.h,),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget get bottomGestureButtons {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45.h,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            if (controller.userLeftCount.value > 0)
              Get.toNamed(RouteName.createUserView)
            else
              {Utils.isCheck = true, Utils.snackBar(translation.error, translation.noUser_left)}
          },
          text: translation.add_user,
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45.h,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Get.offNamed(RouteName.newEntityListScreen, arguments: [
              {"EOB": 'NEW'}
            ])!
                .then((value) {})
          },
          text: translation.continue_text,
        )
      ],
    );
  }
}
