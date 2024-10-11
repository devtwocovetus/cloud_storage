import 'package:cold_storage_flutter/models/cold_asset/asset_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/cards/asset_assign_info_card.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_assign.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_history_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class AssetHistoryScreen extends StatefulWidget {
  const AssetHistoryScreen({super.key});

  @override
  State<AssetHistoryScreen> createState() => _AssetHistoryScreenState();
}

class _AssetHistoryScreenState extends State<AssetHistoryScreen> {
  final assetHistoryViewModel = Get.put(AssetHistoryViewModel());
  final emailController = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Container(
              height: 60.h,
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
                        if(assetHistoryViewModel.comeFrom.value == 'Normal'){
                          Get.back();
                        }else {
                          Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
                        }
                      
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
                          text: assetHistoryViewModel.assetName.value,
                          fontSize: 18.0.sp,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5.h,
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
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.notificationList)!.then((value) {});
                          },
                          icon: Image.asset(
                            height: 20.h,
                            width: 20.h,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Obx(()=>
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // _sliderDrawerKey.currentState!.toggle();
                          Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                        },
                        icon: AppCachedImage(
                          roundShape: true,
                          height: 20.h,
                          width: 20.h,
                          url: UserPreference.profileLogo.value)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Obx(() =>Column(
        children: [
          // Padding(
          //   padding: App.appSpacer.edgeInsets.x.sm,
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: 37,
          //     child: CustomSearchField(
          //       margin: App.appSpacer.edgeInsets.x.none,
          //       searchController: assetHistoryViewModel.searchController.value,
          //       prefixIconVisible: true,
          //       filled: true,
          //       onChanged: (value) async {
          //         if (value.isEmpty) {
          //           assetHistoryViewModel.searchFilter('');
          //         } else if (value.isNotEmpty) {
          //           assetHistoryViewModel.searchFilter(value);
          //         }
          //       },
          //       onSubmit: (value) async {
          //         if (value.isEmpty) {
          //           assetHistoryViewModel.searchFilter('');
          //         } else if (value.isNotEmpty) {
          //           assetHistoryViewModel.searchFilter(value);
          //         }
          //       },
          //       onCrossTapped: () {
          //         assetHistoryViewModel.searchFilter('');
          //         assetHistoryViewModel.searchController.value.clear();
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(height: 12.h,),
          _dateFilterWidget,
          SizedBox(height: 12.h,),
          Expanded(
            child:  !assetHistoryViewModel.isLoading.value
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
                          SizedBox(
                            height: 10.h,
                          ),
                           CustomTextField(
                              textAlign: TextAlign.center,
                              text: translation.no_history_found,
                              fontSize: 18.0.sp,
                              fontColor: Color(0xFF000000),
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    )
              : const SizedBox.expand(),
            ),

        ],
      ))),
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
                 CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.date_from,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                SizedBox(height: 4.h,),
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
                        height: 19.h,
                        width: 20.h,
                        'assets/images/ic_calender.png',
                      ),
                    ),
                    height: 25.h,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'YYYY-MM-DD',
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
                 CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.date_to,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                SizedBox(height: 4.h,),
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
                        height: 19.h,
                        width: 20.h,
                        'assets/images/ic_calender.png',
                      ),
                    ),
                    height: 25.h,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'YYYY-MM-DD',
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
        locale: Locale(i18n.LocaleSettings.currentLocale.languageCode),
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
        locale: Locale(i18n.LocaleSettings.currentLocale.languageCode),
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
                              color: const Color(0xFF1F9254), width: 1),
                          color: const Color(0xFFEBF9F1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child:  Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: translation.available,
                            fontSize: 12.0.sp,
                            fontColor: Color(0xFF1F9254),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: 85.h,
                      height: 24.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF921F1F), width: 1),
                          color: const Color(0xFFF9EBEB),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child:  Align(
                        alignment: Alignment.center,
                        child: CustomTextField(
                            textAlign: TextAlign.center,
                            text: translation.occupied,
                            fontSize: 12.0.sp,
                            fontColor: Color(0xFF921F1F),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                  SizedBox(
                    width: 8.h,
                  ),
                  Image.asset(
                    height: 25.h,
                    width: 25.h,
                    'assets/images/ic_edit_circule.png',
                    fit: BoxFit.cover,
                  ),
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
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.42,
                child:  CustomTextField(
                  textAlign: TextAlign.left,
                  text: translation.current_location,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              if (assetList.assignToUserName.toString() != 'null') ...[
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.42,
                  child:  CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.assigned_to,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                ),
              ]
            ],
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.42,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      assetList.currentLocationOrEntityName.toString()),
                  fontSize: 16.sp,
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff000000),
                  ),
                ),
              ]
            ],
          ),
          SizedBox(height: 2.h,),
          CustomTextField(
              textAlign: TextAlign.left,
              text:
                  '.................................................................................................................................................................................................................................................',
              fontSize: 13.0.sp,
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
              Expanded(
                child: GestureDetector(
                  onTap: () {},
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
                  onTap: () {},
                  child:  CustomTextField(
                    textAlign: TextAlign.center,
                    text: translation.history,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff005AFF),
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
