import 'dart:convert';

import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/models/material/unit_list_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/unit_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';

class MaterialUnitList extends StatefulWidget {
  const MaterialUnitList({super.key});

  @override
  State<MaterialUnitList> createState() => _MaterialUnitListState();
}

class _MaterialUnitListState extends State<MaterialUnitList> {
  final materialUnitListViewModel = Get.put(UnitListViewModel());

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double fullWidth = Utils.deviceWidth(context) * 0.9;
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: MyCustomButton(
          width: App.appQuery.responsiveWidth(80) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () async => {
            Get.toNamed(RouteName.addMaterialQuantityScreen, arguments: [
              {
                "MaterialName": materialUnitListViewModel.materialName.value,
                "MaterialNameId":
                    materialUnitListViewModel.materialNameId.value,
                "MaterialCategory":
                    materialUnitListViewModel.materialCategory.value,
                "MaterialCategoryId":
                    materialUnitListViewModel.materialCategoryId.value,
                "MOUID": materialUnitListViewModel.mouId.value,
                "MOUValue": materialUnitListViewModel.mOUValue.toString(),
                "MOUType": materialUnitListViewModel.mOUType.toString(),
                "MOUNAME": materialUnitListViewModel.mouName.toString()
              }
            ])
          },
          text: 'Create  Unit',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
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
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Material',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
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
                          height: 25,
                          width: 25,
                          url: materialUnitListViewModel.logoUrl.value)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Utils.deviceWidth(context) * 0.04,
                      0,
                      Utils.deviceWidth(context) * 0.04,
                      0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: materialUnitListViewModel.materialCategory
                              .toString().length > 20 ? '${materialUnitListViewModel.materialCategory
                              .toString().substring(0,20)}...'
                            : materialUnitListViewModel.materialCategory
                              .toString(),
                          fontSize: 16.0,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                      const SizedBox(
                        width: 3,
                      ),
                      Image.asset(
                        'assets/images/ic_forward_black.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text:materialUnitListViewModel.materialName.toString().length > 20 ? materialUnitListViewModel.materialName.toString().substring(0,20).toCapitalize() : materialUnitListViewModel.materialName.toString().toCapitalize(),
                            fontSize: 16.0,
                            fontColor: const Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.03,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.05,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Material Name',
                            fontSize: 15,
                            fontColor: Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.01,
                    ),
                    Center(
                      child: Container(
                        width: Utils.deviceWidth(context) * 0.90,
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            top: BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            bottom:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            right:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                          ),
                        ),
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: materialUnitListViewModel.materialName
                                .toString(),
                            fontSize: 12,
                            fontColor: const Color(0xFF000000),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.03,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.05,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Category',
                            fontSize: 15,
                            fontColor: Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.01,
                    ),
                    Center(
                      child: Container(
                        width: Utils.deviceWidth(context) * 0.90,
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            top: BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            bottom:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            right:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                          ),
                        ),
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: materialUnitListViewModel.materialCategory
                                .toString(),
                            fontSize: 12,
                            fontColor: const Color(0xFF000000),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.03,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.05,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Description',
                            fontSize: 15,
                            fontColor: Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.01,
                    ),
                    Center(
                      child: Container(
                        width: Utils.deviceWidth(context) * 0.90,
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            top: BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            bottom:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            right:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                          ),
                        ),
                        child: CustomTextField(
                            isMultyline: true,
                            line: 3,
                            textAlign: TextAlign.left,
                            text: materialUnitListViewModel.materialDescription
                                .toString(),
                            fontSize: 12,
                            fontColor: const Color(0xFF000000),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.03,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.05,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Measurement of Unit',
                            fontSize: 15,
                            fontColor: Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.01,
                    ),
                    Center(
                      child: Container(
                        width: Utils.deviceWidth(context) * 0.90,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            top: BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            bottom:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            right:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                          ),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  child: CustomTextField(
                                      textAlign: TextAlign.center,
                                      text: materialUnitListViewModel.mOUType
                                          .toString(),
                                      fontSize: 12,
                                      fontColor: const Color(0xFF000000),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const VerticalDivider(
                                color: Color(0xFF000000),
                                thickness: 0.5,
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  child: CustomTextField(
                                      textAlign: TextAlign.center,
                                      text: materialUnitListViewModel.mouName
                                          .toString(),
                                      fontSize: 12,
                                      fontColor: const Color(0xFF000000),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.03,
                ),
                Center(
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(fullWidth * 0.05, 0, fullWidth * 0.05, 0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: fullWidth * 0.28,
                          child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Unit Name',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: fullWidth * 0.25,
                          child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'MOU',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: fullWidth * 0.23,
                          child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Type',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: fullWidth * 0.25,
                          child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Action',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: materialUnitListViewModel.unitList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return listItem(
                              materialUnitListViewModel.unitList![index],
                              index);
                        }),
                  ),
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.10,
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listItem(Unit unit, int ind) {
    double fullWidth = Utils.deviceWidth(context) * 0.9;
    return GestureDetector(
      onTap: () => {},
      child: Container(
       padding:  EdgeInsets.fromLTRB(fullWidth * 0.025, 10, fullWidth * 0.025, 10),
        decoration: BoxDecoration(
            color: ind % 2 == 0
                ? const Color(0xffEFF8FF)
                : const Color(0xffFFFFFF),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            SizedBox(
              width: fullWidth * 0.28,
              child: CustomTextField(
                textAlign: TextAlign.left,
                text: unit.unitName.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: const Color(0xff074173),
              ),
            ),
            SizedBox(
              width: fullWidth * 0.25,
              child: CustomTextField(
                textAlign: TextAlign.left,
                text: Utils.textCapitalizationString('${unit.quantity.toString()}(${materialUnitListViewModel.mouName.toString()})'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: const Color(0xff074173),
              ),
            ),
            SizedBox(
              width: fullWidth * 0.22,
              child: CustomTextField(
                textAlign: TextAlign.left,
                text: Utils.textCapitalizationString(materialUnitListViewModel.mOUType.toString()),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: const Color(0xff074173),
              ),
            ),
            SizedBox(
              width: fullWidth * 0.25,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                       DialogUtils.showDeleteConfirmDialog(
                  context,
                  okBtnFunction: () {
                    Get.back(closeOverlays: true);
                    materialUnitListViewModel.deleteUnit(unit.id.toString());
                  },
                );

                    },
                    child: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_delete_dark_blue.png'),
                  ),
                SizedBox(width: fullWidth * 0.025,),
                  const CustomTextField(
                    textAlign: TextAlign.center,
                    text: '|',
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    fontColor: Color(0xff9CBFFF),
                  ),
                 SizedBox(width: fullWidth * 0.025,), 
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.updateMaterialQuantityScreen,arguments: [
                        {
                          "MaterialName": materialUnitListViewModel.materialName.value,
                          "MaterialNameId":
                          materialUnitListViewModel.materialNameId.value,
                          "MaterialCategory":
                          materialUnitListViewModel.materialCategory.value,
                          "MaterialCategoryId":
                          materialUnitListViewModel.materialCategoryId.value,
                          "MOUID": materialUnitListViewModel.mouId.value,
                          "MOUValue": materialUnitListViewModel.mOUValue.toString(),
                          "MOUType": materialUnitListViewModel.mOUType.toString(),
                          "MOUNAME": materialUnitListViewModel.mouName.toString(),
                          "material_data": jsonEncode(materialUnitListViewModel.unitList?[ind].toJson()),
                        }
                      ]);
                    },
                    child: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_edit_dark_blue.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
