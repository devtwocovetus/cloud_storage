import 'package:auto_size_text/auto_size_text.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/login/login_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../res/colors/app_color.dart';
import '../view_models/services/app_services.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final loginVM = Get.put(LoginViewModel());
  final _formkey = GlobalKey<FormState>();

  bool checkRememberMe = false;
  bool _obscured = true;
  late i18n.Translations translation;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 32.h,),
                Image.asset(
                  'assets/images/ic_logo_coldstorage.png',
                  fit: BoxFit.cover,
                  width: 380.h,
                  height: 200.h,
                ),
                // App.appSpacer.vHxxl,
                SizedBox(height: 20.h,),
                CustomTextField(
                    textAlign: TextAlign.center,
                    text: translation.welcome_back_message,
                    fontSize: 24.0.sp,
                    fontColor: const Color(0xFF000000),
                    fontWeight: FontWeight.w700),
                 SizedBox(
                  height: Utils.deviceHeight(context) * 0.04,
                ),
               
                TextFormFieldLabel(
                  lebelText: translation.email,
                  lebelFontColor: const Color(0xff1A1A1A),
                   padding: Utils.deviceWidth(context) * 0.04,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: translation.example_email,
                    controller: loginVM.emailController.value,
                    focusNode: loginVM.emailFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return translation.email_validation_error;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny( RegExp(r'\s')),
                  ],
                ),
                SizedBox(height: 10.h,),
                TextFormFieldLabel(
                  lebelText: translation.password_label,
                  lebelFontColor: const Color(0xff1A1A1A),
                  padding: Utils.deviceWidth(context) * 0.04,
                  obscure: _obscured,
                  borderRadius: BorderRadius.circular(10.0),
                  hint: translation.password_hint,
                  controller: loginVM.passwordController.value,
                  focusNode: loginVM.passwordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return translation.password_error;
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
                          size: 24.h,
                        ),
                      )),
                ),
                SizedBox(height: 12.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Utils.deviceWidth(context) * 0.04),
                  // padding: App.appSpacer.edgeInsets.symmetric(x: '',y: ''),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Obx(()=>
                            GestureDetector(
                              onTap: () {
                                loginVM.toggleRememberMe();
                              },
                              child: loginVM.rememberMe.value
                                  ? Image.asset(
                                      'assets/images/ic_checkbox_active.png',
                                      width: 18.h,
                                      height: 18.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/ic_checkbox_inactive.png',
                                      width: 18.h,
                                      height: 18.h,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0.h,
                          ),
                          CustomTextField(
                              text: translation.remember_me,
                              fontSize: 13.0.sp,
                              fontColor: kAppBlack,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.forgotPassword);
                        },
                        child: CustomTextField(
                            text: translation.forgot_password,
                            fontSize: 13.0.sp,
                            fontColor: kAppError,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 56.h,),
                MyCustomButton(
                  width: App.appQuery.responsiveWidth(85) /*312.0*/,
                  height: 48.0.h,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                    Utils.isCheck = true,
                    if (_formkey.currentState!.validate()) {loginVM.loginApi()}
                  },
                  text: translation.login,
                ),
                // App.appSpacer.vHlg,
                SizedBox(height: 40.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AutoSizeText.rich(
                        maxLines: 2,
                        minFontSize: 8,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                            text: translation.new_to_cold_storage,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: const Color(0xff0D0E0E),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0.sp,
                                )),
                            children: [
                              TextSpan(
                                  text: translation.sign_up,
                                  style: TextStyle(
                                    color: const Color(0xff0E64D1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0.sp,
                                  ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Get.offAllNamed(RouteName.signUpView);
                                },
                              )
                            ]),
                      ),
                    ),
                    // CustomTextField(
                    //     text: translation.new_to_cold_storage,
                    //     fontSize: 15.0.sp,
                    //     fontWeight: FontWeight.w600,
                    //     fontColor: const Color(0xff0D0E0E)),
                    // App.appSpacer.vWxxs,
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.offAllNamed(RouteName.signUpView);
                    //   },
                    //   child: CustomTextField(
                    //       text: translation.sign_up,
                    //       fontSize: 15.0.sp,
                    //       fontWeight: FontWeight.w600,
                    //       fontColor: const Color(0xff0E64D1)),
                    // ),
                  ],
                ),
                SizedBox(height: 40.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  toggleDone(bool bool) {}
}
