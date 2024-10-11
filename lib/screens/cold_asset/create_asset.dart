import 'package:cold_storage_flutter/screens/cold_asset/asset_category_add.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/cold_asset_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class CreateAsset extends StatelessWidget {
  CreateAsset({super.key});

  final ColdAssetViewModel controller = Get.put(ColdAssetViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Visibility(visible: !showFab, child: _addButtonWidget),
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
                          text: translation.asset_creation,
                          fontSize: 18.0.sp,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!
                                .then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20.h,
                              width: 20.h,
                              url: UserPreference.profileLogo.value)),
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
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                                textAlign: TextAlign.left,
                                text: '..................',
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: const Color(0xff1A1A1A)),
                            const Spacer(),
                            CustomTextField(
                                textAlign: TextAlign.center,
                                text: translation.basic_asset_information,
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: const Color(0xff1A1A1A)),
                            const Spacer(),
                            CustomTextField(
                                textAlign: TextAlign.right,
                                text: '..................',
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: const Color(0xff1A1A1A))
                          ],
                        ),
                      ),
                      _assetNameWidget,
                      SizedBox(height: 12.h,),
                      _assetCategoryWidget,
                      SizedBox(height: 12.h,),
                      _locationWidget,
                      SizedBox(height: 12.h,),
                      _descriptionWidget,
                      SizedBox(height: 12.h,),
                      _makeWidget,
                      SizedBox(height: 12.h,),
                      _modelNumberWidget,
                      SizedBox(height: 12.h,),
                      _serialNumberWidget,

                      SizedBox(height: 12.h,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      InkWell(
                        onTap: () {
                          controller.isPurchaseFinancialDetails.value =
                              !controller.isPurchaseFinancialDetails.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              App.appSpacer.sm,
                              App.appSpacer.xs,
                              App.appSpacer.sm + 2,
                              App.appSpacer.xs),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: translation.purchase_and_financial_details,
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  fontColor: const Color(0xff1A1A1A)),
                              Image.asset(
                                height: 11.h,
                                width: 19.h,
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
                        SizedBox(height: 8.h,),
                        _purchaseDateWidget(context),
                        SizedBox(height: 12.h,),
                        _purchasePriceWidget,
                        SizedBox(height: 12.h,),
                        _vendorNameWidget,
                        SizedBox(height: 12.h,),
                        _vendorContactNumberWidget,
                        SizedBox(height: 12.h,),
                        _vendorEmailWidget,
                        SizedBox(height: 12.h,),
                        _invoiceNumberWidget,
                        SizedBox(height: 12.h,),
                        _warrantyDetailsWidget,
                        SizedBox(height: 12.h,),
                      ],

                      SizedBox(height: 4.h,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      InkWell(
                        onTap: () {
                          controller.isOperationalDetails.value =
                              !controller.isOperationalDetails.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              App.appSpacer.sm,
                              App.appSpacer.xs,
                              App.appSpacer.sm,
                              App.appSpacer.xs),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: translation.operational_details,
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  fontColor: const Color(0xff1A1A1A)),
                              Image.asset(
                                height: 11.h,
                                width: 19.h,
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
                        SizedBox(height: 8.h,),
                        _operationalStatusWidget,
                        SizedBox(height: 12.h,),
                        _conditionWidget,
                        SizedBox(height: 12.h,),
                        _lastUpdatedDateWidget(context),
                        SizedBox(height: 12.h,),
                        _commentsNotesWidget,
                        SizedBox(height: 12.h,),
                      ],

                      SizedBox(height: 4.h,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      InkWell(
                        onTap: () {
                          controller.isInsuranceCompliance.value =
                              !controller.isInsuranceCompliance.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              App.appSpacer.sm,
                              App.appSpacer.xs,
                              App.appSpacer.sm,
                              App.appSpacer.xs),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: translation.insurance_and_compliance,
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  fontColor: const Color(0xff1A1A1A)),
                              Image.asset(
                                height: 11.h,
                                width: 19.h,
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
                        SizedBox(height: 8.h,),
                        _insuranceProviderWidget,
                        SizedBox(height: 12.h,),
                        _insurancePolicyNumberWidget,
                        SizedBox(height: 12.h,),
                        _insuranceExpiryDateWidget(context),
                        SizedBox(height: 12.h,),
                      ],
                      SizedBox(height: 4.h,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            App.appSpacer.sm + 2, 0, App.appSpacer.sm + 2, 0),
                        child: const Divider(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      SizedBox(height: 72.h,),
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.purchase_date,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              readOnly: true,
              onTab: () async {
                await _selectDate(
                    context, controller.purchaseDateController.value);
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.insurance_expiry_date,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              onTab: () async {
                await _selectDate(
                    context, controller.insuranceExpiryDateController.value);
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.insurance_provider,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.insurance_provider,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.insurance_policy_number,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.insurance_policy_number,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.purchase_date,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.purchase_date,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.vendor_name,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.vendor_name,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.vendor_contact_number,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          PhoneWidget(
            padding: EdgeInsets.zero,
            countryCode: controller.countryCode,
            textEditingController: controller.vendorContactController,
            validating: (value) {
              if (value != null) {
                if (value.isNotEmpty && value.length < 10) {
                  return translation.valid_phone_number_error;
                }
              }
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.vendor_email,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.vendor_email,
            controller: controller.vendorEmailController.value,
            focusNode: controller.vendorEmailFocusNode.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            validating: (value) {
              if (value!.isNotEmpty &&
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return translation.enter_valid_email_address;
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.invoice_number,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.invoice_number,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.warranty_details,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.warranty_details,
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
        locale: Locale(i18n.LocaleSettings.currentLocale.languageCode),
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
               CustomTextField(
                  required: true,
                  textAlign: TextAlign.left,
                  text:translation.category,
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: const Color(0xff1A1A1A)),
              if (Utils.decodedMap['add_asset_category'] == true) ...[
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      const AssetCategoryAdd(
                        incomingStatus: 0,
                      ),
                    );
                  },
                  child: Container(
                      width: 25.0.h,
                      height: 25.0.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage('assets/images/ic_add_blue.png')),
                      )),
                )
              ]
            ],
          ),
          SizedBox(height: 8.h,),
          Obx(
            () => MyCustomDropDown<String>(
              hintFontSize: 14.0.sp,
              itemList: controller.assetCategoryList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),);
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),
                );
              },
              hintText: translation.select_category,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translation.select_asset_category_error_text;
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.location,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 8.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            itemList: controller.assetLocationList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            hintText: translation.select_location,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "   ${translation.select_location}";
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.asset_name,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.asset_name,
              controller: controller.assetNameController.value,
              focusNode: controller.assetNameFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_asset_name__error_text;
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.manufacturer,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.manufacturer,
              controller: controller.manufacturerController.value,
              focusNode: controller.manufacturerFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_manufacturer_error_text;
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.model,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.model_number_hint,
              controller: controller.modelNumberController.value,
              focusNode: controller.modelMumberFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_model_number_error_text;
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.serial_number,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.serial_number,
              controller: controller.serialNumberController.value,
              focusNode: controller.serialNumberFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_serial_number_error_text;
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.description,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.description,
              controller: controller.descriptionController.value,
              focusNode: controller.descriptionFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_description;
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.operational_status,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            itemList: controller.operationalStatusList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            hintText: translation.operational_status,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.condition,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.condition,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.last_updated,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              onTab: () async {
                await _selectDate(
                    context, controller.lastUpdatedController.value);
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.comments_notes,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.comments_notes,
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
        height: 45.h,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          if (_coldStorageFormKey.currentState!.validate())
            {controller.submitAddAsset()}
        },
        text: translation.asset_creation,
      ),
    );
  }
}
