import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/signup/signup_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reusable_components/reusable_components.dart';

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

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const CustomTextField(
                    text: 'Hi, Welcome To Storage! 👋',
                    fontSize: 24.0,
                    fontColor: Color(0xFF000000),
                    fontWeight: FontWeight.w700),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                   readOnly: signupVM.isOtpSent.value,
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'First Name',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Enter first Name',
                    controller: signupVM.firstNameController.value,
                    focusNode: signupVM.firstNameFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your name';
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
                  hint: 'Enter last Name',
                  controller: signupVM.lastNameController.value,
                  focusNode: signupVM.lastNameFocusNode.value,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return 'Enter last Name';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                IntlPhoneField(
                  flagsButtonPadding: const EdgeInsets.all(8),
                  dropdownIconPosition: IconPosition.trailing,
                  padding: Utils.deviceWidth(context) * 0.04,
                  lebelText: 'Enter Yor Mobile Number',
                  lebelFontColor: const Color(0xff1A1A1A),
                  showCountryFlag: false,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.disabled,
                  validating: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  },
                  dropdownTextStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0)),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0)),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    isDense: true,
                    border: buildOutlineInputBorder(
                        Colors.black.withOpacity(0.4), 1),
                    focusedBorder:
                        buildOutlineInputBorder(const Color(0xff005AFF), 1),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    signupVM.contactNumber.value = phone.completeNumber;
                  },
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                    readOnly: signupVM.isOtpSent.value,
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Enter Your Email',
                    lebelFontColor: const Color(0xff1A1A1A),
                    suffixIcon: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: MyCustomButton(
                        fontSize: 13,
                        width: 80.0,
                        height: 10.0,
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: () {
                          bool isValidate = signupVM.validateForOtp();
                          if (isValidate) {
                            signupVM.sendOtp();
                          } else {
                            Utils.isCheck = true;
                            Utils.snackBar('Validation Error', 'First name, Last name, Email is required');
                          }
                        },
                        text: 'Send OTP',
                      ),
                    ),
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
                    keyboardType: TextInputType.emailAddress),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Enter Your OTP',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Enter Your OTP',
                    controller: signupVM.otpController.value,
                    focusNode: signupVM.otpFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.number),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                  padding: Utils.deviceWidth(context) * 0.04,
                  lebelText: 'Enter Your Password',
                  lebelFontColor: const Color(0xff1A1A1A),
                  obscure: _obscured,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: 'Enter Your Password',
                  controller: signupVM.passwordController.value,
                  focusNode: signupVM.passwordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
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
                  lebelText: 'Re-Enter Your Password',
                  lebelFontColor: const Color(0xff1A1A1A),
                  obscure: _obscured,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: 'Enter Your Password',
                  controller: signupVM.conpasswordController.value,
                  focusNode: signupVM.conpasswordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                  validating: (value) {
                    if (value!.isEmpty ||
                        value.compareTo(
                                signupVM.passwordController.value.text) !=
                            0) {
                      return 'Password does not match';
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
                const SizedBox(
                  height: 30,
                ),
                MyCustomButton(
                  elevation: 20,
                  height: Utils.deviceHeight(context) * 0.06,
                  padding: Utils.deviceWidth(context) * 0.04,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                    Utils.isCheck = true,
                    if (_formkey.currentState!.validate())
                      {signupVM.signUpApi()}
                  },
                  text: 'Sign Up',
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        text: 'Already Joined us?',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontColor: Color(0xff0D0E0E)),
                    const SizedBox(
                      width: 3.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RouteName.loginView);
                      },
                      child: const CustomTextField(
                          text: 'Login',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontColor: Color(0xff0E64D1)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
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

  toggleDone(bool bool) {}
}
