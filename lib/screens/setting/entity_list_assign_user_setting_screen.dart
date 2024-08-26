import 'dart:io';

import 'package:cold_storage_flutter/models/entity/entity_assigned_list_model.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/view_models/setting/entitylist_user_assign_setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';

class EntityListAssignUserSettingScreen extends StatefulWidget {
  const EntityListAssignUserSettingScreen({super.key});

  @override
  State<EntityListAssignUserSettingScreen> createState() =>
      _EntityListAssignUserSettingScreenState();
}

class _EntityListAssignUserSettingScreenState
    extends State<EntityListAssignUserSettingScreen> {
  final entityListViewModel = Get.put(EntitylistUserAssignSettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: bottomGestureButtons,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
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
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Entity Listing',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                        padding: App.appSpacer.edgeInsets.top.none,
                        child: Obx(
                          () => IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                // _sliderDrawerKey.currentState!.toggle();
                              },
                              icon: AppCachedImage(
                                  roundShape: true,
                                  height: 25,
                                  width: 25,
                                  url: entityListViewModel.logoUrl.value)),
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
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    elevation: 20,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 90),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(
                            color: const Color(0xFFE6E6E6),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11))),
                      child: entityListViewModel.entityList!.isNotEmpty
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
                          : Container(
                              width: 1800,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(EntityAssigned entity, int index) {
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
      child: Padding(
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
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: AppCachedImage(
                        roundShape: true,
                        height: 45,
                        width: 45,
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
                                fontSize: 14.0,
                                fontColor: const Color(0xFF000000),
                                fontWeight: FontWeight.w400),
                            CustomTextField(
                                textAlign: TextAlign.left,
                                text: entity.entityType == 1
                                    ? 'Cold Storage'
                                    : 'Farmhouse',
                                fontSize: 12,
                                fontColor: const Color(0xFF828282),
                                fontWeight: FontWeight.w400),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (entity.assigned == true) ...[
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          Container(
                            width: 95,
                            height: 28,
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
                            child: const Align(
                              alignment: Alignment.center,
                              child: CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: 'Assigned',
                                  fontSize: 12.0,
                                  fontColor: Color(0xFF1F9254),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          GestureDetector(
                            onTap: () {
                              entityListViewModel.removeAssignedUser(entity);
                            },
                            child: Container(
                              width: 95,
                              height: 28,
                              decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                    top: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                    right: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                  ),
                                  color: Color(0xFFF6E0E0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              child: const Align(
                                alignment: Alignment.center,
                                child: CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'Remove',
                                    fontSize: 12.0,
                                    fontColor: Color(0xFF921F1F),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                        if (entity.assigned == false) ...[
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          App.appSpacer.vHxxxs,
                          GestureDetector(
                            onTap: () {
                              entityListViewModel.assignedUser(entity);
                            },
                            child: Container(
                              width: 95,
                              height: 28,
                              decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                    top: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                    bottom: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                    right: BorderSide(
                                        color: Color(0xFF921F1F), width: 1),
                                  ),
                                  color: Color(0xFFF6E0E0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              child: const Align(
                                alignment: Alignment.center,
                                child: CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'Add',
                                    fontSize: 12.0,
                                    fontColor: Color(0xFF921F1F),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ]
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget get bottomGestureButtons {
    return MyCustomButton(
      width: App.appQuery.responsiveWidth(70) /*312.0*/,
      height: 45,
      borderRadius: BorderRadius.circular(10.0),
      onPressed: () => {},
      text: 'Save',
    );
  }
}
