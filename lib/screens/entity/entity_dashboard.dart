import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/res/components/drawer/custom_app_drawer.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entity_dashbord_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class EntityDashboard extends StatelessWidget {
  EntityDashboard({super.key});

  final GlobalKey<SliderDrawerState> _entityDrawerKey =
      GlobalKey<SliderDrawerState>();
  final entityDashbordViewModel = Get.put(EntityDashbordViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
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
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Image.asset(
                          height: 15,
                          width: 10,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )),
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: Utils.textCapitalizationString(entityDashbordViewModel.entityName.value),
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.until((route) =>
                                Get.currentRoute == RouteName.homeScreenView);
                          },
                          icon: const SVGAssetImage(
                            height: 20,
                            width: 20,
                            url: 'assets/images/default/ic_home.svg',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Image.asset(
                            height: 20,
                            width: 20,
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
                                height: 20,
                                width: 20,
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
              crossAxisSpacing: App.appSpacer.lg,
              mainAxisSpacing: App.appSpacer.spacer_28,
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
                    text: 'Material In',
                    fontSize: 14,
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
                    text: 'Material Out',
                    fontSize: 14,
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
                    text: 'View Inventory',
                    fontSize: 14,
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
                    text: 'Transfer',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
                    text: 'Transaction Log',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
