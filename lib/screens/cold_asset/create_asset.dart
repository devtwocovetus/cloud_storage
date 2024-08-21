import 'package:cold_storage_flutter/screens/cold_asset/asset_category_add.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/cold_asset_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../utils/utils.dart';

class CreateAsset extends StatelessWidget {
  CreateAsset({super.key});

  final ColdAssetViewModel controller = Get.put(ColdAssetViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Visibility(visible: !showFab, child: _addButtonWidget),
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
                          text: 'Asset  Creation',
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0,
                            App.appSpacer.sm, App.appSpacer.sm),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                                textAlign: TextAlign.left,
                                text: '..................',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontColor: Color(0xff1A1A1A)),
                            Spacer(),
                            CustomTextField(
                                textAlign: TextAlign.center,
                                text: 'Basic Asset Information',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontColor: Color(0xff1A1A1A)),
                            Spacer(),
                            CustomTextField(
                                textAlign: TextAlign.right,
                                text: '..................',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                fontColor: Color(0xff1A1A1A))
                          ],
                        ),
                      ),
                      _assetNameWidget,
                      App.appSpacer.vHs,
                      _assetCategoryWidget,
                      App.appSpacer.vHs,
                      _locationWidget,
                      App.appSpacer.vHs,
                      _descriptionWidget,
                      App.appSpacer.vHs,
                      _makeWidget,
                      App.appSpacer.vHs,
                      _modelNumberWidget,
                      App.appSpacer.vHs,
                      _serialNumberWidget,

                      App.appSpacer.vHs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      App.appSpacer.vHs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm, 0, App.appSpacer.sm + 2, 0),
                        child: GestureDetector(
                          onTap: () {
                            controller.isPurchaseFinancialDetails.value =
                                !controller.isPurchaseFinancialDetails.value;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: 'Purchase and Financial Details',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Color(0xff1A1A1A)),
                              Image.asset(
                                controller.isPurchaseFinancialDetails.value
                                    ? 'assets/images/ic_arrow_up.png'
                                    : 'assets/images/ic_arrow_down.png',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.isPurchaseFinancialDetails.value) ...[
                        App.appSpacer.vHs,
                        App.appSpacer.vHxxs,
                        _purchaseDateWidget(context),
                        App.appSpacer.vHs,
                        _purchasePriceWidget,
                        App.appSpacer.vHs,
                        _vendorNameWidget,
                        App.appSpacer.vHs,
                        _vendorContactNumberWidget,
                        App.appSpacer.vHs,
                        _vendorEmailWidget,
                        App.appSpacer.vHs,
                        _invoiceNumberWidget,
                        App.appSpacer.vHs,
                        _warrantyDetailsWidget,
                        App.appSpacer.vHs,
                      ],

                      App.appSpacer.vHs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      App.appSpacer.vHs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm, 0, App.appSpacer.sm, 0),
                        child: GestureDetector(
                          onTap: () {
                            controller.isOperationalDetails.value =
                                !controller.isOperationalDetails.value;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: 'Operational Details',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Color(0xff1A1A1A)),
                              Image.asset(
                                controller.isOperationalDetails.value
                                ? 'assets/images/ic_arrow_up.png'
                                    : 'assets/images/ic_arrow_down.png',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.isOperationalDetails.value) ...[
                        App.appSpacer.vHs,
                        App.appSpacer.vHxxs,
                        _operationalStatusWidget,
                        App.appSpacer.vHs,
                        _conditionWidget,
                        App.appSpacer.vHs,
                        _lastUpdatedDateWidget(context),
                        App.appSpacer.vHs,
                        _commentsNotesWidget,
                        App.appSpacer.vHs,
                      ],

                      App.appSpacer.vHs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      App.appSpacer.vHs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm, 0, App.appSpacer.sm, 0),
                        child: GestureDetector(
                          onTap: () {
                            controller.isInsuranceCompliance.value =
                                !controller.isInsuranceCompliance.value;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: 'Insurance and Compliance',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Color(0xff1A1A1A)),
                              Image.asset(
                                controller.isInsuranceCompliance.value
                                    ? 'assets/images/ic_arrow_up.png'
                                    : 'assets/images/ic_arrow_down.png',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.isInsuranceCompliance.value) ...[
                        App.appSpacer.vHs,
                        App.appSpacer.vHxxs,
                        _insuranceProviderWidget,
                        App.appSpacer.vHs,
                        _insurancePolicyNumberWidget,
                        App.appSpacer.vHs,
                        _insuranceExpiryDateWidget(context),
                        App.appSpacer.vHs,
                      ],
                      App.appSpacer.vHs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      // _addButtonWidget
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget _purchaseDateWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Purchase Date',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              onTab: () async {
                await _selectDate(
                    context, controller.purchaseDateController.value);
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  'assets/images/ic_calender.png',
                ),
              ),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Purchase Date',
              controller: controller.purchaseDateController.value,
              focusNode: controller.purchaseDateFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.none),
        ],
      ),
    );
  }

  Widget _insuranceExpiryDateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Insurance Expiry Date',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              onTab: () async {
                await _selectDate(
                    context, controller.insuranceExpiryDateController.value);
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  'assets/images/ic_calender.png',
                ),
              ),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Insurance Expiry Date',
              controller: controller.insuranceExpiryDateController.value,
              focusNode: controller.insuranceExpiryDateFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.none),
        ],
      ),
    );
  }

  Widget get _insuranceProviderWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Insurance Provider',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Insurance Provider',
              controller: controller.insuranceProviderController.value,
              focusNode: controller.insuranceProviderFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _insurancePolicyNumberWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Insurance Policy Number',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Insurance Policy Number',
              controller: controller.insurancePolicyNumberController.value,
              focusNode: controller.insurancePolicyNumberFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _purchasePriceWidget {
    return Padding(
      padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Purchase Price',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Purchase Price',
              controller: controller.purchasePriceController.value,
              focusNode: controller.purchasePriceFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _vendorNameWidget {
    return Padding(
      padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Vendor Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Vendor Name',
              controller: controller.vendorNameController.value,
              focusNode: controller.vendorNameFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _vendorContactNumberWidget {
    return Padding(
      padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Vendor Contact Number',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          PhoneWidget(
            padding: EdgeInsets.zero,
            countryCode: controller.countryCode,
            textEditingController: controller.vendorContactController,
            validating: (value) {
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get _vendorEmailWidget {
    return Padding(
      padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Vendor Email',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Vendor Email',
            controller: controller.vendorEmailController.value,
            focusNode: controller.vendorEmailFocusNode.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            validating: (value) {
              if (value!.isNotEmpty &&
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return 'Enter valid email address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get _invoiceNumberWidget {
    return Padding(
      padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Invoice Number',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Invoice Number',
              controller: controller.invoiceNumberController.value,
              focusNode: controller.invoiceNumberFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _warrantyDetailsWidget {
    return Padding(
      padding: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Warranty Details',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Warranty Details',
              controller: controller.warrantyDetailsController.value,
              focusNode: controller.warrantyDetailsFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController textEditingController) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      textEditingController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Widget get _assetCategoryWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomTextField(
                  required: true,
                  textAlign: TextAlign.left,
                  text: 'Category',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    const AssetCategoryAdd(),
                  );
                },
                child: Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage('assets/images/ic_add_blue.png')),
                    )),
              )
            ],
          ),
          App.appSpacer.vHxs,
          Obx(
            () => MyCustomDropDown<String>(
              itemList: controller.assetCategoryList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem));
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item));
              },
              hintText: 'Select Category',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "   Select asset category";
                }
                return null;
              },
              onChange: (item) {
                // log('changing value to: $item');
                controller.assetCategory.value = item ?? '';
              },
              validateOnChange: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _locationWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Location',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            itemList: controller.assetLocationList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            hintText: 'Select Location',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "   Select location";
              }
              return null;
            },
            onChange: (item) {
              // log('changing value to: $item');
              controller.assetLocation.value = item ?? '';
            },
            validateOnChange: true,
          ),
        ],
      ),
    );
  }

  Widget get _assetNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Asset Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Asset Name',
              controller: controller.assetNameController.value,
              focusNode: controller.assetNameFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter asset name';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _makeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Manufacturer',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Manufacturer',
              controller: controller.manufacturerController.value,
              focusNode: controller.manufacturerFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter manufacturer';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _modelNumberWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Model',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Model number',
              controller: controller.modelNumberController.value,
              focusNode: controller.modelMumberFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter model number';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _serialNumberWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Serial Number',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Serial Number',
              controller: controller.serialNumberController.value,
              focusNode: controller.serialNumberFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter serial number';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _descriptionWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Description',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Description',
              controller: controller.descriptionController.value,
              focusNode: controller.descriptionFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter description';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _operationalStatusWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Operational Status',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            itemList: controller.operationalStatusList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            hintText: 'Operational Status',
            onChange: (item) {
              // log('changing value to: $item');
              controller.operationalStatus.value = item ?? '';
            },
            validateOnChange: true,
          ),
        ],
      ),
    );
  }

  Widget get _conditionWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Condition',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Condition',
              controller: controller.conditionController.value,
              focusNode: controller.conditionFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget _lastUpdatedDateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Last Updated',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              onTab: () async {
                await _selectDate(
                    context, controller.lastUpdatedController.value);
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  'assets/images/ic_calender.png',
                ),
              ),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Last Updated',
              controller: controller.lastUpdatedController.value,
              focusNode: controller.lastUpdatedFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.none),
        ],
      ),
    );
  }

  Widget get _commentsNotesWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Comments/Notes',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Notes',
              controller: controller.commentsNotesController.value,
              focusNode: controller.commentsNotesFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
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
          if (_coldStorageFormKey.currentState!.validate()) {
            controller.submitAddAsset()
          }
        },
        text: 'Asset Creation',
      ),
    );
  }
}
