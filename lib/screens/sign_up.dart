import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/signup/signup_view_model.dart';
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
                const SizedBox(
                  height: 38.0,
                ),
                Image.asset(
                  'assets/images/ic_logo_coldstorage.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const CustomTextField(
                    text: 'Hi, Welcome To Storage! 👋',
                    fontSize: 24.0,
                    fontColor: Color(0xFF000000),
                    fontWeight: FontWeight.w700),
                     const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Name',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                CustomTextFormField(
                    width: 350.0,
                    height: 48.0,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Enter your name',
                    controller: signupVM.nameController.value,
                    focusNode: signupVM.nameFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty) {
                        Utils.snackBar('Name', 'Enter your name');
                        return '';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 15.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Enter Yor Mobile Number',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                SizedBox(
                  width: 350.0,
                  height: 67.0,
                  child: IntlPhoneField(
                    showCountryFlag: true,
                    autofocus: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    validating: (value) {
                      if (value!.isEmpty || value.length < 10) {
                        Utils.snackBar('Phone', 'Enter valid phone number');
                        return '';
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
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Enter Your Email',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                CustomTextFormField(
                    width: 350.0,
                    height: 48.0,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'example@gmail.com',
                    controller: signupVM.emailController.value,
                    focusNode: signupVM.emailFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        Utils.snackBar('Email', 'Enter valid email address');
                        return '';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Enter Your Password',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                CustomTextFormField(
                  width: 350.0,
                  height: 48.0,
                  obscure: _obscured,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: 'Enter Your Password',
                  controller: signupVM.passwordController.value,
                  focusNode: signupVM.passwordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                   validating: (value) {
                    if (value!.isEmpty) {
                      Utils.snackBar('Password', 'Enter password');
                      return '';
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
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Re-Enter Your Password',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                CustomTextFormField(
                  width: 350.0,
                  height: 48.0,
                  obscure: _obscured,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: 'Enter Your Password',
                  controller: signupVM.conpasswordController.value,
                  focusNode: signupVM.conpasswordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
                   validating: (value) {
                    if (value!.isEmpty || value.compareTo(signupVM.passwordController.value.text)!=0) {
                      Utils.snackBar('Confirm Password', 'Password does not match');
                      return '';
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
                  width: 350.0,
                  height: 48.0,
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
