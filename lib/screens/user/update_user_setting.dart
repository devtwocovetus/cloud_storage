import 'dart:io';

import 'package:cold_storage_flutter/models/user/userrole_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/user/update_user_view_model.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/services/app_services.dart';
import '../phone_widget.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class UpdateUserSetting extends StatelessWidget {
  UpdateUserSetting({super.key});

  final _updateUFormKey = GlobalKey<FormState>();
  final updateUserViewModel = Get.put(UpdateUserViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
          width: App.appQuery.responsiveWidth(70),
          height: Utils.deviceHeight(context) * 0.06,
          padding: Utils.deviceWidth(context) * 0.04,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () async => {
            Utils.isCheck = true,
            if (_updateUFormKey.currentState!.validate())
              {
                updateUserViewModel.updateUser()
                // await createUserViewModel.createUser()
              }
          },
          text: translation.update_user,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
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
                     CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.update_user,
                        fontSize: 18.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    // Padding(
                    //   padding: App.appSpacer.edgeInsets.top.none,
                    //   child: Obx(() => IconButton(
                    //       padding: EdgeInsets.zero,
                    //       onPressed: () {
                    //         // _sliderDrawerKey.currentState!.toggle();
                    //         Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                    //       },
                    //       icon: AppCachedImage(
                    //           roundShape: true,
                    //           height: 20,
                    //           width: 20,
                    //           fit: BoxFit.cover,
                    //           url: UserPreference.profileLogo.value))),
                    // ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _updateUFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22.0.h,
                  ),
                  Center(
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            updateUserViewModel.imageBase64Convert(context);
                          },
                          child: Container(
                            width: 90.0.h,
                            height: 90.0.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: updateUserViewModel
                                          .imageFilePath.value.isNotEmpty
                                      ? FileImage(File(updateUserViewModel
                                          .imageFilePath.value))
                                      : updateUserViewModel
                                              .updatingUser['profile_image']
                                              .toString()
                                              .isNotEmpty
                                          ? NetworkImage(updateUserViewModel
                                              .updatingUser['profile_image']
                                              .toString())
                                          : const AssetImage(
                                              'assets/images/ic_user_defualt.png')),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/images/ic_edit_blue.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       CustomTextField(
                          text: translation.inactive,
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff000000)),
                      SizedBox(
                        width: 5.0.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          updateUserViewModel.isActive.value =
                              !updateUserViewModel.isActive.value;
                        },
                        child: updateUserViewModel.isActive.value
                            ? Image.asset(
                                'assets/images/ic_switch_on.png',
                                width: 34.h,
                                height: 20.h,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/ic_switch_off.png',
                                width: 34.h,
                                height: 20.h,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(
                        width: 5.0.h,
                      ),
                       CustomTextField(
                          text: translation.active,
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff000000))
                    ],
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child:  CustomTextField(
                      required: true,
                      textAlign: TextAlign.left,
                      text:translation.phone_number,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  PhoneWidget(
                    countryCode: updateUserViewModel.countryCode,
                    textEditingController:
                        updateUserViewModel.phoneNumberController,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.email,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: translation.email_address,
                    controller: updateUserViewModel.emailController.value,
                    focusNode: updateUserViewModel.emailFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return translation.enter_valid_email_address;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.first_name,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.first_name,
                      controller: updateUserViewModel.userFirstNameController.value,
                      focusNode: updateUserViewModel.userFirstNameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_first_name;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.last_name,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.last_name,
                      controller: updateUserViewModel.userLastNameController.value,
                      focusNode: updateUserViewModel.userLastNameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_last_name;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  _managerNameWidget,
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  SizedBox(
                    height: 25.0.h,
                  ),
                  SizedBox(
                    height: 60.0.h,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget get _managerNameWidget {
    return Padding(
      padding: EdgeInsets.only(left: App.appQuery.width * 0.04, right: App.appQuery.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.select_user_role,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 8,),
          Obx(
            () => MyCustomDropDown<UserRole>(
              hintFontSize: 14.0.sp,
              initialValue: updateUserViewModel.userRole,
              itemList: updateUserViewModel.userRoleList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem.name!),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),
                );
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item.name!),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),
                );
              },
              hintText: translation.select_user_role,
              validator: (value) {
                if (value == null) {
                  return "   ${translation.select_user_role}";
                }
                return null;
              },
              onChange: (item) {
                updateUserViewModel.userRole = item!;
                updateUserViewModel.userRoleId = item.id ?? 0;
              },
              validateOnChange: true,
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
