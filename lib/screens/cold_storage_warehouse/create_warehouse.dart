import 'dart:developer';

import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/res/components/tags_text_field/tag_text_field.dart';
import 'package:cold_storage_flutter/res/components/text_field/range_text_field.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/widgets/bin_creation_form.dart';
import 'package:cold_storage_flutter/screens/user/user_list.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/warehouse/create_warehouse_view_model.dart';

class CreateWarehouse extends StatelessWidget {
  CreateWarehouse({super.key});

  final WareHouseViewModel controller = Get.put(WareHouseViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Add Cold Storage/Warehouse',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    // const Spacer(),
                    // Container(
                    //     width: 50.0,
                    //     height: 50.0,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //           fit: BoxFit.fitWidth,
                    //           image: controller.logoUrl.value.isNotEmpty
                    //               ? NetworkImage(controller.logoUrl.value)
                    //               : const AssetImage(
                    //               'assets/images/ic_user_defualt.png')),
                    //     ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: App.appSpacer.edgeInsets.y.smm,
              child: Form(
                key: _coldStorageFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _storageNameWidget,
                    App.appSpacer.vHs,
                    _emailWidget,
                    App.appSpacer.vHs,
                    _addressWidget,
                    App.appSpacer.vHs,
                    _phoneWidget,
                    App.appSpacer.vHs,
                    ///Profile Picture
                    _profilePictureWidget,
                    App.appSpacer.vHs,
                    _capacityWidget,
                    App.appSpacer.vHs,
                    _temperatureRangeWidget,
                    App.appSpacer.vHs,
                    _humidityRangeWidget,
                    App.appSpacer.vHs,
                    BinCreationForm(
                      width: App.appQuery.width,
                    ),
                    App.appSpacer.vHsmm,
                    _ownerNameWidget,
                    App.appSpacer.vHs,
                    _managerNameWidget,
                    App.appSpacer.vHs,
                    _complianceCertificates,
                    App.appSpacer.vHs,
                    _regulationInformationWidget,
                    App.appSpacer.vHs,
                    _safetyMeasures,
                    App.appSpacer.vHs,
                    _operationHoursWidget,
                    App.appSpacer.vHs,
                    App.appSpacer.vHsmm,
                    _addButtonWidget

                  ],
                ),
              ),
            )
      ),
    );
  }

  // use
  // App.appSpacer.vHxs,
  // _pageHeadingWidget,
  // App.appSpacer.vHs,

  // Widget get _pageHeadingWidget {
  //   return Padding(
  //     padding: App.appSpacer.edgeInsets.x.sm,
  //     child: const CustomTextField(
  //         textAlign: TextAlign.left,
  //         text: 'Add Cold Storage/Warehouse',
  //         fontSize: 20.0,
  //         fontColor: kAppBlack,
  //         fontWeight: FontWeight.w500
  //     ),
  //   );
  // }

  Widget get _storageNameWidget{
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Storage Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            width: App.appQuery.responsiveWidth(100),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Storage Name',
            controller: controller.storageNameC,
            focusNode: FocusNode(),
            validating: (value) {
              if (value!.isEmpty) {
                Utils.snackBar('Storage', 'Enter storage name');
                return 'Enter storage name';
              }
              return null;
            },
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _emailWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Email',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Email Address',
              controller: controller.emailC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Email', 'Enter email address');
                  return 'Enter email address';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress
          ),
        ],
      ),
    );
  }

  Widget get _addressWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Address',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Address',
              controller: controller.addressC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Address', 'Enter address');
                  return 'Enter address';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _phoneWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Phone',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Phone Number',
              controller: controller.phoneC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Phone', 'Enter phone number');
                  return 'Enter phone number';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.phone
          ),
        ],
      ),
    );
  }

  Widget get _profilePictureWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Profile Picture',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: CustomTextFormField(
                  readOnly: true,
                  width: App.appQuery.responsiveWidth(100),
                  height: 25,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                  hint: 'Upload Image',
                  controller: controller.profilePicC,
                  focusNode: FocusNode(),
                  validating: (value) {
                    if (value!.isEmpty) {
                      // Utils.snackBar('Capacity', 'Enter storage capacity');
                      // return '';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text
                ),
              ),
              Expanded(
                flex: 2,
                child: MyCustomButton(
                  splashColor: kWhite_8,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  // width: 87.0,
                  height: 47.0,
                  borderRadius: BorderRadius.circular(8.0),
                  onPressed: () => {/*imageBase64Convert()*/},
                  text: 'Upload',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget get _capacityWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Capacity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Storage Capacity',
              controller: controller.capacityC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Capacity', 'Enter storage capacity');
                  return 'Enter storage capacity';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _temperatureRangeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Temperature Range (\u00B0C)',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Max Temp',
                buttonText: 'Max',
                controller: controller.tempRangeMaxC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                // validating: (value) {
                //   if (value!.isEmpty) {
                //     Utils.snackBar('Temperature', 'Enter temperature');
                //     return '';
                //   }
                //   return null;
                // },
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Temp',
                buttonText: 'Min',
                controller: controller.tempRangeMinC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                // validating: (value) {
                //   if (value!.isEmpty) {
                //     Utils.snackBar('Temperature', 'Enter temperature');
                //     return '';
                //   }
                //   return null;
                // },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _humidityRangeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Humidity Range (%)',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Max Humidity',
                buttonText: 'Max',
                controller: controller.humidityRangeMaxC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Humidity',
                buttonText: 'Min',
                controller: controller.humidityRangeMinC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _ownerNameWidget{
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Owner Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Owner Name',
              readOnly: true,
              controller: controller.ownerNameC,
              focusNode: FocusNode(),
              // validating: (value) {
              //   if (value!.isEmpty) {
              //     Utils.snackBar('Storage', 'Enter storage name');
              //     return '';
              //   }
              //   return null;
              // },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _managerNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm',right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            required: true,
            textAlign: TextAlign.left,
            text: 'Manager Name',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Obx(()=>
            MyCustomDropDown<UsersList>(
              itemList: controller.userList!.value,
              hintText: 'Select Manager',
              validateOnChange: true,
              headerBuilder: (context, selectedItem, enabled) {
                return Text(selectedItem.name!);
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(item.name!);
              },
              validator: (value) {
                if (value == null) {
                  Utils.snackBar('Manager', 'Select a manager');
                  return 'Select a manager';
                }
                return null;
              },
              onChange: (item) {
                controller.managerId = item?.id.toString() ?? '';
                log('changing value to: ${item!.id}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _complianceCertificates{
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm',right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            required: true,
            textAlign: TextAlign.left,
            text: 'Compliance Certificates',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          TagsTextField(
            stringTagController: controller.complianceTagController,
            textFieldTagValues: controller.complianceFieldValues,
            hintText1: 'Add Certificate',
            hintText2: 'Enter tag...',
            onAddButtonTap: () {
              if(controller.complianceFieldValues.value.textEditingController.text.isNotEmpty){
                controller.complianceFieldValues.value.onTagSubmitted(controller.complianceFieldValues.value.textEditingController.text);
                controller.complianceTagsList.value = controller.complianceFieldValues.value.tags;
                print('???????? ${controller.complianceFieldValues.value.tags}');
              }
              // controller.complianceFieldValues.value.onTagSubmitted(controller.complianceFieldValues.value.textEditingController.text);
              // controller.tagsList.value = controller.complianceFieldValues.value.tags;
              // print('???????? 1 ${controller.complianceFieldValues.value.textEditingController.text}');
              // print('???????? 2 ${controller.complianceFieldValues.value.tags}');
              // controller.visibleTagField.value = false;
            },
            tagsList: controller.complianceTagsList,
            tagScrollController: controller.complianceTagScroller,
            visibleTagField: controller.visibleComplianceTagField,
            validating: (value) {
              if (controller.complianceTagsList.isEmpty) {
                Utils.snackBar('Certificates', 'Enter Compliance Certificates');
                return 'Enter Compliance Certificates';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get _regulationInformationWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Regulation Information',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Information',
              controller: controller.regulationInfoC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Regulation', 'Enter Regulation Information');
                  return 'Enter Regulation Information';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _safetyMeasures{
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm',right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Safety Measures',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          TagsTextField(
            stringTagController: controller.safetyMeasureTagController,
            textFieldTagValues: controller.safetyMeasureFieldValues,
            hintText1: 'Add Safety Measures',
            hintText2: 'Enter tag...',
            onAddButtonTap: () {
              if(controller.safetyMeasureFieldValues.value.textEditingController.text.isNotEmpty){
                controller.safetyMeasureFieldValues.value.onTagSubmitted(controller.safetyMeasureFieldValues.value.textEditingController.text);
                controller.safetyMeasureTagsList.value = controller.safetyMeasureFieldValues.value.tags;
                print('???????? ${controller.safetyMeasureFieldValues.value.tags}');
              }
              // controller.complianceFieldValues.value.onTagSubmitted(controller.complianceFieldValues.value.textEditingController.text);
              // controller.tagsList.value = controller.complianceFieldValues.value.tags;
              // print('???????? 1 ${controller.complianceFieldValues.value.textEditingController.text}');
              // print('???????? 2 ${controller.complianceFieldValues.value.tags}');
              // controller.visibleTagField.value = false;
            },
            tagsList: controller.safetyMeasureTagsList,
            tagScrollController: controller.safetyMeasureTagScroller,
            visibleTagField: controller.visibleSafetyMeasureTagField,
            validating: (value) {
              if (controller.complianceTagsList.isEmpty) {
                Utils.snackBar('Measures', 'Enter Safety Measures');
                return 'Enter Safety Measures';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get _operationHoursWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            required: true,
            textAlign: TextAlign.left,
            text: 'Operational Hours',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(40),
                height: App.appQuery.responsiveWidth(10),
                hint: 'hh:mm',
                buttonText: 'AM',
                controller: controller.operationalHourStartC,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.datetime,
                validating: (value) {
                  if (value!.isEmpty) {
                    Utils.snackBar('Hours', 'Enter Operational Hours');
                    return '';
                  }
                  return null;
                },
              ),
              Padding(
                padding: App.appSpacer.edgeInsets.x.xxs,
                child: Text('To',style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: 14.0)),),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(40),
                height: App.appQuery.responsiveWidth(10),
                hint: 'hh:mm',
                buttonText: 'PM',
                controller: controller.operationalHourEndC,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _addButtonWidget {
    return Align(
      alignment: Alignment.center,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70)/*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () => {
          Utils.isCheck = true,
          if(_coldStorageFormKey.currentState!.validate()){
            controller.addColdStorage()
          }
        },
        text: 'Add Entity',
      ),
    );
  }

}


