import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/signup/signup_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signupVM = Get.put(SignupViewModel());
  final _formkey = GlobalKey<FormState>();

  bool checkRememberMe = false;
  bool _obscured = true;
  bool _obscuredConfirm = true;
  late i18n.Translations translation;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
  void _toggleConfirmObscured() {
    setState(() {
      _obscuredConfirm = !_obscuredConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    translation = i18n.Translations.of(context);
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
                    text: translation.sign_up,
                  ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
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
                Image.asset(
                  'assets/images/ic_logo_coldstorage.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                Center(
                  child: CustomTextField(
                      text: translation.welcome_message,
                      fontSize: 24.0,
                      fontColor: const Color(0xFF000000),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                    readOnly: signupVM.isOtpSent.value,
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.first_name_label,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: translation.first_name_hint,
                    controller: signupVM.firstNameController.value,
                    focusNode: signupVM.firstNameFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return translation.enter_first_name;
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
                  lebelText: translation.last_name_label,
                  lebelFontColor: const Color(0xff1A1A1A),
                  borderRadius: BorderRadius.circular(10.0),
                  hint: translation.last_name_hint,
                  controller: signupVM.lastNameController.value,
                  focusNode: signupVM.lastNameFocusNode.value,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return translation.enter_last_name;
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
                  child: CustomTextField(
                    required: true,
                    textAlign: TextAlign.left,
                    text: translation.phone,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A),
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
                Obx(()=>
                    TextFormFieldLabel(
                      readOnly: signupVM.isOtpSent.value,
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.enter_your_email,
                      lebelFontColor: const Color(0xff1A1A1A),
                      suffixIcon: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: MyCustomButton(
                          backgroundColor: signupVM.isOtpEn.value == 0
                              ? kAppPrimary
                              : kAppGrey,
                          fontSize: 12,
                          width: 80.0,
                          height: 10.0,
                          borderRadius: BorderRadius.circular(10.0),
                          onPressed: () {
                            if (signupVM.isOtpEn.value == 0) {
                              int code = signupVM.validateForOtp();
                              if (code == 1) {
                                signupVM.sendOtp();
                              } else if (code == 0) {
                                Utils.isCheck = true;
                                Utils.snackBar(translation.validation_error_text,
                                    translation.first_name_last_name_email_required);
                              } else if (code == 2) {
                                Utils.isCheck = true;
                                Utils.snackBar(translation.validation_error_text,
                                    translation.valid_email_error);
                              }
                            }
                          },
                          text: !signupVM.timeLoading.value
                              ? signupVM.isTimerRunning.value ? signupVM.minutesStr.value : translation.send_otp
                          : '···',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      hint: translation.example_email,
                      controller: signupVM.emailController.value,
                      focusNode: signupVM.emailFocusNode.value,
                      validating: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return translation.enter_valid_email_address;
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                    ],),
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.otp_hint,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: translation.otp_hint,
                    controller: signupVM.otpController.value,
                    focusNode: signupVM.otpFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.number,
                     validating: (value) {
                    if (value!.isEmpty || value.length<6) {
                      return translation.otp_validation;
                    }
                    return null;
                  },),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                  padding: Utils.deviceWidth(context) * 0.04,
                  lebelText: translation.password_hint,
                  lebelFontColor: const Color(0xff1A1A1A),
                  obscure: _obscured,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: translation.password_hint,
                  controller: signupVM.passwordController.value,
                  focusNode: signupVM.passwordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                  validating: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                            .hasMatch(value)) {
                      return '${translation.password_validation}(@\$!%*?&)';
                    }
                    return null;
                  },
                  suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          size: 24,
                        ),
                      )),
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                  padding: Utils.deviceWidth(context) * 0.04,
                  lebelText: translation.re_enter_your_password,
                  lebelFontColor: const Color(0xff1A1A1A),
                  obscure: _obscuredConfirm,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: translation.password_hint,
                  controller: signupVM.conpasswordController.value,
                  focusNode: signupVM.conpasswordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                  validating: (value) {
                    if (value!.isEmpty ||
                        value.compareTo(
                                signupVM.passwordController.value.text) !=
                            0) {
                      return translation.passwords_do_not_match;
                    }
                    return null;
                  },
                  suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleConfirmObscured,
                        child: Icon(
                          _obscuredConfirm
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          size: 24,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        text: translation.already_joined,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontColor: const Color(0xff0D0E0E)),
                    const SizedBox(
                      width: 3.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RouteName.loginView);
                      },
                      child: CustomTextField(
                          text: translation.login,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontColor: const Color(0xff0E64D1)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
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
