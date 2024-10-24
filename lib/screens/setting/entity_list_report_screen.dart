import 'package:cold_storage_flutter/models/entity/entity_reporting_list_model.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/view_models/setting/entitylist_report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class EntityListReportScreen extends StatefulWidget {
  const EntityListReportScreen({super.key});

  @override
  State<EntityListReportScreen> createState() =>
      _EntityListReportScreenState();
}

class _EntityListReportScreenState extends State<EntityListReportScreen> {
  final entityListViewModel = Get.put(EntitylistReportViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButton: bottomGestureButtons,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
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
                          text: translation.reports_occurrences,
                          fontSize: 18.0.sp,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
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
                                  url: UserPreference.profileLogo.value)),
                        )),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 65),
                    decoration: const BoxDecoration(
                        color: kAppWhite,
                        // border: Border.all(
                        //   color: const Color(0xFFE6E6E6),
                        // ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: kAppBlack.withOpacity(0.15),
                        //     spreadRadius: 0,
                        //     blurRadius: 20, // Increased blur radius
                        //     offset: const Offset(0, 4),
                        //   )
                        // ],
                        borderRadius:
                        BorderRadius.all(Radius.circular(11))),
                    child: !entityListViewModel.isLoading.value ? entityListViewModel.entityList!.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: entityListViewModel.entityList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return listItem(
                                  entityListViewModel.entityList![index],
                                  index);
                            })
                        : SizedBox(
                            width: 1800.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    'assets/images/ic_blank_list.png'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: translation.no_report_found,
                                    fontSize: 18.0.sp,
                                    fontColor: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // MyCustomButton(
                                //   elevation: 20,
                                //   height:
                                //       Utils.deviceHeight(context) * 0.06,
                                //   padding:
                                //       Utils.deviceWidth(context) * 0.10,
                                //   borderRadius: BorderRadius.circular(10.0),
                                //   onPressed: () => {
                                //     Get.toNamed(RouteName.entityOnboarding,
                                //             arguments: [
                                //           {"EOB": 'OLD'}
                                //         ])!
                                //         .then((value) {})
                                //   },
                                //   text: 'Create Entity',
                                // ),
                              ],
                            ),
                          ) : const SizedBox.expand(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(EntityReport entity, int index) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(RouteName.entityDashboard, arguments: [
        //   {
        //     "entityName": entity.name,
        //     "entityId": entity.id.toString(),
        //     "entityType": entity.entityType.toString()
        //   }
        // ]);
      },
      child: Obx(() => Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFE4E4EF)),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: AppCachedImage(
                            roundShape: true,
                            height: 45.h,
                            width: 45.h,
                            fit: BoxFit.cover,
                            url: entity.profileImage,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                    textAlign: TextAlign.left,
                                    line: 2,
                                    text: Utils.textCapitalizationString(
                                        entity.name.toString()),
                                    fontSize: 14.0.sp,
                                    fontColor: const Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            entity.entityType == 1
                                ? Container(
                                    width: 120.h,
                                    height: 28.h,
                                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              color: Color(0xFF1F9254),
                                              width: 1),
                                          top: BorderSide(
                                              color: Color(0xFF1F9254),
                                              width: 1),
                                          bottom: BorderSide(
                                              color: Color(0xFF1F9254),
                                              width: 1),
                                          right: BorderSide(
                                              color: Color(0xFF1F9254),
                                              width: 1),
                                        ),
                                        color: Color(0xFFEBF9F1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11))),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          text: translation.cold_storage,
                                          fontSize: 12.0.sp,
                                          fontColor: const Color(0xFF1F9254),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : Container(
                                    width: 120.h,
                                    height: 28.h,
                                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              color: Color(0xFF1F3f92),
                                              width: 1),
                                          top: BorderSide(
                                              color: Color(0xFF1F3f92),
                                              width: 1),
                                          bottom: BorderSide(
                                              color: Color(0xFF1F3f92),
                                              width: 1),
                                          right: BorderSide(
                                              color: Color(0xFF1F3f92),
                                              width: 1),
                                        ),
                                        color: Color(0xFFD7E9FF),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(11))),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          text: translation.farmhouse,
                                          fontSize: 12.0.sp,
                                          fontColor: const Color(0xFF1F3f92),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.03, 0, 0, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Utils.deviceWidth(context) * 0.28,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (entityListViewModel.listDaily![index] ==
                                        1) {
                                      entityListViewModel.listDaily![index] = 0;
                                    } else {
                                      entityListViewModel.listDaily![index] = 1;
                                    }
                                  },
                                  child:
                                      entityListViewModel.listDaily![index] == 1
                                          ? Image.asset(
                                              'assets/images/ic_setting_check_on.png',
                                              width: 20.h,
                                              height: 20.h,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/ic_setting_check_off.png',
                                              width: 20.h,
                                              height: 20.h,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      textAlign: TextAlign.left,
                                      text: translation.daily,
                                      fontSize: 13.0.sp,
                                      fontWeight: FontWeight.w400,
                                      fontColor: Color(0xff1A1A1A)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Utils.deviceWidth(context) * 0.28,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (entityListViewModel.listWeekly![index] ==
                                        1) {
                                      entityListViewModel.listWeekly![index] = 0;
                                    } else {
                                      entityListViewModel.listWeekly![index] = 1;
                                    }
                                  },
                                  child:
                                      entityListViewModel.listWeekly![index] == 1
                                          ? Image.asset(
                                              'assets/images/ic_setting_check_on.png',
                                              width: 20.h,
                                              height: 20.h,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/ic_setting_check_off.png',
                                              width: 20.h,
                                              height: 20.h,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      textAlign: TextAlign.left,
                                      text: translation.weekly,
                                      fontSize: 13.0.sp,
                                      fontWeight: FontWeight.w400,
                                      fontColor: const Color(0xff1A1A1A)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Utils.deviceWidth(context) * 0.28,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (entityListViewModel.listMonthly![index] ==
                                        1) {
                                      entityListViewModel.listMonthly![index] = 0;
                                    } else {
                                      entityListViewModel.listMonthly![index] = 1;
                                    }
                                  },
                                  child:
                                      entityListViewModel.listMonthly![index] == 1
                                          ? Image.asset(
                                              'assets/images/ic_setting_check_on.png',
                                              width: 20.h,
                                              height: 20.h,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/ic_setting_check_off.png',
                                              width: 20.h,
                                              height: 20.h,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      textAlign: TextAlign.left,
                                      text: translation.monthly,
                                      fontSize: 13.0.sp,
                                      fontWeight: FontWeight.w400,
                                      fontColor: const Color(0xff1A1A1A)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  Widget get bottomGestureButtons {
    return MyCustomButton(
      width: App.appQuery.responsiveWidth(70) /*312.0*/,
      height: 45.h,
      borderRadius: BorderRadius.circular(10.0),
      onPressed: () => {
        entityListViewModel.saveReport()
      },
      text: translation.save,
    );
  }
}
