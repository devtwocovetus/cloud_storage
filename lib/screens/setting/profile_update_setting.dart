import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/view_models/setting/profile_update_setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';


class ProfileUpdateSetting extends StatefulWidget {
  const ProfileUpdateSetting({super.key});

  @override
  State<ProfileUpdateSetting> createState() => _SignUpState();
}

class _SignUpState extends State<ProfileUpdateSetting> {
  final signupVM = Get.put(ProfileUpdateSettingViewModel());
  final _formkey = GlobalKey<FormState>();

  bool checkRememberMe = false;
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
                    width: App.appQuery.responsiveWidth(70),
                    height: Utils.deviceHeight(context) * 0.06,
                    padding: Utils.deviceWidth(context) * 0.04,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Utils.isCheck = true,
                      if (_formkey.currentState!.validate())
                        {signupVM.signUpApi()}
                    },
                    text: 'Update',
                  ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
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
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Update Profile',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                   
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Obx(() =>  SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                    readOnly: signupVM.isOtpSent.value,
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'First Name',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'First Name',
                    controller: signupVM.firstNameController.value,
                    focusNode: signupVM.firstNameFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter first name';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                  readOnly: signupVM.isOtpSent.value,
                  padding: Utils.deviceWidth(context) * 0.04,
                  lebelText: 'Last Name',
                  lebelFontColor: const Color(0xff1A1A1A),
                  borderRadius: BorderRadius.circular(10.0),
                  hint: 'Last Name',
                  controller: signupVM.lastNameController.value,
                  focusNode: signupVM.lastNameFocusNode.value,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return 'Enter last name';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
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
                  child: const CustomTextField(
                    required: true,
                    textAlign: TextAlign.left,
                    text: 'Phone Number',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A),
                  ),
                ),
                SizedBox(
                  height: Utils.deviceWidth(context) * 0.02,
                ),
                PhoneWidget(
                  countryCode: signupVM.countryCode,
                  textEditingController: signupVM.phoneNumberController,
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                    backgroundColor: kBinCardBackground,
                    readOnly: true,
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Enter Your Email',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'example@gmail.com',
                    controller: signupVM.emailController.value,
                    focusNode: signupVM.emailFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter valid email address';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny( RegExp(r'\s')),
                  ],),
                
                // MyCustomButton(
                //   height: Utils.deviceHeight(context) * 0.06,
                //   padding: Utils.deviceWidth(context) * 0.04,
                //   borderRadius: BorderRadius.circular(10.0),
                //   onPressed: () => {
                //     Utils.isCheck = true,
                //     if (_formkey.currentState!.validate())
                //       {signupVM.signUpApi()}
                //   },
                //   text: 'Sign Up',
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
            
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
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

  toggleDone(bool bool) {}
}
