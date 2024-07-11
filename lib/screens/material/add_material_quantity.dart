import 'dart:developer';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/material/material_view_model.dart';
import '../../view_models/services/app_services.dart';

class AddMaterialQuantity extends StatelessWidget {
   AddMaterialQuantity({super.key});

  final MaterialViewModel controller = Get.put(MaterialViewModel());
   final _addMaterialFormKey = GlobalKey<FormState>();

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
            child:  Padding(
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
                    fontWeight: FontWeight.w500
                  ),
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
                          )
                      ),
                      Obx(()=>
                        IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: AppCachedImage(
                            roundShape: true,
                            height: 30,
                            width: 30,
                            url: controller.logoUrl.value
                          )
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: App.appSpacer.edgeInsets.y.smm,
          child: Form(
            key: _addMaterialFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _unitNameWidget,
                App.appSpacer.vHs,
                _qualityTypeWidget,
                App.appSpacer.vHs,
                _measurementOfUnitWidget
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
               controller: controller.storageNameC,
               focusNode: FocusNode(),
               validating: (value) {
                 if (value!.isEmpty) {
                   Utils.snackBar('Unit', 'Enter unit name');
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
           // Obx(()=>
             MyCustomDropDown<String>(
               itemList: ['controller','userList','value'],
               hintText: 'Quality Type',
               validateOnChange: true,
               headerBuilder: (context, selectedItem, enabled) {
                 return Text(selectedItem);
               },
               listItemBuilder: (context, item, isSelected, onItemSelect) {
                 return Text(item);
               },
               validator: (value) {
                 if (value == null) {
                   Utils.snackBar('Quality Type', 'Select a Quality Type');
                   return "   Select a Quality Type";
                 }
                 return null;
               },
               onChange: (item) {
                 // controller.managerId = item?.id.toString() ?? '';
                 log('changing value to: ${item!}');
               },
             ),
           // ),
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
               text: 'Unit Name',
               fontSize: 14.0,
               fontWeight: FontWeight.w500,
               fontColor: Color(0xff1A1A1A)
           ),
           App.appSpacer.vHxxs,
           CustomTextFormField(
             readOnly: true,
             backgroundColor: kAppGreyC,
             width: App.appQuery.responsiveWidth(100),
             height: 25,
             borderRadius: BorderRadius.circular(10.0),
             hint: 'Enter Name Of Unit',
             controller: controller.storageNameC,
             focusNode: FocusNode(),
             textCapitalization: TextCapitalization.none,
             keyboardType: TextInputType.text
           ),
         ],
       ),
     );
   }
}
