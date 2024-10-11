import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/cards/base_card_view.dart';
import 'package:cold_storage_flutter/res/components/divider/basic_divider.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entityonboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../res/variables/var_string.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/services/app_services.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class EntityOnboarding extends StatelessWidget {
   EntityOnboarding({super.key});

  final entityOnboardingViewModel = Get.put(EntityOnboardingViewModel());
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
                        text: translation.add_entity,
                        fontSize: 18.0.sp,
                        fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(()=>
                      IconButton(
                        onPressed: () {
                          Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});

                          // _sliderDrawerKey.currentState!.toggle();
                        },
                        icon: AppCachedImage(
                          roundShape: true,
                          height: 20.h,
                          width: 20.h,
                          url: UserPreference.profileLogo.value
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Padding(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'sm', y: 'smm'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BaseCardView(
                cardHeight: App.appQuery.responsiveWidth(55),
                cardWidth: App.appQuery.responsiveWidth(85),
                backgroundColor: kCardBackground,
                image: wareHouseImage2,
                heading: translation.cold_storage_warehouse,
                subHeading: translation.unlock_message,
                sub2Heading: translation.adipiscing_elit,
                onTap: () {
                  Get.toNamed(RouteName.createWarehouse,arguments: [
                    {"EOB": entityOnboardingViewModel.inComingStatus.value}
                  ]);
                },
              ),
              BasicDivider(width: App.appQuery.responsiveWidth(75)),
              BaseCardView(
                cardHeight: App.appQuery.responsiveWidth(55),
                cardWidth: App.appQuery.responsiveWidth(85),
                backgroundColor: kCardBackground,
                image: wareHouseImage2,
                heading: 'Farm | Grower',
                subHeading: translation.unlock_message,
                sub2Heading: translation.adipiscing_elit,
                onTap: () {
                  Get.toNamed(RouteName.createFarmhouse,arguments: [
                    {"EOB": entityOnboardingViewModel.inComingStatus.value}
                  ]);
                },
              ),
              // MyCustomButton(
              //   backgroundColor: entityOnboardingViewModel.btnStatus.value
              //             ? const Color(0xFF005AFF)
              //             : const Color(0xFF005AFF).withOpacity(0.2),
              //   width: App.appQuery.responsiveWidth(85) /*312.0*/,
              //   height: 48.0,
              //   borderRadius: BorderRadius.circular(10.0),
              //   onPressed: () => {
              //     // Get.toNamed(RouteName.createWarehouse),
              //   },
              //   text: 'Continue',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
