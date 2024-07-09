import 'dart:developer';

import 'package:cold_storage_flutter/res/components/tags_text_field/tag_text_field.dart';
import 'package:cold_storage_flutter/view_models/controller/farmhouse/farmhouse_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../models/home/user_list_model.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../utils/utils.dart';
import '../phone_widget.dart';


class CreateFarmhouseGrover extends StatelessWidget {

  CreateFarmhouseGrover({super.key});
  final _farmHouseFormKey = GlobalKey<FormState>();
  final FarmhouseViewModel controller = Get.put(FarmhouseViewModel());

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
                      GestureDetector(
                      onTap: () => {Get.back()},
                      child: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Add Farm/Grower',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: controller.logoUrl.value.isNotEmpty
                                  ? NetworkImage(controller.logoUrl.value)
                                  : const AssetImage(
                                  'assets/images/ic_user_defualt.png')),
                        ))
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
              key: _farmHouseFormKey,
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
                  _farmSizeWidget,
                  App.appSpacer.vHs,
                  _typeOfFarmingWidget,
                  App.appSpacer.vHs,
                  _ownerNameWidget,
                  App.appSpacer.vHs,
                  _managerNameWidget,
                  App.appSpacer.vHs,
                  _farmingMethodWidget,
                  App.appSpacer.vHs,
                  _irrigationSystemWidget,
                  App.appSpacer.vHs,
                  _typeOfSoil,
                  App.appSpacer.vHs,
                  _complianceCertificates,
                  App.appSpacer.vHs,
                  _storageFacility,
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

  // Widget get _pageHeadingWidget {
  //   return Padding(
  //     padding: App.appSpacer.edgeInsets.x.sm,
  //     child: const CustomTextField(
  //         textAlign: TextAlign.left,
  //         text: 'Add Farm/Grower',
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
              text: 'Farm Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Farm Name',
              controller: controller.farmNameC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Farm', 'Enter Farm name');
                  return 'Enter Farm name';
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
          PhoneWidget(
            countryCode: controller.countryCode,
            textEditingController: controller.phoneC,
            padding: EdgeInsets.zero,
            borderColor: Colors.black.withOpacity(0.4),
          ),
          // CustomTextFormField(
          //     width: App.appQuery.responsiveWidth(100),
          //     height: 25,
          //     borderRadius: BorderRadius.circular(10.0),
          //     hint: 'Phone Number',
          //     controller: controller.phoneC,
          //     focusNode: FocusNode(),
          //     validating: (value) {
          //       if (value!.isEmpty) {
          //         Utils.snackBar('Phone', 'Enter phone number');
          //         return 'Enter phone number';
          //       }
          //       return null;
          //     },
          //     textCapitalization: TextCapitalization.none,
          //     keyboardType: TextInputType.phone
          // ),
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

  Widget get _farmSizeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Farm Size (Acres or Hectares)',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Farm Size',
              controller: controller.farmSizeC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Size', 'Enter farm size');
                  return 'Enter farm size';
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

  Widget get _typeOfFarmingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Type Of Farming',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Farming Type',
              controller: controller.typeOfFarmingC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Type', 'Enter farming type');
                  return 'Enter farming type';
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
                controller.managerNameC = item?.id.toString() ?? '';
                log('changing value to: ${item!.id}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _farmingMethodWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Farming Method',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Farming Method',
              controller: controller.farmingMethodC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Method', 'Enter farming method');
                  return 'Enter farming method';
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

  Widget get _irrigationSystemWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Irrigation System',
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
              hint: 'Details Od Irrigation System Used',
              controller: controller.irrigationSystemC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Irrigation', 'Enter Irrigation System');
                  return 'Enter Irrigation System';
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

  Widget get _typeOfSoil{
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm',right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Type Of Soil',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          TagsTextField(
            stringTagController: controller.soilTagController,
            textFieldTagValues: controller.soilFieldValues,
            hintText1: 'Add Soil Type',
            hintText2: 'Enter tag...',
            onAddButtonTap: () {
              if(controller.soilFieldValues.value.textEditingController.text.isNotEmpty){
                controller.soilFieldValues.value.onTagSubmitted(controller.soilFieldValues.value.textEditingController.text);
                controller.soilTagsList.value = controller.soilFieldValues.value.tags;
                print('???????? ${controller.soilFieldValues.value.tags}');
              }
              // controller.complianceFieldValues.value.onTagSubmitted(controller.complianceFieldValues.value.textEditingController.text);
              // controller.tagsList.value = controller.complianceFieldValues.value.tags;
              // print('???????? 1 ${controller.complianceFieldValues.value.textEditingController.text}');
              // print('???????? 2 ${controller.complianceFieldValues.value.tags}');
              // controller.visibleTagField.value = false;
            },
            tagsList: controller.soilTagsList,
            tagScrollController: controller.soilTagScroller,
            visibleTagField: controller.visibleSoilTagField,
            validating: (value) {
              if (controller.soilTagsList.isEmpty) {
                Utils.snackBar('Soil', 'Enter Type of Soil');
                return 'Enter Type of Soil';
              }
              return null;
            },
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

  Widget get _storageFacility{
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm',right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Storage Facilities',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          TagsTextField(
            stringTagController: controller.storageFacilityTagController,
            textFieldTagValues: controller.storageFacilityFieldValues,
            hintText1: 'Add Storage Facility',
            hintText2: 'Enter tag...',
            onAddButtonTap: () {
              if(controller.storageFacilityFieldValues.value.textEditingController.text.isNotEmpty){
                controller.storageFacilityFieldValues.value.onTagSubmitted(controller.storageFacilityFieldValues.value.textEditingController.text);
                controller.storageFacilityTagsList.value = controller.storageFacilityFieldValues.value.tags;
                print('???????? ${controller.storageFacilityFieldValues.value.tags}');
              }
              // controller.complianceFieldValues.value.onTagSubmitted(controller.complianceFieldValues.value.textEditingController.text);
              // controller.tagsList.value = controller.complianceFieldValues.value.tags;
              // print('???????? 1 ${controller.complianceFieldValues.value.textEditingController.text}');
              // print('???????? 2 ${controller.complianceFieldValues.value.tags}');
              // controller.visibleTagField.value = false;
            },
            tagsList: controller.storageFacilityTagsList,
            tagScrollController: controller.storageFacilityTagScroller,
            visibleTagField: controller.visibleStorageFacilityTagField,
            validating: (value) {
              if (controller.complianceTagsList.isEmpty) {
                Utils.snackBar('Storage', 'Enter Storage Facility');
                return 'Enter Storage Facility';
              }
              return null;
            },
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
        onPressed: () async => {
          Utils.isCheck = true,
          if(_farmHouseFormKey.currentState!.validate()){
            await controller.addFarmhouse()
          }
        },
        text: 'Add Entity',
      ),
    );
  }

}