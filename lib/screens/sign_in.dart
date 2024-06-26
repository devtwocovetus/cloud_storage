import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 48.0,
                ),
                Image.asset(
                  'assets/images/ic_logo_coldstorage.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 51.0,
                ),
                const CustomTextField(
                    text: 'Hi, Welcome Back! 👋',
                    fontSize: 24.0,
                    fontColor: Color(0xFF000000),
                    fontWeight: FontWeight.w700),
                const SizedBox(
                  height: 51.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Email',
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
                    controller: loginVM.emailController.value,
                    focusNode: loginVM.emailFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        Utils.snackBar('Email', 'Enter valid email address');
                        return '';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 24,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Password',
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
                  controller: loginVM.passwordController.value,
                  focusNode: loginVM.passwordFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  validating: (value) {
                    if (value!.isEmpty) {
                      Utils.snackBar('Password', 'Enter password');
                      return '';
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
                const SizedBox(
                  height: 11.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                              fontColor: Color(0xFF000C14),
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                      const Spacer(),
                      const CustomTextField(
                          text: 'Forgot password',
                          fontSize: 13.0,
                          fontColor: Color(0xFFE86969),
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                MyCustomButton(
                  width: 312.0,
                  height: 48.0,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                    Utils.isCheck = true,
                    if (_formkey.currentState!.validate()) {loginVM.loginApi()}
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 48.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        text: 'New to cold storage?  ',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontColor: Color(0xff0D0E0E)),
                    const SizedBox(
                      width: 3.0,
                    ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  toggleDone(bool bool) {}
}
