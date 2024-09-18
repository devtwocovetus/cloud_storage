import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/cards/asset_assign_info_card.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_assign.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_history_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class AssetHistoryScreen extends StatefulWidget {
  const AssetHistoryScreen({super.key});

  @override
  State<AssetHistoryScreen> createState() => _AssetHistoryScreenState();
}

class _AssetHistoryScreenState extends State<AssetHistoryScreen> {
  final assetHistoryViewModel = Get.put(AssetHistoryViewModel());
  final emailController = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: assetHistoryViewModel.assetName.value,
                          fontSize: 18.0,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
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
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Obx(()=>
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // _sliderDrawerKey.currentState!.toggle();
                        },
                        icon: AppCachedImage(
                          roundShape: true,
                          height: 20,
                          width: 20,
                          url: UserPreference.profileLogo.value)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: SizedBox(
              width: double.infinity,
              height: 37,
              child: CustomSearchField(
                margin: App.appSpacer.edgeInsets.x.none,
                searchController: TextEditingController(),
                prefixIconVisible: true,
                filled: true,
              ),
            ),
          ),
          App.appSpacer.vHs,
          _dateFilterWidget,
          App.appSpacer.vHs,
          Expanded(
            child: Obx(
              () => !assetHistoryViewModel.isLoading.value
                  ? assetHistoryViewModel.assetList!.isNotEmpty
                  ? Padding(
                      padding: App.appSpacer.edgeInsets.x.sm,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: assetHistoryViewModel.assetList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AssetAssignInfoCardView(
                              cardWidth: App.appQuery.responsiveWidth(50),
                              cardHeight: App.appQuery.responsiveWidth(45),
                              history: assetHistoryViewModel.assetList![index],
                            );
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
                              text: 'No History Found',
                              fontSize: 18.0,
                              fontColor: Color(0xFF000000),
                              fontWeight: FontWeight.w500),
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

  Widget get _dateFilterWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: App.appQuery.responsiveWidth(43),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Date from',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                App.appSpacer.vHxxs,
                CustomTextFormField(
                    readOnly: true,
                    onTab: () async {
                      await _selectFromDate(context,
                          assetHistoryViewModel.startDateController.value,
                          assetHistoryViewModel.endDateController.value);
                    },
                    suffixIcon: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                      child: Image.asset(
                        'assets/images/ic_calender.png',
                      ),
                    ),
                    height: 25,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'MM-DD-YYYY',
                    controller: assetHistoryViewModel.startDateController.value,
                    focusNode: assetHistoryViewModel.startFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.none),
              ],
            ),
          ),
          Container(
            width: App.appQuery.responsiveWidth(43),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Date To',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                App.appSpacer.vHxxs,
                CustomTextFormField(
                  readOnly: true,
                    onTab: () async {
                      await _selectToDate(context,
                          assetHistoryViewModel.startDateController.value,
                          assetHistoryViewModel.endDateController.value);
                    },
                    suffixIcon: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                      child: Image.asset(
                        'assets/images/ic_calender.png',
                      ),
                    ),
                    height: 25,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'MM-DD-YYYY',
                    controller: assetHistoryViewModel.endDateController.value,
                    focusNode: assetHistoryViewModel.endFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.none),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectFromDate(
      BuildContext context, TextEditingController startDateC, TextEditingController endDateC) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDateC.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(startDateC.text) : selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: endDateC.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(endDateC.text) :DateTime(2101));
    if (picked != null && picked != selectedDate) {
      startDateC.text = DateFormat('yyyy-MM-dd').format(picked);
      assetHistoryViewModel.getAssetHistoryFilterList();
    }
  }

  Future<void> _selectToDate(
      BuildContext context, TextEditingController startDateC, TextEditingController endDateC) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDateC.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(endDateC.text) : startDateC.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(startDateC.text) : selectedDate,
        firstDate: startDateC.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(startDateC.text) :DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      endDateC.text = DateFormat('yyyy-MM-dd').format(picked);
      assetHistoryViewModel.getAssetHistoryFilterList();
    }
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
                  onTap: () {},
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
                  onTap: () {},
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
