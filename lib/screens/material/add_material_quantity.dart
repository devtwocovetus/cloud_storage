import 'dart:developer';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/screens/material/widgets/add_specification_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../models/material/quality_type_model.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/tags_text_field/tag_text_field.dart';
import '../../res/variables/var_string.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/material/material_view_model.dart';
import '../../view_models/services/app_services.dart';

class AddMaterialQuantity extends StatelessWidget {
  AddMaterialQuantity({super.key});

  final MaterialViewModel controller = Get.put(MaterialViewModel());

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
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Add Material Quantity',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                        const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                            },
                            icon: Image.asset(
                              height: 20,
                              width: 20,
                              'assets/images/ic_notification_bell.png',
                              fit: BoxFit.cover,
                            )),
                        Obx(
                          () => IconButton(
                              onPressed: () {
                                // _sliderDrawerKey.currentState!.toggle();
                              },
                              icon: AppCachedImage(
                                  roundShape: true,
                                  height: 30,
                                  width: 30,
                                  url: controller.logoUrl.value)),
                        ),
                      ],
                    )
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
            key: controller.addMaterialFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _unitNameWidget,
                App.appSpacer.vHs,
                _qualityTypeWidget,
                App.appSpacer.vHs,
                _measurementOfUnitWidget,
                App.appSpacer.vHsm,
                AddSpecificationCard(
                  width: App.appQuery.width
                ),
                App.appSpacer.vHsm,
                _additionHeadingWidget,
                App.appSpacer.vHsm,
                _storageConditions,
                App.appSpacer.vHs,
                _safetyDataWidget,
                App.appSpacer.vHs,
                _complianceCertificates,
                App.appSpacer.vHs,
                _regulatoryInformationWidget,
                App.appSpacer.vHs,
                App.appSpacer.vHsmm,
                _addButtonWidget
              ],
            )
          ),
        ),
      ),
    );
  }

   Widget get _unitNameWidget{
     return Padding(
       padding: App.appSpacer.edgeInsets.x.sm,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const CustomTextField(
               required: true,
               textAlign: TextAlign.left,
               text: 'Unit Name',
               fontSize: 14.0,
               fontWeight: FontWeight.w500,
               fontColor: Color(0xff1A1A1A)
           ),
           App.appSpacer.vHxxs,
           CustomTextFormField(
               width: App.appQuery.responsiveWidth(100),
               height: 25,
               borderRadius: BorderRadius.circular(10.0),
               hint: 'Enter Name Of Unit',
               controller: controller.unitNameC,
               focusNode: FocusNode(),
               validating: (value) {
                 if (value!.isEmpty) {
                   return 'Enter unit name';
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

   Widget get _qualityTypeWidget {
     return Padding(
       padding: App.appSpacer.edgeInsets.only(left: 'sm',right: 'sm'),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const CustomTextField(
               required: true,
               textAlign: TextAlign.left,
               text: 'Quality type',
               fontSize: 14.0,
               fontWeight: FontWeight.w500,
               fontColor: Color(0xff1A1A1A)
           ),
           App.appSpacer.vHxxs,
           Obx(()=>
             MyCustomDropDown<QualityType>(
               itemList: controller.qualityTypeTypeList!.value,
               hintText: 'Quality Type',
               validateOnChange: true,
               headerBuilder: (context, selectedItem, enabled) {
                 return Text(selectedItem.name!);
               },
               listItemBuilder: (context, item, isSelected, onItemSelect) {
                 return Text(item.name!);
               },
               validator: (value) {
                 if (value == null) {
                   return "   Select a Quality Type";
                 }
                 return null;
               },
               onChange: (item) {
                 controller.quantityTypeId = item?.id.toString() ?? '';
                 log('changing value to: ${controller.quantityTypeId}');
               },
             ),
           ),
         ],
       ),
     );
   }

   Widget get _measurementOfUnitWidget{
     return Padding(
       padding: App.appSpacer.edgeInsets.x.sm,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const CustomTextField(
               required: true,
               textAlign: TextAlign.left,
               text: 'Measurement Of Unit',
               fontSize: 14.0,
               fontWeight: FontWeight.w500,
               fontColor: Color(0xff1A1A1A)
           ),
           App.appSpacer.vHxxs,
           CustomTextFormField(
             readOnly: true,
             backgroundColor: kDisableField,
             width: App.appQuery.responsiveWidth(100),
             height: 25,
             borderRadius: BorderRadius.circular(10.0),
             hint: '10 Pieces',
             controller: controller.measurementOfUnitC,
             focusNode: FocusNode(),
             textCapitalization: TextCapitalization.none,
             keyboardType: TextInputType.text
           ),
         ],
       ),
     );
   }

   Widget get _additionHeadingWidget {
     return Padding(
       padding: App.appSpacer.edgeInsets.x.sm,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         mainAxisSize: MainAxisSize.max,
         children: [
           SVGAssetImage(
             width: App.appQuery.responsiveWidth(20),
             url: horizontalLine,
           ),
           const Expanded(
             child: CustomTextField(
               textAlign: TextAlign.center,
               text: 'Additional Information',
               fontSize: 16.0,
               fontColor: kAppBlackB,
               fontWeight: FontWeight.w500
             ),
           ),
           SVGAssetImage(
             width: App.appQuery.responsiveWidth(20),
             url: horizontalLine,
           ),
         ],
       ),
     );
   }

   Widget get _storageConditions{
     return Padding(
       padding: App.appSpacer.edgeInsets.only(left: 'sm',right: 'sm'),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const CustomTextField(
               textAlign: TextAlign.left,
               text: 'Storage Conditions',
               fontSize: 14.0,
               fontWeight: FontWeight.w500,
               fontColor: Color(0xff1A1A1A)
           ),
           App.appSpacer.vHxxs,
           TagsTextField(
             stringTagController: controller.storageConditionsTagController,
             textFieldTagValues: controller.storageConditionsFieldValues,
             hintText1: 'Add Storage Conditions',
             hintText2: 'Enter tag...',
             onAddButtonTap: () {
               if(controller.storageConditionsFieldValues.value.textEditingController.text.isNotEmpty){
                 controller.storageConditionsFieldValues.value.onTagSubmitted(controller.storageConditionsFieldValues.value.textEditingController.text);
                 controller.storageConditionsTagsList.value = controller.storageConditionsFieldValues.value.tags;
                 if (kDebugMode) {
                   print('???????? ${controller.storageConditionsFieldValues.value.tags}');
                 }
               }
             },
             tagsList: controller.storageConditionsTagsList,
             tagScrollController: controller.storageConditionsTagScroller,
             visibleTagField: controller.visibleStorageConditionsTagField,
           ),
         ],
       ),
     );
   }

   Widget get _safetyDataWidget {
     return Padding(
       padding: App.appSpacer.edgeInsets.x.sm,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const CustomTextField(
               textAlign: TextAlign.left,
               text: 'Safety Data',
               fontSize: 14.0,
               fontWeight: FontWeight.w500,
               fontColor: Color(0xff1A1A1A)
           ),
           App.appSpacer.vHxxs,
           CustomTextFormField(
               minLines: 2,
               maxLines: 3,
               width: App.appQuery.responsiveWidth(100),
               height: 50,
               borderRadius: BorderRadius.circular(10.0),
               hint: 'brief Safety data or handling instructions.',
               controller: controller.safetyDataC,
               focusNode: FocusNode(),
               textCapitalization: TextCapitalization.none,
               keyboardType: TextInputType.text
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
                 if (kDebugMode) {
                   print('???????? ${controller.complianceFieldValues.value.tags}');
                 }
               }
             },
             tagsList: controller.complianceTagsList,
             tagScrollController: controller.complianceTagScroller,
             visibleTagField: controller.visibleComplianceTagField,
           ),
         ],
       ),
     );
   }

   Widget get _regulatoryInformationWidget {
     return Padding(
       padding: App.appSpacer.edgeInsets.x.sm,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const CustomTextField(
               textAlign: TextAlign.left,
               text: 'Regulatory Information',
               fontSize: 14.0,
               fontWeight: FontWeight.w500,
               fontColor: Color(0xff1A1A1A)
           ),
           App.appSpacer.vHxxs,
           CustomTextFormField(
               minLines: 2,
               maxLines: 3,
               width: App.appQuery.responsiveWidth(100),
               height: 50,
               borderRadius: BorderRadius.circular(10.0),
               hint: 'regulatory information or restrictions.',
               controller: controller.regulatoryInformationC,
               focusNode: FocusNode(),
               textCapitalization: TextCapitalization.none,
               keyboardType: TextInputType.text
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
         onPressed: () async {
           Utils.isCheck = true;
           if(controller.addMaterialFormKey.currentState!.validate()){
             await controller.addMaterialUnit();
             // await controller.addColdStorage2()
           }
         },
         text: 'Create',
       ),
     );
   }


}
