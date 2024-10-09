import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/view_models/setting/setting_dashbord_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class SettingDashboard extends StatelessWidget {
  SettingDashboard({super.key});

  final GlobalKey<SliderDrawerState> _entityDrawerKey =
      GlobalKey<SliderDrawerState>();
  final settingDashbordViewModel = Get.put(SettingDashbordViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
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
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15.h,
                        width: 10.h,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.setting,
                          fontSize: 18.0.sp,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!
                                .then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20.h,
                              width: 20.h,
                              url: UserPreference.profileLogo.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: App.appSpacer.edgeInsets.x.sm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GridView.count(
              padding: App.appSpacer.edgeInsets.y.sm,
              shrinkWrap: true,
              primary: false,
              crossAxisCount: 2,
              crossAxisSpacing: 35.h,
              mainAxisSpacing: 28.h,
              physics: const AlwaysScrollableScrollPhysics(),
              childAspectRatio: App.appQuery.width / (App.appQuery.height / 6),
              children: [
                if (Utils.decodedMap['view_user'] == true) ...[
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Get.toNamed(RouteName.userListSetting, arguments: [
                        {
                          "from": 'Normal',
                        }
                      ])!
                          .then((value) {})
                    },
                    fontWeight: FontWeight.w600,
                    text: translation.user_management,
                    fontSize: 14.sp,
                  ),
                ],
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () =>
                      {Get.toNamed(RouteName.entityListSettingScreen)},
                  fontWeight: FontWeight.w600,
                  text: translation.entity_settings,
                  fontSize: 14.sp,
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {Get.toNamed(RouteName.accountUpdate)},
                  fontWeight: FontWeight.w600,
                  text: translation.account_setting,
                  fontSize: 14.sp,
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {Get.toNamed(RouteName.settingSubscription)},
                  fontWeight: FontWeight.w600,
                  text: translation.subscription,
                  fontSize: 14.sp,
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () =>
                      {Get.toNamed(RouteName.entityListReportScreen)},
                  fontWeight: FontWeight.w600,
                  text: translation.reports,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
