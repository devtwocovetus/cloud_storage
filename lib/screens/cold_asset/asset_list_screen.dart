import 'dart:convert';

import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_assign.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/drawer/custom_app_drawer.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State<AssetListScreen> createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
  final assetListViewModel = Get.put(AssetListViewModel());
  final emailController = TextEditingController();
  final _assetDrawerKey = GlobalKey<SliderDrawerState>();

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    double fullWidth = Utils.deviceWidth(context) * 0.9;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SliderDrawer(
        key: _assetDrawerKey,
        appBar: SliderAppBar(
          appBarHeight: 90,
          appBarPadding: App.appSpacer.edgeInsets.top.md,
          appBarColor: Colors.white,
          drawerIcon: Padding(
            padding: App.appSpacer.edgeInsets.top.sm,
            child: IconButton(
                onPressed: () {
                  _assetDrawerKey.currentState!.toggle();
                },
                icon: Image.asset(
                  height: 20,
                  width: 20,
                  'assets/images/ic_sidemenu_icon.png',
                  fit: BoxFit.cover,
                )),
          ),
          isTitleCenter: false,
          title: Padding(
            padding: App.appSpacer.edgeInsets.top.sm,
            child: const CustomTextField(
                textAlign: TextAlign.left,
                text: 'Asset',
                fontSize: 18.0,
                fontColor: Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
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
                padding: App.appSpacer.edgeInsets.top.sm,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
                child: Obx(
                  () => IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // _sliderDrawerKey.currentState!.toggle();
                      },
                      icon: AppCachedImage(
                          roundShape: true,
                          height: 20,
                          width: 20,
                          url: UserPreference.profileLogo.value)),
                ),
              ),
              App.appSpacer.vWxxs
            ],
          ),
        ),
        slider: const CustomAppDrawer(
          screenCode: 2,
        ),
        child: SafeArea(
            top: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Utils.decodedMap['add_asset'] == true) ...[
                  App.appSpacer.vHxs,
                  Padding(
                    padding: App.appSpacer.edgeInsets.x.sm,
                    child: Row(
                      children: [
                        const CustomTextField(
                          text: 'Create New Asset',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff000000),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteName.createAssetScreen);
                          },
                          child: Image.asset(
                              width: 30,
                              height: 30,
                              'assets/images/ic_add_new.png'),
                        ),
                      ],
                    ),
                  ),
                ],
                App.appSpacer.vHs,
                Obx(
                  () => Expanded(
                    child: !assetListViewModel.isLoading.value
                        ? assetListViewModel.assetList!.isNotEmpty
                            ? Padding(
                                padding: App.appSpacer.edgeInsets.x.sm,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        assetListViewModel.assetList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return assetViewTile(
                                          assetListViewModel.assetList![index]);
                                    }),
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
                                              text: 'No Asset Found',
                                              fontSize: 18.0,
                                              fontColor: Color(0xFF000000),
                                              fontWeight: FontWeight.w500
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: MyCustomButton(
                                        height:
                                        Utils.deviceHeight(context) * 0.06,
                                        padding:
                                        Utils.deviceWidth(context) * 0.10,
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        onPressed: () => {
                                          Get.toNamed(
                                              RouteName.createAssetScreen)
                                        },
                                        text: 'Create Asset',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        : const SizedBox.expand(),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget assetViewTile(AssetList assetList) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, Utils.deviceWidth(context) * 0.03),
      padding: EdgeInsets.fromLTRB(
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          0),
      decoration: BoxDecoration(
        border: Border.all(
          color: kBorder,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: kAppWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        assetList.assetName.toString()),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A)),
              ),
              Row(
                children: [
                  if (assetList.assetAvailableStatus == 'available') ...[
                    Container(
                      width: 85,
                      height: 24,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF1F9254), width: 1),
                          color: const Color(0xFFEBF9F1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: 'Available',
                            fontSize: 12.0,
                            fontColor: Color(0xFF1F9254),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: 85,
                      height: 24,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF921F1F), width: 1),
                          color: const Color(0xFFF9EBEB),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: 'Occupied',
                            fontSize: 12.0,
                            fontColor: Color(0xFF921F1F),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                  if (Utils.decodedMap['edit_asset'] == true) ...[
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.updateAssetScreen,arguments: {
                          'asset_id': assetList.id.toString()
                        });
                      },
                      child: Image.asset(
                        height: 25,
                        width: 25,
                        'assets/images/ic_edit_circule.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Divider(
            color: kAppGreyC,
          ),
          App.appSpacer.vHxxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.42,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Current Location',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              if (assetList.assignToUserName.toString() != 'null') ...[
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.42,
                  child: const CustomTextField(
                    textAlign: TextAlign.right,
                    text: 'Assigned To',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                ),
              ]
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.42,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      assetList.currentLocationOrEntityName.toString()),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff000000),
                ),
              ),
              if (assetList.assignToUserName.toString() != 'null') ...[
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.42,
                  child: CustomTextField(
                    textAlign: TextAlign.right,
                    text: Utils.textCapitalizationString(
                        assetList.assignToUserName.toString()),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff000000),
                  ),
                ),
              ]
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
              if (Utils.decodedMap['do_asset_assignment'] == true) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.dialog(
                        AssetAssign(
                          assetId: assetList.id.toString(),
                          locationId:
                              assetList.currentLocationOrEntity.toString(),
                          locationType:
                              assetList.currentLocationOrEntityType.toString(),
                          locationName:
                              assetList.currentLocationOrEntityName.toString(),
                        ),
                      );
                    },
                    child: CustomTextField(
                      textAlign: TextAlign.center,
                      text: assetList.assetAvailableStatus == 'available'
                          ? 'Assign'
                          : 'Assign New',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff005AFF),
                    ),
                  ),
                ),
                CustomPaint(
                    size: const Size(1, 40),
                    painter: DashedLineVerticalPainter()),
              ],
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (assetList.assetAvailableStatus == 'available') {
                    } else {
                      assetListViewModel
                          .deleteAssign(assetList.assignmentId.toString());
                    }
                  },
                  child: CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Release',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor: assetList.assetAvailableStatus == 'available'
                        ? const Color(0xffB3CEFF)
                        : const Color(0xff005AFF),
                  ),
                ),
              ),
              CustomPaint(
                  size: const Size(1, 40),
                  painter: DashedLineVerticalPainter()),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteName.assetHistoryListScreen, arguments: [
                      {
                        "assetName": Utils.textCapitalizationString(
                            assetList.assetName.toString()),
                        "assetId": assetList.id.toString()
                      }
                    ])!
                        .then((value) {});
                  },
                  child: const CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'History',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff005AFF),
                  ),
                ),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
        ],
      ),
    );
  }
}
