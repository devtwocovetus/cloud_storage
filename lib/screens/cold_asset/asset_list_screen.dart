import 'dart:convert';

import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/search_field/custom_search_field.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_assign.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State<AssetListScreen> createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
  final assetListViewModel = Get.put(AssetListViewModel());
  final emailController = TextEditingController();
  final _assetDrawerKey = GlobalKey<SliderDrawerState>();
  late i18n.Translations translation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

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
                          if (assetListViewModel.comeFrom.value == 'Normal') {
                            Get.back();
                          } else {
                            Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
                          }
                        },
                        icon: Image.asset(
                          height: 15.h,
                          width: 10.h,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )),
                    CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.asset,
                        fontSize: 18.0.sp,
                        fontColor: const Color(0xFF000000),
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
                            Get.toNamed(RouteName.notificationList)!
                                .then((value) {});
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
                              Get.toNamed(RouteName.profileDashbordSetting)!
                                  .then((value) {});
                            },
                            icon: AppCachedImage(
                                roundShape: true,
                                height: 20.h,
                                width: 20.h,
                                fit: BoxFit.cover,
                                url: UserPreference.profileLogo.value)),
                      ),
                    ),
                    SizedBox(width: 4.h,)
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
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
                      Expanded(
                        child: CustomSearchField(
                        margin: App.appSpacer.edgeInsets.x.none,
                          searchController: assetListViewModel.searchController.value,
                          prefixIconVisible: true,
                          filled: true,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              assetListViewModel.searchFilter('');
                            } else if (value.isNotEmpty) {
                              assetListViewModel.searchFilter(value);
                            }
                          },
                          onSubmit: (value) async {
                            if (value.isEmpty) {
                              assetListViewModel.searchFilter('');
                            } else if (value.isNotEmpty) {
                              assetListViewModel.searchFilter(value);
                            }
                          },
                          onCrossTapped: () {
                            assetListViewModel.searchFilter('');
                            assetListViewModel.searchController.value.clear();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15.h,
                      ),
                      if (Utils.decodedMap['add_asset'] == true) ...[
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteName.createAssetScreen);
                          },
                          child: Image.asset(
                              width: 30.h,
                              height: 30.h,
                              'assets/images/ic_add_new.png'),
                        ),
                      ],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/ic_blank_list.png'),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextField(
                                            textAlign: TextAlign.center,
                                            text: translation.no_asset_found,
                                            fontSize: 18.0.sp,
                                            fontColor: const Color(0xFF000000),
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  if (Utils.decodedMap['add_asset'] == true) ...[
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: MyCustomButton(
                                        height:
                                        Utils.deviceHeight(context) * 0.06,
                                        padding:
                                        Utils.deviceWidth(context) * 0.10,
                                        borderRadius: BorderRadius.circular(10.0),
                                        onPressed: () => {
                                          Get.toNamed(RouteName.createAssetScreen)
                                        },
                                        text: translation.create_asset,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            )
                      : const SizedBox.expand(),
                ),
              )
            ],
          )),
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
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A)),
              ),
              Row(
                children: [
                  if (assetList.assetAvailableStatus == 'available') ...[
                    Container(
                      width: 85.h,
                      height: 24.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF1F9254), width: 1.h),
                          color: const Color(0xFFEBF9F1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: translation.available,
                            fontSize: 12.0.sp,
                            fontColor: const Color(0xFF1F9254),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: 85.h,
                      height: 24.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF921F1F), width: 1.h),
                          color: const Color(0xFFF9EBEB),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: translation.occupied,
                            fontSize: 12.0.sp,
                            fontColor: const Color(0xFF921F1F),
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
                        Get.toNamed(RouteName.updateAssetScreen,
                            arguments: {'asset_id': assetList.id.toString()});
                      },
                      child: Image.asset(
                        height: 25.h,
                        width: 25.h,
                        'assets/images/ic_edit_circule.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h,),
          const Divider(
            color: kAppGreyC,
          ),
          SizedBox(height: 2.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.42,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: translation.current_location,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff808080),
                ),
              ),
              if (assetList.assignToUserName.toString() != 'null') ...[
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.42,
                  child: CustomTextField(
                    textAlign: TextAlign.right,
                    text: translation.assigned_to,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff808080),
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
                  fontSize: 13.sp,
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
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff000000),
                  ),
                ),
              ]
            ],
          ),
          App.appSpacer.vHxxxs,
          CustomTextField(
              textAlign: TextAlign.left,
              text:
                  '.................................................................................................................................................................................................................................................',
              fontSize: 13.0.sp,
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
                            locationType: assetList.currentLocationOrEntityType
                                .toString(),
                            locationName: assetList.currentLocationOrEntityName
                                .toString(),
                          ),
                          arguments: [
                            {
                              'assetId': assetList.id.toString(),
                              'locationId':
                                  assetList.currentLocationOrEntity.toString(),
                              'locationType': assetList
                                  .currentLocationOrEntityType
                                  .toString(),
                              'locationName': assetList
                                  .currentLocationOrEntityName
                                  .toString(),
                            }
                          ]);
                    },
                    child: CustomTextField(
                      textAlign: TextAlign.center,
                      text: assetList.assetAvailableStatus == 'available'
                          ? translation.assign
                          : translation.assign_new,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff005AFF),
                    ),
                  ),
                ),
                CustomPaint(
                    size: Size(1.h, 40.h),
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
                    text: translation.release,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: assetList.assetAvailableStatus == 'available'
                        ? const Color(0xffB3CEFF)
                        : const Color(0xff005AFF),
                  ),
                ),
              ),
              CustomPaint(
                  size: Size(1.h, 40.h),
                  painter: DashedLineVerticalPainter()),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteName.assetHistoryListScreen, arguments: [
                      {
                        "assetName": Utils.textCapitalizationString(
                            assetList.assetName.toString()),
                        "assetId": assetList.id.toString(),
                        "from": 'Normal',
                      }
                    ])!
                        .then((value) {});
                  },
                  child: CustomTextField(
                    textAlign: TextAlign.center,
                    text: translation.history,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff005AFF),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h,),
        ],
      ),
    );
  }
}
