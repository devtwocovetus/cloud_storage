import 'dart:io';

import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/new_entitylist_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/routes/routes_name.dart';

class NewEntityListScreen extends StatefulWidget {
  const NewEntityListScreen({super.key});

  @override
  State<NewEntityListScreen> createState() => _NewEntityListScreenState();
}

class _NewEntityListScreenState extends State<NewEntityListScreen> {
  final entityListViewModel = Get.put(NewEntitylistViewModel());

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
                padding: const EdgeInsets.fromLTRB(3, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        exit(0);
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
                        text: 'Entity list',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image:
                                  entityListViewModel.logoUrl.value.isNotEmpty
                                      ? NetworkImage(
                                          entityListViewModel.logoUrl.value)
                                      : const AssetImage(
                                          'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Obx(() => Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 60),
              child: entityListViewModel.entityList!.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: entityListViewModel.entityList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listItem(entityListViewModel.entityList![index]);
                      })
                  : Container(
                      width: 1800,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/ic_blank_list.png'),
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
            )),
      ),
    );
  }

  Widget listItem(Entity entity) {
    return GestureDetector(
      onTap: () => {Get.toNamed(RouteName.entityDashboard)},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Material(
          elevation: 5,
          color: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFE6E6E6), width: 1),
          ),
          child: Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                                'assets/images/ic_user_defualt.png')),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                              textAlign: TextAlign.left,
                              line: 2,
                              text: entity.name.toString(),
                              fontSize: 14.0,
                              fontColor: const Color(0xFF000000),
                              fontWeight: FontWeight.w400),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/ic_user_name.png'),
                              const SizedBox(
                                width: 3,
                              ),
                              CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: entity.ownerName.toString(),
                                  fontSize: 13.0,
                                  fontColor: const Color(0xFF3C3C43),
                                  fontWeight: FontWeight.w400)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                              height: 25,
                              width: 25,
                              'assets/images/ic_delete.png'),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                              height: 25,
                              width: 25,
                              'assets/images/ic_edit.png'),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      entity.entityType == 1
                          ? Container(
                              width: 95,
                              height: 28,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFEBF9F1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
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
                                  color: Color(0xFFD7E9FF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              child: const Align(
                                alignment: Alignment.center,
                                child: CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'Farmhouse',
                                    fontSize: 12.0,
                                    fontColor: Color(0xFF1F9254),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget get bottomGestureButtons {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Get.toNamed(RouteName.entityOnboarding, arguments: [
              {"EOB": 'NEW'}
            ])!
                .then((value) {})
          },
          text: 'Add Entity',
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () =>
              {Get.offAllNamed(RouteName.homeScreenView)!.then((value) {})},
          text: 'Setup Finish',
        )
      ],
    );
  }
}
