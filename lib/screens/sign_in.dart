import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../res/colors/app_color.dart';
import '../view_models/services/app_services.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final loginVM = Get.put(LoginViewModel());
  final _formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool checkRememberMe = false;
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print('<><> ${screenSize.height}');
    print('<><> ${screenSize.width}');
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                App.appSpacer.vHmd,
                Image.asset(
                  'assets/images/ic_logo_coldstorage.png',
                  fit: BoxFit.cover,
                ),
                // App.appSpacer.vHxxl,
                App.appSpacer.vHsmm,

                const CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Hi, Welcome Back! 👋',
                    fontSize: 24.0,
                    fontColor: Color(0xFF000000),
                    fontWeight: FontWeight.w700),
                 SizedBox(
                  height: Utils.deviceHeight(context) * 0.04,
                ),
               
                TextFormFieldLabel(
                  lebelText: 'Email', 
                  lebelFontColor: const Color(0xff1A1A1A),
                   padding: Utils.deviceWidth(context) * 0.04,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'example@gmail.com',
                    controller: loginVM.emailController.value,
                    focusNode: loginVM.emailFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny( RegExp(r'\s')),
                  ],
                ),
                App.appSpacer.vHxs,
                TextFormFieldLabel(
                  lebelText: 'Password',
                  lebelFontColor: const Color(0xff1A1A1A),
                  padding: Utils.deviceWidth(context) * 0.04,
                  obscure: _obscured,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: 'Enter Your Password',
                  controller: loginVM.passwordController.value,
                  focusNode: loginVM.passwordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
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
                App.appSpacer.vHs,
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Utils.deviceWidth(context) * 0.04),
                  // padding: App.appSpacer.edgeInsets.symmetric(x: '',y: ''),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                checkRememberMe = !checkRememberMe;
                              });
                            },
                            child: checkRememberMe
                                ? Image.asset(
                                    'assets/images/ic_checkbox_active.png',
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/ic_checkbox_inactive.png',
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          const CustomTextField(
                              text: 'Remember Me',
                              fontSize: 13.0,
                              fontColor: kAppBlack,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.forgotPassword);
                        },
                        child: const CustomTextField(
                            text: 'Forgot password',
                            fontSize: 13.0,
                            fontColor: kAppError,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                App.appSpacer.vHxxl,
                MyCustomButton(
                  width: App.appQuery.responsiveWidth(85) /*312.0*/,
                  height: 48.0,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                    Utils.isCheck = true,
                    if (_formkey.currentState!.validate()) {loginVM.loginApi()}
                  },
                  text: 'Login',
                ),
                App.appSpacer.vHlg,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        text: 'New to cold storage?  ',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontColor: Color(0xff0D0E0E)),
                    App.appSpacer.vWxxs,
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RouteName.signUpView);
                      },
                      child: const CustomTextField(
                          text: 'Sign up',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontColor: Color(0xff0E64D1)),
                    ),
                  ],
                ),
                App.appSpacer.vHlg,
              ],
            ),
          ),
        ),
      ),
    );
  }

  toggleDone(bool bool) {}
}
