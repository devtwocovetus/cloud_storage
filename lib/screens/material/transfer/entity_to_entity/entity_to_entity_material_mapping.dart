import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/entity_to_entity/entity_to_entity_mapping_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class EntityToEntityMaterialMapping extends StatelessWidget {
  EntityToEntityMaterialMapping({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(EntityToEntityMappingViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();
   late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
     translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: bottomGestureButtons(context),
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
                        if(controller.comeFrom.value == 'Normal'){
  Get.back();
                        }else{
                          Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
                        }
                      
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
                          text:
                              translation.transfer_request,
                          fontSize: 18.0.sp,
                          fontColor: Color(0xFF000000),
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
                      _restWidget(context),
                      SizedBox(height: 12.h,),
                      _binWidget,
                      SizedBox(height: 12.h,),
                      SizedBox(height: 12.h,),
                      materialTile(context),
                      SizedBox(height: 12.h,),
                      SizedBox(height: 12.h,),
                      // _addButtonWidget
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget materialTile(BuildContext context) {
    return Container(
      margin: App.appSpacer.edgeInsets.x.sm,
      padding: EdgeInsets.fromLTRB(
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xffEFF8FF)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.material,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: Utils.textCapitalizationString(
                          controller.materialName.value),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1A1A1A),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.195,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.uom,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: Utils.textCapitalizationString(
                          controller.mouName.value),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1A1A1A),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.195,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.quantity,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: controller.quantity.value.toString(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1A1A1A),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: Utils.deviceWidth(context) * 0.10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ic_list_confirm.png',
                        width: 20.h,
                        height: 20.h,
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(height: 10.h,),
        ],
      ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.entity_from,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            controller.senderEntity.value),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: Image.asset(
                    'assets/images/ic_group_arrow.png',
                    width: 30.h,
                    height: 30.h,
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.entity_to,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            controller.receiverEntity.value),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff1A1A1A),
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

  Widget get _binWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.select_bin,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            itemList: controller.binList,
            hintText: translation.select_bin,
            validateOnChange: true,
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
            onChange: (item) {
              controller.mStrBin.value = item!.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget bottomGestureButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          textColor: kAppBlack,
          backgroundColor: kAppGrey,
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45.h,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
             DialogUtils.showCustomDialog(
               title: translation.send_request,
               okBtnText: translation.proceed_button_text,
               cancelBtnText: translation.cancel_button_text,
                context,
                okBtnFunction: () {
                  Get.back(closeOverlays: true);
                  controller.transferAccept('2');
                },
              )
          },
          text: translation.reject,
        ),
        MyCustomButton(
          backgroundColor: kAppPrimary,
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45.h,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            DialogUtils.showCustomDialog(
              title: translation.send_request,
              okBtnText: translation.proceed_button_text,
              cancelBtnText: translation.cancel_button_text,
              context,
              okBtnFunction: () {
                Get.back(closeOverlays: true);
                controller.transferAccept('1');
              },
            )
           },
          text: translation.accept,
        )
      ],
    );
  }
}
