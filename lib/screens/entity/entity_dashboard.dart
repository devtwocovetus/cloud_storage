import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/res/components/drawer/custom_app_drawer.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entity_dashbord_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class EntityDashboard extends StatelessWidget {
  EntityDashboard({super.key});

  final GlobalKey<SliderDrawerState> _entityDrawerKey =
      GlobalKey<SliderDrawerState>();
  final entityDashbordViewModel = Get.put(EntityDashbordViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
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
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Image.asset(
                          height: 15.h,
                          width: 10.h,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )),
                     Expanded(
                       child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: Utils.textCapitalizationString(entityDashbordViewModel.entityName.value),
                          fontSize: 18.0.sp,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                     ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.until((route) =>
                                Get.currentRoute == RouteName.homeScreenView);
                          },
                          icon: SVGAssetImage(
                            height: 20.h,
                            width: 20.h,
                            url: 'assets/images/default/ic_home.svg',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.toNamed(RouteName.notificationList)!.then((value) {});

                          },
                          icon: Image.asset(
                            height: 20.h,
                            width: 20.h,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(
                        () => IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                              Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                            },
                            icon: AppCachedImage(
                                roundShape: true,
                                height: 20.h,
                                width: 20.h,
                                fit: BoxFit.cover,
                                url: UserPreference.profileLogo.value)),
                      ),
                    ),
                    App.appSpacer.vWxxs
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
              childAspectRatio:
                  App.appQuery.width / (App.appQuery.height / 6),
              children: [
                if (Utils.decodedMap['material_in'] == true) ...[
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Get.toNamed(RouteName.materialInScreen, arguments: [
                        {
                          "entityName":
                              entityDashbordViewModel.entityName.value,
                          "entityId": entityDashbordViewModel.entityId.value,
                          "entityType":
                              entityDashbordViewModel.entityType.value
                        }
                      ])
                    },
                    fontWeight: FontWeight.w600,
                    text: translation.material_in,
                    fontSize: 14.sp,
                  ),
                ],
                if (Utils.decodedMap['material_out'] == true) ...[
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Get.toNamed(RouteName.materialOutScreen, arguments: [
                        {
                          "entityName":
                              entityDashbordViewModel.entityName.value,
                          "entityId": entityDashbordViewModel.entityId.value,
                          "entityType":
                              entityDashbordViewModel.entityType.value
                        }
                      ])
                    },
                    fontWeight: FontWeight.w600,
                    text: translation.material_out,
                    fontSize: 14.sp,
                  ),
                ],
                if (Utils.decodedMap['view_inventory'] == true) ...[
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      // Get.toNamed(RouteName.inventoryClientListScreen,
                      Get.toNamed(RouteName.inventoryMaterialListScreen,
                          arguments: [
                            {
                              "entityName":
                                  entityDashbordViewModel.entityName.value,
                              "entityId":
                                  entityDashbordViewModel.entityId.value,
                              "entityType":
                                  entityDashbordViewModel.entityType.value
                            }
                          ])
                    },
                    fontWeight: FontWeight.w600,
                    text: translation.view_inventory,
                    fontSize: 14.sp,
                  ),
                ],
                if (Utils.decodedMap['material_transfer'] == true) ...[
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Get.toNamed(RouteName.entityListForTransferScreen,
                          arguments: [
                            {
                              "entityName":
                              entityDashbordViewModel.entityName.value,
                              "entityId":
                              entityDashbordViewModel.entityId.value,
                              "entityType":
                              entityDashbordViewModel.entityType.value
                            }
                          ])
                    },
                    text: translation.transfer,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ],
                if (Utils.decodedMap['view_transactions'] == true) ...[
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Get.toNamed(RouteName.transactionLogList, arguments: [
                        {
                          "entityName":
                              entityDashbordViewModel.entityName.value,
                          "entityId": entityDashbordViewModel.entityId.value,
                          "entityType":
                              entityDashbordViewModel.entityType.value
                        }
                      ])
                    },
                    text: translation.view_transactions,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
