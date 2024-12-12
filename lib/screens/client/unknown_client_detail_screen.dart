import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/view_models/controller/client/unknown_client_detail_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../i10n/strings.g.dart' as i18n;

class UnknownClientDetailScreen extends StatefulWidget {
  const UnknownClientDetailScreen({super.key});

  @override
  State<UnknownClientDetailScreen> createState() => _UnknownClientDetailScreen();
}

class _UnknownClientDetailScreen extends State<UnknownClientDetailScreen>{

  final controller = Get.put(UnknownClientDetailViewModel());
  late i18n.Translations translation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(()=>
        MyCustomButton(
          width: App.appQuery.responsiveWidth(70) /*312.0*/,
          height: 45.h,
          borderRadius: BorderRadius.circular(10.0),
          backgroundColor: controller.canSendRequest.value ? kAppPrimary : kAppPrimary.withOpacity(0.7),
          onPressed: () {
            if(controller.canSendRequest.value){
              // controller.submitAccountForm();
              controller.sendRequestClient();
            }
          },
          text: translation.send_request,
        ),
      ),
      backgroundColor: kAppWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // if (controller.comeFrom.value == 'Normal') {
                      Get.back();
                    // } else {
                    //   Get.offAllNamed(RouteName.homeScreenView,
                    //       arguments: []);
                    // }
                  },
                  icon: Image.asset(
                    height: 15.h,
                    width: 10.h,
                    'assets/images/ic_back_btn.png',
                    fit: BoxFit.cover,
                  )),
              CustomTextField(
                  textAlign: TextAlign.center,
                  text: translation.v_and_c_detail,
                  fontSize: 18.0.sp,
                  fontColor: const Color(0xFF000000),
                  fontWeight: FontWeight.w500),
              const Spacer(),
              Padding(
                padding: App.appSpacer.edgeInsets.top.none,
                child: Obx(
                  () => IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // _sliderDrawerKey.currentState!.toggle();
                    // Get.toNamed(RouteName.profileDashbordSetting)!
                    //     .then((value) {});
                  },
                  icon: AppCachedImage(
                      roundShape: true,
                      height: 20.h,
                      width: 20.h,
                      fit: BoxFit.cover,
                      url: UserPreference.profileLogo.value)
                  ),
                ),
              ),
            ],
          )
        )
      ),
      body: SafeArea(
        child: Obx(()=>
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _accountNameWidget,
                SizedBox(height: 12.h,),
                _selectRoleWidget,
                SizedBox(height: 12.h,),
                _locationNameWidget,
                SizedBox(height: 12.h,),
                _addressNameWidget,
                SizedBox(height: 12.h,),
                _phoneNumberWidget,
                SizedBox(height: 12.h,),
                _emailAddressWidget,
                SizedBox(height: 12.h,),
              ],
            ),
          ),
        )
      ),
    );

  }


  Widget get _accountNameWidget {
    return Padding(
      padding: EdgeInsets.only(left: App.appQuery.width * 0.03, right: App.appQuery.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: translation.account,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.account_name,
              readOnly: true,
              controller: controller.accountNameController.value,
              focusNode: controller.accountNameFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _selectRoleWidget {
    return Padding(
      padding: EdgeInsets.only(left: App.appQuery.width * 0.03, right: App.appQuery.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: translation.select_role_text,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        // if (controller.requestSent.value == 'true' ||
                        //     controller.outgoingRequestAccepted.value ==
                        //         'true' ||
                        //     controller.incomingRequestAccepted.value ==
                        //         'true') {
                          if (controller.isVendor.value == 0) {
                            controller.isVendor.value = 1;
                          } else {
                            controller.isVendor.value = 0;
                          }
                          controller.sendRequestUpdate();
                        // }
                      },
                      child: Obx(
                            () => controller.isVendor.value == 1
                            ? Image.asset(
                          'assets/images/ic_setting_check_on.png',
                          width: 20.h,
                          height: 20.h,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          'assets/images/ic_setting_check_off.png',
                          width: 20.h,
                          height: 20.h,
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    width: 10.h,
                  ),
                  CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.vendor,
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1A1A1A)),
                ],
              ),
              SizedBox(
                width: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        // if (controller.requestSent.value == 'true' ||
                        //     controller.outgoingRequestAccepted.value ==
                        //         'true' ||
                        //     controller.incomingRequestAccepted.value ==
                        //         'true') {
                          if (controller.isCustomer.value == 0) {
                            controller.isCustomer.value = 1;
                          } else {
                            controller.isCustomer.value = 0;
                          }
                          controller.sendRequestUpdate();
                        // }
                      },
                      child: Obx(
                            () => controller.isCustomer.value == 1
                            ? Image.asset(
                          'assets/images/ic_setting_check_on.png',
                          width: 20.h,
                          height: 20.h,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          'assets/images/ic_setting_check_off.png',
                          width: 20.h,
                          height: 20.h,
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    width: 10.h,
                  ),
                  CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.customer,
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1A1A1A)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _locationNameWidget {
    return Padding(
      padding: EdgeInsets.only(left: App.appQuery.width * 0.03, right: App.appQuery.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: translation.location,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.location,
              readOnly: true,
              controller: controller.locationController.value,
              focusNode: controller.locationFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _emailAddressWidget {
    return Padding(
      padding: EdgeInsets.only(left: App.appQuery.width * 0.03, right: App.appQuery.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: translation.email_address,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.email_address,
              readOnly: true,
              controller: controller.emailController.value,
              focusNode: controller.emailFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _phoneNumberWidget {
    return Padding(
      padding: EdgeInsets.only(left: App.appQuery.width * 0.03, right: App.appQuery.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: translation.phone_number,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.phone_number,
              readOnly: true,
              controller: controller.phoneController.value,
              focusNode: controller.phoneFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _addressNameWidget {
    return Padding(
      padding: EdgeInsets.only(left: App.appQuery.width * 0.03, right: App.appQuery.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: translation.address,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              minLines: 2,
              maxLines: 4,
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.address,
              readOnly: true,
              controller: controller.addressController.value,
              focusNode: controller.addressFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }


}