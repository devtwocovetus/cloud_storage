import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/view_models/setting/entitylist_setting_view_model.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/dropdown/model/dropdown_item_model.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class EntityListSettingScreen extends StatefulWidget {
  const EntityListSettingScreen({super.key});

  @override
  State<EntityListSettingScreen> createState() =>
      _EntityListSettingScreenState();
}

class _EntityListSettingScreenState extends State<EntityListSettingScreen> {
  final entityListViewModel = Get.put(EntitylistSettingViewModel());
  final emailController = TextEditingController();
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
                    CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.entity_settings,
                        fontSize: 18.0.sp,
                        fontColor: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    // Padding(
                    //   padding: App.appSpacer.edgeInsets.top.none,
                    //   child: IconButton(
                    //       padding: EdgeInsets.zero,
                    //       onPressed: () {
                    //         Get.until((route) =>
                    //         Get.currentRoute == RouteName.homeScreenView);
                    //       },
                    //       icon: const SVGAssetImage(
                    //         height: 20,
                    //         width: 20,
                    //         url: 'assets/images/default/ic_home.svg',
                    //         fit: BoxFit.cover,
                    //       )),
                    // ),
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
      body: SafeArea(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: CustomSearchField(
                          margin: App.appSpacer.edgeInsets.x.none,
                          searchController: entityListViewModel.searchController.value,
                          prefixIconVisible: true,
                          filled: true,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              entityListViewModel.searchFilter('');
                            } else if (value.isNotEmpty) {
                              entityListViewModel.searchFilter(value);
                            }
                          },
                          onSubmit: (value) async {
                            if (value.isEmpty) {
                              entityListViewModel.searchFilter('');
                            } else if (value.isNotEmpty) {
                              entityListViewModel.searchFilter(value);
                            }
                          },
                          onCrossTapped: () {
                            entityListViewModel.searchFilter('');
                            entityListViewModel.searchController.value.clear();
                          },
                        )
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                          decoration: const BoxDecoration(
                              color: Color(0xFFEFF8FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: sortingDropdown(),
                        ),
                      ),
                      if (Utils.decodedMap['add_entity'] == true) ...[
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteName.entityOnboarding,
                                      arguments: [
                                    {"EOB": 'SETTING'}
                                  ])!
                                  .then((value) {});
                            },
                            child: Image.asset(
                                width: 30.h,
                                height: 30.h,
                                'assets/images/ic_add_new.png'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(
                            color: const Color(0xFFE6E6E6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: kAppBlack.withOpacity(0.15),
                              spreadRadius: 0,
                              blurRadius: 20, // Increased blur radius
                              offset: const Offset(0, 4),
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child: !entityListViewModel.isLoading.value
                          ? entityListViewModel.entityList!.isNotEmpty
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      entityListViewModel.entityList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return listItem(entityListViewModel
                                        .entityList![index]);
                                  })
                              : SizedBox(
                                  width: 1800.h,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/images/ic_blank_list.png'),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomTextField(
                                          textAlign: TextAlign.center,
                                          text: translation.no_entity_found,
                                          fontSize: 18.0..sp,
                                          fontColor: const Color(0xFF000000),
                                          fontWeight: FontWeight.w500),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      MyCustomButton(
                                        height: Utils.deviceHeight(context) *
                                            0.06,
                                        padding:
                                            Utils.deviceWidth(context) * 0.10,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        onPressed: () => {
                                          Get.toNamed(
                                                  RouteName.entityOnboarding,
                                                  arguments: [
                                                {"EOB": 'SETTING'}
                                              ])!
                                              .then((value) {})
                                        },
                                        text: translation.create_entity,
                                      ),
                                    ],
                                  ),
                                )
                          : const SizedBox.expand(),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget sortingDropdown(){
    return MyCustomDropDown<DropdownItemModel>(
      itemList: entityListViewModel.sortingItems,
      hintText: translation.sort_by,
      hintFontSize: 13.5.sp,
      enableBorder: false,
      padding: App.appSpacer.edgeInsets.symmetric(x: 'xs',y: 's'),
      validateOnChange: true,
      headerBuilder: (context, selectedItem, enabled) {
        return Text(selectedItem.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack,fontWeight: FontWeight.w400,fontSize: 14.0.sp)),
        );
      },
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(item.title,
          style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.6),fontWeight: FontWeight.w400,fontSize: 14.0.sp)),
        );
      },
      onChange: (item) {
        log('changing value to: $item');
        if(item != null){
          entityListViewModel.sortListByProperty(item);
        }
      },
    );
  }

  Widget listItem(Entity entity) {
    return GestureDetector(
      onTap: () => {
        // Get.toNamed(RouteName.entityDashboard, arguments: [
        //   {
        //     "entityName": entity.name,
        //     "entityId": entity.id.toString(),
        //     "entityType": entity.entityType.toString()
        //   }
        // ])
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Color(0xFFE4E4EF)),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCachedImage(
                  roundShape: true,
                  height: 55.h,
                  width: 55.h,
                  fit: BoxFit.cover,
                  url: entity.profileImage,
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
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/ic_user_name.png'),
                            SizedBox(
                              width: 3.h,
                            ),
                            Expanded(
                              child: CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: Utils.textCapitalizationString(entity
                                      .managerName
                                      .toString()), //manager name
                                  fontSize: 13.0.sp,
                                  fontColor: kAppGreyA,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (Utils.decodedMap['edit_entity'] == true ||
                        Utils.decodedMap['delete_entity'] == true) ...[
                       SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          if (Utils.decodedMap['delete_entity'] == true) ...[
                            IconButton(
                              onPressed: () {
                                DialogUtils.showDeleteConfirmDialog(
                                  context,
                                  okBtnFunction: () {
                                    Get.back(closeOverlays: true);
                                    entityListViewModel.deleteEntity(
                                        entity.id.toString(),
                                        entity.entityType.toString());
                                  },
                                );
                              },
                              padding: EdgeInsets.zero,
                              icon: Image.asset(
                                height: 20.h,
                                width: 20.h,
                                'assets/images/ic_delete.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],

                          if (Utils.decodedMap['edit_entity'] == true) ...[
                            IconButton(
                              onPressed: () {
                                if (entity.entityType == 1) {
                                  Get.toNamed(RouteName.updateWarehouse,
                                      arguments: {
                                        'entity': entity,
                                        'from_where': 'SETTING'
                                      });
                                } else {
                                  Get.toNamed(RouteName.updateFarmhouse,
                                      arguments: {
                                        'entity': entity,
                                        'from_where': 'SETTING'
                                      });
                                }
                              },
                              padding: EdgeInsets.zero,
                              icon: Image.asset(
                                height: 20.h,
                                width: 20.h,
                                'assets/images/ic_edit.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ]

                          // Image.asset(
                          //     height: 25, width: 25, 'assets/images/ic_edit.png'),
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 10.h,
                    ),
                    entity.entityType == 1
                        ? Container(
                            width: 120.h,
                            height: 28.h,
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                            decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  right: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                ),
                                color: Color(0xFFEBF9F1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
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
                                      color: Color(0xFF1F3f92), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  right: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                ),
                                color: Color(0xFFD7E9FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
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
            )),
      ),
    );
  }

  toggleDone(bool bool) {}
}
