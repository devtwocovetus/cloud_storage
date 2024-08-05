import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_assign.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/material/materiallist_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/routes/routes_name.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State<AssetListScreen> createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
  final assetListViewModel = Get.put(AssetListViewModel());
  final emailController = TextEditingController();

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
          preferredSize: const Size.fromHeight(80),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => {Get.back()},
                      child: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_sidemenu_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Asset',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.until((route) =>
                            Get.currentRoute == RouteName.homeScreenView);
                      },
                      child: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_home_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                      width: 30, height: 30, 'assets/images/ic_add_new.png'),
                ),
              ],
            ),
          ),
          App.appSpacer.vHs,
          Obx(
            () => Expanded(
              child: assetListViewModel.assetList!.isNotEmpty
                  ? Padding(
                      padding: App.appSpacer.edgeInsets.x.sm,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: assetListViewModel.assetList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return assetViewTile(
                                assetListViewModel.assetList![index]);
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/ic_blank_list.png'),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomTextField(
                              textAlign: TextAlign.center,
                              text: 'No Asset Found',
                              fontSize: 18.0,
                              fontColor: Color(0xFF000000),
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
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
                  const SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    height: 25,
                    width: 25,
                    'assets/images/ic_edit_circule.png',
                    fit: BoxFit.cover,
                  ),
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
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.42,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Current Location',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              if (assetList.assignToUserName.toString() != 'null') ...[
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.42,
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Assigned To',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                ),
              ]
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.42,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      assetList.currentLocationOrEntityName.toString()),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff000000),
                ),
              ),
              if (assetList.assignToUserName.toString() != 'null') ...[
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.42,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        assetList.assignToUserName.toString()),
                    fontSize: 16,
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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (assetList.assetAvailableStatus == 'available') {
                    } else {
                      assetListViewModel.deleteAssign(assetList.assignmentId.toString());
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
