
import 'dart:io';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/variables/var_string.dart';
import 'package:cold_storage_flutter/screens/material/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/screens/material/material_in/quantity_creation_form.dart';
import 'package:cold_storage_flutter/screens/material/widgets/signature_pad.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material_in/material_in_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

class MaterialIn extends StatelessWidget {
  MaterialIn({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(MaterialInViewModel());
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
                    const Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Material IN',
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
                              height: 25,
                              width: 25,
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
                      _entityNameWidget,
                      App.appSpacer.vHs,
                       Padding(
                       padding: EdgeInsets.fromLTRB(
            App.appSpacer.sm, 0, App.appSpacer.sm, App.appSpacer.sm),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                                textAlign: TextAlign.left,
                                text: '.......................',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontColor: Color(0xff1A1A1A)),
                            Spacer(),
                            CustomTextField(
                                textAlign: TextAlign.center,
                                text: 'Supplier',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontColor: Color(0xff1A1A1A)),
                            Spacer(),
                            CustomTextField(
                                textAlign: TextAlign.right,
                                text: '.......................',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontColor: Color(0xff1A1A1A))
                          ],
                        ),
                      ),

                      App.appSpacer.vHs,
                      _clientNameWidget,
                      App.appSpacer.vHs,
                      _dateWidget(context),
                      if (!controller.isConfirm.value) ...[
                        App.appSpacer.vHs,
                        _addedBinTile(context),
                      ],

                      if (controller.isConfirm.value) ...[
                        App.appSpacer.vHs,
                        _addedConfirmTile(context),
                      ],

                      App.appSpacer.vHs,
                      App.appSpacer.vHxxl,
                      // _addButtonWidget
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget get _entityNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Entity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              readOnly: true,
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Entity name',
              controller: controller.entityNameController.value,
              focusNode: controller.entityNameFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter entity name';
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _clientNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Client Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            enabled: controller.isConfirm.value ? false : true,
            itemList: controller.clientList,
            hintText: 'Client Name',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            validator: (value) {
              if (value == null) {
                return "   Select a client name";
              }
              return null;
            },
            onChange: (item) {
              controller.mStrClient.value = item.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget _dateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Date of Receipt',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              readOnly: true,
              onTab: () async {
                if (!controller.isConfirm.value) {
                  await _selectDate(context);
                }
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  'assets/images/ic_calender.png',
                ),
              ),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Date of Receipt',
              controller: controller.dateController.value,
              focusNode: controller.dateFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Select date of receipt';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      controller.dateController.value.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
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
            if (_coldStorageFormKey.currentState!.validate()){
              if(controller.signatureFilePath.value.isNotEmpty){
                DialogUtils.showCustomDialog(
                  context,
                  okBtnFunction: () {
                    Get.back(closeOverlays: true);
                    controller.addMaterialIn();
                  },
                )
              }else{
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

  Widget _addedBinTile(BuildContext context) {
    return controller.entityQuantityList.isNotEmpty
        ? Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              color: kBinCardBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                App.appSpacer.vHs,
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      App.appSpacer.sm, 0, App.appSpacer.sm, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Add Quantity',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      InkWell(
                        onTap: () {
                          //controller.addBinFormOpen.value = true;
                          Get.dialog(
                            QuantityCreationForm(),
                          );
                        },
                        splashColor: kAppPrimary,
                        child: SVGAssetImage(
                          width: Utils.deviceWidth(context) * 0.10,
                          height: 25,
                          url: addIconSvg,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
            padding: EdgeInsets.fromLTRB(
            App.appSpacer.sm, 0, App.appSpacer.sm,0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: '.......................',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: 'Quantity',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.right,
                          text: '.......................',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A))
                    ],
                  ),
                ),
                App.appSpacer.vHs,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.entityQuantityList.length,
                  separatorBuilder: (context, index) {
                    return App.appSpacer.vHs;
                  },
                  itemBuilder: (context, index) {
                    return clientViewTile(
                        index, context, controller.entityQuantityList[index]);
                  },
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              color: kBinCardBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                 Padding(
                   padding: EdgeInsets.fromLTRB(
            App.appSpacer.sm, 0, App.appSpacer.sm, App.appSpacer.sm),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: '.......................',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: 'Quantity',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.right,
                          text: '.......................',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A))
                    ],
                  ),
                ),
                App.appSpacer.vHs,
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      App.appSpacer.sm, 0, App.appSpacer.sm, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: controller.entityQuantityList.isEmpty
                              ? 'Add Quantity'
                              : 'Add more Quantity',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                      InkWell(
                        onTap: () {
                          //controller.addBinFormOpen.value = true;
                          Get.dialog(
                            QuantityCreationForm(),
                          );
                        },
                        splashColor: kAppPrimary,
                        child: SVGAssetImage(
                          width: Utils.deviceWidth(context) * 0.10,
                          height: 25,
                          url: addIconSvg,
                        ),
                      )
                    ],
                  ),
                ),
                App.appSpacer.vHs,
              ],
            ),
          );
  }

  Widget _addedConfirmTile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      decoration: BoxDecoration(
        color: kBinCardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            App.appSpacer.sm, 0, App.appSpacer.sm, App.appSpacer.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                    textAlign: TextAlign.left,
                    text: '...............',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                Spacer(),
                CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Transportation Details',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                Spacer(),
                CustomTextField(
                    textAlign: TextAlign.right,
                    text: '...............',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A))
              ],
            ),
            App.appSpacer.vHs,
            const CustomTextField(
              required: true,
                textAlign: TextAlign.left,
                text: 'Driver Name',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontColor: Color(0xff1A1A1A)),
            App.appSpacer.vHxxs,
            CustomTextFormField(
                width: App.appQuery.responsiveWidth(100),
                height: 25,
                borderRadius: BorderRadius.circular(10.0),
                hint: 'Driver Name',
                controller: controller.driverController.value,
                focusNode: controller.driverFocusNode.value,
                validating: (value) {
                  if (value!.isEmpty) {
                    return 'Enter driver name';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.text),
            App.appSpacer.vHs,
            const CustomTextField(
              required: true,
                textAlign: TextAlign.left,
                text: 'Signature',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontColor: Color(0xff1A1A1A)),
            App.appSpacer.vHxxs,
            DottedBorder(
              dashPattern: [8],
              color: const Color(0xffD0D5DD),
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: const Radius.circular(9),
              child: Container(
                width: App.appQuery.responsiveWidth(100),
                color: const Color(0xffFFFFFF),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    if (controller.signatureFilePath.value.isNotEmpty) ...[
                      Image.file(
                        File(controller.signatureFilePath.value),
                        fit: BoxFit.cover,
                      ),
                      App.appSpacer.vHxxs,
                    ],
                    GestureDetector(
                      onTap: () async {
                        Get.dialog(
                          const SignaturePad(),
                        );
                      },
                      child: const CustomTextField(
                          textAlign: TextAlign.center,
                          text: 'Add Signature',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff969DB2)),
                    ),
                    App.appSpacer.vHxxs,
                    GestureDetector(
                      onTap: () async {
                        Get.dialog(
                          const SignaturePad(),
                        );
                      },
                      child: const CustomTextField(
                          textAlign: TextAlign.center,
                          text: 'Click here to draw signature',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff505050)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clientViewTile(
      int index, BuildContext context, Map<String, dynamic> quantity) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: quantity['material'].toString(),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: '(${quantity['category'].toString()})',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    height: 20,
                    width: 20,
                    'assets/images/ic_gallary.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: (){
                       DialogUtils.showDeleteConfirmDialog(
                  context,
                  okBtnFunction: () {
                    Get.back(closeOverlays: true);
                    controller.deleteBinToList(index);
                  },
                );
                    },
                    child: Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_delete.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    height: 20,
                    width: 20,
                    'assets/images/ic_edit.png',
                    fit: BoxFit.cover,
                  )
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
                width: Utils.deviceWidth(context) * 0.40,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Unit',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.30,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Type',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.17,
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
                width: Utils.deviceWidth(context) * 0.40,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: quantity['unit'].toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.30,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: quantity['unit_type'].toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.17,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: quantity['quantity'].toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
            ],
          ),
          App.appSpacer.vHs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.40,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'UOM',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.40,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Bin',
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
                width: Utils.deviceWidth(context) * 0.40,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: '${quantity['unit_quantity']} ${quantity['mou_name']}',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.40,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: quantity['bin'].toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
        ],
      ),
    );
  }
}
