import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/entity_transfer/entity_list_for_transfer_view_model.dart';
import '../../view_models/services/app_services.dart';
import '../client/widget/dashed_line_vertical_painter.dart';

class EntityListForTransfer extends StatelessWidget {
  EntityListForTransfer({super.key});

  final controller = Get.put(EntityListForTransferViewModel());

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
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Entity List',
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
                          onPressed: () {
                            Get.toNamed(RouteName.notificationList)!.then((value) {});

                          },
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
                              Get.toNamed(RouteName.profileDashbordSetting)!
                                  .then((value) {});
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
      body: Obx(() =>Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          App.appSpacer.vHxxs,
          CustomSearchField(
            searchHint: 'Search here...',
            prefixIconVisible: true,
            filled: true,
            margin: App.appSpacer.edgeInsets.x.s,
            searchController: controller.searchController.value,
            onChanged: (value) async {
              if (value.isEmpty) {
                controller.searchFilter('');
              } else if (value.isNotEmpty) {
                controller.searchFilter(value);
              }
            },
            onSubmit: (value) async {
              if (value.isEmpty) {
                controller.searchFilter('');
              } else if (value.isNotEmpty) {
                controller.searchFilter(value);
              }
            },
            onCrossTapped: () {
              controller.searchFilter('');
              controller.searchController.value.clear();
            },
          ),
          App.appSpacer.vHxxs,
          Expanded(
              child: !controller.isLoading.value
                ? controller.entityList!.isNotEmpty
                    ? ListView.builder(
                        padding: App.appSpacer.edgeInsets.all.xs,
                        shrinkWrap: true,
                        itemCount: controller.entityList?.length,
                        itemBuilder: (context, index) {
                          return controller.entityId.value.toString() !=
                                  controller.entityList![index].id.toString()
                              ? entityTileView(
                                  index, context, controller.entityList![index])
                              : const SizedBox.shrink();
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Image.asset(
                                      'assets/images/ic_blank_list.png'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const CustomTextField(
                                      textAlign: TextAlign.center,
                                      text: 'No Entity Found',
                                      fontSize: 18.0,
                                      fontColor: Color(0xFF000000),
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                : const SizedBox.expand(),
          ),
        ],
      )),
    );
  }

  Widget entityTileView(int index, BuildContext context, Entity entity) {
    return Container(
      margin: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
          Utils.deviceWidth(context) * 0.03, Utils.deviceWidth(context) * 0.03),
      padding: EdgeInsets.fromLTRB(
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
        border: Border.all(
          color: kBorder,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: kAppWhite,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text:
                        Utils.textCapitalizationString(entity.name.toString()),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A)),
              ),
              // entity.entityType == 1
              entity.entityType == 1
                  ? Container(
                      width: 95,
                      height: 28,
                      decoration: const BoxDecoration(
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFF1F9254), width: 1),
                            top: BorderSide(color: Color(0xFF1F9254), width: 1),
                            bottom:
                                BorderSide(color: Color(0xFF1F9254), width: 1),
                            right:
                                BorderSide(color: Color(0xFF1F9254), width: 1),
                          ),
                          color: Color(0xFFEBF9F1),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: 'Cold Storage',
                            fontSize: 12.0,
                            fontColor: Color(0xFF1F9254),
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      width: 95,
                      height: 28,
                      decoration: const BoxDecoration(
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFF1F3f92), width: 1),
                            top: BorderSide(color: Color(0xFF1F3f92), width: 1),
                            bottom:
                                BorderSide(color: Color(0xFF1F3f92), width: 1),
                            right:
                                BorderSide(color: Color(0xFF1F3f92), width: 1),
                          ),
                          color: Color(0xFFD7E9FF),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: 'Farmhouse',
                            fontSize: 12.0,
                            fontColor: Color(0xFF1F3f92),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Divider(
            color: kAppGreyC,
          ),
          App.appSpacer.vHxxxs,
          const Row(
            children: [
              Expanded(
                flex: 7,
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Location',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    fontColor: kAppGreyB),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              Expanded(
                flex: 7,
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString('${entity.address}'),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    fontColor: kAppBlack),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const CustomTextField(
              textAlign: TextAlign.left,
              text:
                  '.................................................................................................................................................................................................................................................',
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              fontColor: Color(0xffD4D4D4)),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (entity.hasMaterialInternalTransferRequest!) {
                      Get.toNamed(
                          RouteName.entityToEntityTransferNotificationList,
                          arguments: [
                            {
                              "entityId": controller.entityId.value.toString(),
                              "entityType": controller.entityType.value.toString(),
                            }
                          ]);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: 'Request',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          fontColor: getColorRequest(entity)
                          // fontColor: kAppBlack
                          ),
                      if (entity.hasMaterialInternalTransferRequest!) ...[
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          height: 22,
                          width: 22,
                          'assets/images/ic_is_request.png',
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              CustomPaint(
                  size: const Size(1, 40),
                  painter: DashedLineVerticalPainter()),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteName.entityToEntityTransferScreen,
                        arguments: [
                          {
                            "toEntityName": entity.name.toString(),
                            "toEntityId": entity.id.toString(),
                            "toEntityType": entity.entityType.toString(),
                            "entityName": controller.entityName.toString(),
                            "entityId": controller.entityId.toString(),
                            "entityType": controller.entityType.toString(),
                            "from": 'Normal',
                          }
                        ]);
                  },
                  child: const CustomTextField(
                      textAlign: TextAlign.center,
                      text: 'Transfer',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      fontColor: kAppPrimary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color getColorRequest(Entity entity) {
    Color color = const Color(0xffe3e3e3);
    if (entity.hasMaterialInternalTransferRequest == true) {
      color = const Color(0xff005AFF);
    } else {
      color = const Color(0xffe3e3e3);
    }
    return color;
  }
}
