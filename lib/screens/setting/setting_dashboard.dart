import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/res/components/drawer/custom_app_drawer.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entity_dashbord_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/view_models/setting/setting_dashbord_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';


class SettingDashboard extends StatelessWidget {
  SettingDashboard({super.key});

  final GlobalKey<SliderDrawerState> _entityDrawerKey =
      GlobalKey<SliderDrawerState>();
  final settingDashbordViewModel = Get.put(SettingDashbordViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
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
                        height: 20,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Setting',
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 25,
                              width: 25,
                              url: settingDashbordViewModel.logoUrl.value)),
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
              crossAxisSpacing: App.appSpacer.lg,
              mainAxisSpacing: App.appSpacer.spacer_28,
              physics: const AlwaysScrollableScrollPhysics(),
              childAspectRatio:
                  App.appQuery.width / (App.appQuery.height / 6),
              children: [
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                     Get.toNamed(RouteName.userListSetting)
                  },
                  fontWeight: FontWeight.w600,
                  text: 'User Management',
                  fontSize: 13,
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                    // Get.toNamed(RouteName.materialOutScreen, arguments: [
                    //   {
                    //     "entityName":
                    //         entityDashbordViewModel.entityName.value,
                    //     "entityId": entityDashbordViewModel.entityId.value,
                    //     "entityType": entityDashbordViewModel.entityType.value
                    //   }
                    // ])
                  },
                  fontWeight: FontWeight.w600,
                  text: 'Entity Settings',
                  fontSize: 13,
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {},
                  fontWeight: FontWeight.w600,
                  text: 'Account Setting',
                  fontSize: 13,
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {},
                  fontWeight: FontWeight.w600,
                  text: 'Localization',
                  fontSize: 13,
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                    // Get.toNamed(RouteName.inventoryClientListScreen,
                    //     arguments: [
                    //       {
                    //         "entityName":
                    //             entityDashbordViewModel.entityName.value,
                    //         "entityId":
                    //             entityDashbordViewModel.entityId.value,
                    //         "entityType":
                    //             entityDashbordViewModel.entityType.value
                    //       }
                    //     ])
                  },
                  fontWeight: FontWeight.w600,
                  text: 'Billing and Subscription',
                  fontSize: 13,
                  
                ),
                MyCustomButton(
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {},
                  fontWeight: FontWeight.w600,
                  text: 'Reporting and Analytics',
                  fontSize: 13,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
