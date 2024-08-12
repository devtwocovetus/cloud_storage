
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/screens/material/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/material_transfer_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

class TransferIncomingMaterial extends StatelessWidget {
  TransferIncomingMaterial({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(MaterialTransferViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() => Visibility(
          visible: !showFab,
          child: controller.isConfirm.value
              ? bottomGestureButtons(context)
              : _addButtonWidget)),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 10, 0),
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
                    const Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Incoming Material',
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20,
                              width: 20,
                              url: controller.logoUrl.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: App.appSpacer.edgeInsets.y.smm,
              child: Obx(
                () => Form(
                  key: _coldStorageFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      clientViewTile(context),
                      App.appSpacer.vHs,
                      _entityNameWidget,
                      App.appSpacer.vHs,
                      _clientNameWidget,
                      App.appSpacer.vHs,
                      ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:15,
                              itemBuilder: (BuildContext context, int index) {
                                return materialTile(index,context);
                              }),
                      App.appSpacer.vHs,
                       App.appSpacer.vHs,
                      App.appSpacer.vHxxl,
                      // _addButtonWidget
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget _restWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: App.appSpacer.edgeInsets.x.sm,
          decoration: const BoxDecoration(
            color: Color(0xffEFF8FF),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Supplier',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Henry Jacks',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: Image.asset(
                    'assets/images/ic_group_arrow.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Your Account',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Mark Johnson',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _restDividerWidget0(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: const Align(
                    alignment: Alignment.center,
                    child: DottedLine(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      lineLength: 10,
                      lineThickness: 2.0,
                      dashLength: 1,
                      dashColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restDividerWidget2(BuildContext context) {
    return Container(
     transform: Matrix4.translationValues(0.0, -5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: const Align(
                    alignment: Alignment.center,
                    child: DottedLine(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      lineLength: 20,
                      lineThickness: 2.0,
                      dashLength: 1,
                      dashColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   Widget _restDividerWidget3(BuildContext context) {
    return Container(
     transform: Matrix4.translationValues(0.0, -5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: const Align(
                    alignment: Alignment.center,
                    child: DottedLine(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      lineLength: 20,
                      lineThickness: 2.0,
                      dashLength: 1,
                      dashColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _restCategoryWidget(BuildContext context) {
    return Container(
       transform: Matrix4.translationValues(0.0, -2.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Category',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      App.appSpacer.vHxxs,
                      App.appSpacer.vHxxs,
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Fruit',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff474747),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: Column(
                    children: [
                      SizedBox(
                width: Utils.deviceWidth(context) * 0.20,
                child: const Align(
                  alignment: Alignment.center,
                  child: DottedLine(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    lineLength: 20,
                    lineThickness: 2.0,
                    dashLength: 1,
                    dashColor: Colors.black,
                  ),
                ),
              ),
                      Image.asset(
                        'assets/images/ic_group_arrow.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                width: Utils.deviceWidth(context) * 0.20,
                child: const Align(
                  alignment: Alignment.center,
                  child: DottedLine(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    lineLength: 20,
                    lineThickness: 2.0,
                    dashLength: 1,
                    dashColor: Colors.black,
                  ),
                ),
              ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Category',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor:controller.isCustomMapping.value ? const Color(0xff1A1A1A) :  Colors.grey.withOpacity(0.8)),
                      App.appSpacer.vHxxs,
                      MyCustomDropDown<String>(
                        enabled: controller.isCustomMapping.value,
                        padding: const EdgeInsets.all(8),
                        itemList: controller.binList,
                        hintText: 'Select Bin',
                        validateOnChange: true,
                        headerBuilder: (context, selectedItem, enabled) {
                          return Text(
                              Utils.textCapitalizationString(selectedItem));
                        },
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
                          return Text(Utils.textCapitalizationString(item));
                        },
                        onChange: (item) {
                          controller.mStrBin.value = item!.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restMaterialWidget(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Material',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      App.appSpacer.vHxxs,
                      App.appSpacer.vHxxs,
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Apple',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff474747),
                      ),
                    ],
                  ),
                ),
                  SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: Column(
                    children: [
                      SizedBox(
                width: Utils.deviceWidth(context) * 0.20,
                child: const Align(
                  alignment: Alignment.center,
                  child: DottedLine(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    lineLength: 20,
                    lineThickness: 2.0,
                    dashLength: 1,
                    dashColor: Colors.black,
                  ),
                ),
              ),
                      Image.asset(
                        'assets/images/ic_group_arrow.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                width: Utils.deviceWidth(context) * 0.20,
                child: const Align(
                  alignment: Alignment.center,
                  child: DottedLine(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    lineLength: 20,
                    lineThickness: 2.0,
                    dashLength: 1,
                    dashColor: Colors.black,
                  ),
                ),
              ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Material',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor:controller.isCustomMapping.value ? const Color(0xff1A1A1A) :  Colors.grey.withOpacity(0.8)),
                      App.appSpacer.vHxxs,
                      MyCustomDropDown<String>(
                        enabled: controller.isCustomMapping.value,
                        padding: const EdgeInsets.all(8),
                        itemList: controller.binList,
                        hintText: 'Select Bin',
                        validateOnChange: true,
                        headerBuilder: (context, selectedItem, enabled) {
                          return Text(
                              Utils.textCapitalizationString(selectedItem));
                        },
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
                          return Text(Utils.textCapitalizationString(item));
                        },
                        onChange: (item) {
                          controller.mStrBin.value = item!.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restUnitWidget(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -6.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Unit',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      App.appSpacer.vHxxs,
                      App.appSpacer.vHxxs,
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'AULC 4022 GREEN',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff474747),
                      ),
                    ],
                  ),
                ),
                  SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: Column(
                    children: [
                      SizedBox(
                width: Utils.deviceWidth(context) * 0.20,
                child: const Align(
                  alignment: Alignment.center,
                  child: DottedLine(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    lineLength: 20,
                    lineThickness: 2.0,
                    dashLength: 1,
                    dashColor: Colors.black,
                  ),
                ),
              ),
                      Image.asset(
                        'assets/images/ic_group_arrow.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                width: Utils.deviceWidth(context) * 0.20,
                child: const Align(
                  alignment: Alignment.center,
                  child: DottedLine(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    lineLength: 20,
                    lineThickness: 2.0,
                    dashLength: 1,
                    dashColor: Colors.black,
                  ),
                ),
              ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Unit',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor:controller.isCustomMapping.value ? const Color(0xff1A1A1A) :  Colors.grey.withOpacity(0.8)),
                      App.appSpacer.vHxxs,
                      MyCustomDropDown<String>(
                        enabled: controller.isCustomMapping.value,
                        padding: const EdgeInsets.all(8),
                        itemList: controller.binList,
                        hintText: 'Select Bin',
                        validateOnChange: true,
                        headerBuilder: (context, selectedItem, enabled) {
                          return Text(
                              Utils.textCapitalizationString(selectedItem));
                        },
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
                          return Text(Utils.textCapitalizationString(item));
                        },
                        onChange: (item) {
                          controller.mStrBin.value = item!.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget get _entityNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Entity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            backgroundColor: Colors.grey.withOpacity(0.2) ,
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Entity Name',
              readOnly: true,
              controller: controller.entityNameController.value,
              focusNode: controller.entityNameFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }


  Widget get _uOMWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'UOM',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
             backgroundColor: Colors.grey.withOpacity(0.2) ,
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'UOM',
              readOnly: true,
              controller: controller.clientNameController.value,
              focusNode: controller.clientNameFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _customMappingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Row(
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Need Custom Mapping',
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          const Spacer(),
          GestureDetector(
            onTap: () {
              controller.isCustomMapping.value =
                  !controller.isCustomMapping.value;
            },
            child: controller.isCustomMapping.value
                ? Image.asset(
                    'assets/images/ic_switch_on.png',
                    width: 34,
                    height: 20,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/ic_switch_off.png',
                    width: 34,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }

  Widget get _clientNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Select Client',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            itemList: controller.binList,
            hintText: 'Select Client',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            onChange: (item) {
              controller.mStrBin.value = item!.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget get _addButtonWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          if (_coldStorageFormKey.currentState!.validate())
            {
              if (controller.entityQuantityList.isNotEmpty)
                {controller.isConfirm.value = true}
              else
                {
                  Utils.isCheck = true,
                  Utils.snackBar('Error', 'Please add quantity')
                }
            }
        },
        text: 'Confirm',
      ),
    );
  }

  Widget bottomGestureButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {controller.isConfirm.value = false},
          text: 'Back',
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            if (_coldStorageFormKey.currentState!.validate())
              {
                if (controller.signatureFilePath.value.isNotEmpty)
                  {
                    DialogUtils.showCustomDialog(
                      context,
                      okBtnFunction: () {
                        Get.back(closeOverlays: true);
                        controller.addMaterialIn();
                      },
                    )
                  }
                else
                  {
                    Utils.isCheck = true,
                    Utils.snackBar('Error', 'Please add signature')
                  }
              }
          },
          text: 'Generate',
        )
      ],
    );
  }


     Widget materialTile(int index, BuildContext context) {
    return Container(
      margin: App.appSpacer.edgeInsets.x.sm,
      padding: EdgeInsets.fromLTRB(
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: index % 2 == 0
                ? const Color(0xffEFF8FF)
                : const Color(0xffFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [
              SizedBox(
                   width: Utils.deviceWidth(context) * 0.36,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Material',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                     CustomTextField(
                       textAlign: TextAlign.left,
                       text: 'Client',
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                       fontColor: Color(0xff1A1A1A),
                     ),
                  ],
                ),
              ),
              SizedBox(
                 width: Utils.deviceWidth(context) * 0.195,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Type',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Client',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff1A1A1A),
                    ),
                  ],
                ),
              ),

                SizedBox(
                 width: Utils.deviceWidth(context) * 0.195,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Quantity',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Client',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff1A1A1A),
                    ),
                  ],
                ),
              ),

                SizedBox(
                 width: Utils.deviceWidth(context) * 0.10,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/ic_list_nonconfirm.png',
                        width: 20,
                        height: 20,
                      ),
                  ],
                ),
              ),

             
            
            ],
          ),
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
        ],
      ),
    );
  }

   Widget clientViewTile(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
          Utils.deviceWidth(context) * 0.03, Utils.deviceWidth(context) * 0.03),
      padding: EdgeInsets.fromLTRB(
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
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
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Supplier',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Client',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),

              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Quantity',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
            
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString('Hello'),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString('Hello'),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString('Hello'),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
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
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Receipt Date',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Driver Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString('Hello'),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString('Hello'),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
              ),
            ],
          ),
          App.appSpacer.vHs,
          const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Note',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
                App.appSpacer.vHxxxs,
                const CustomTextField(
                  line: 4,
                  isMultyline: true,
                  textAlign: TextAlign.left,
                  text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff1A1A1A),
                ),
                   App.appSpacer.vHs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
        ],
      ),
    );
  }

}
