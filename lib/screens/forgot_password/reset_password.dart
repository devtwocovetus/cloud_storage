import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../view_models/forgot_password/reset_password_view_model.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final ResetPasswordViewModel _resetPasswordViewModel = Get.put(ResetPasswordViewModel());

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
          width: App.appQuery.responsiveWidth(70),
          height: Utils.deviceHeight(context) * 0.06,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Utils.isCheck = true,
            if (_formKey.currentState!.validate())
              {
                _resetPasswordViewModel.submitForEmail()
              }
          },
          text: 'Change Password',
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
                        text: 'Reset Password',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/forgot_password_img.png',
                        fit: BoxFit.cover,
                        height: Utils.deviceHeight(context) * 0.3,
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Utils.deviceWidth(context) * 0.04),
                      child: const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Please enter your verification code.',
                          isMultyline: true,
                          line: 2,
                          fontSize: 17.0,
                          fontColor: kAppBlack,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Utils.deviceWidth(context) * 0.04,
                          vertical: 4
                      ),
                      child: const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'We have sent a verification code to your registered emil ID.',
                          isMultyline: true,
                          line: 3,
                          fontSize: 15.0,
                          fontColor: kAppBlack60,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                    TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'Enter New Password',
                      lebelFontColor: const Color(0xff1A1A1A),
                      obscure: _resetPasswordViewModel.obscured.value,
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Enter New Password',
                      controller: _resetPasswordViewModel.passwordController.value,
                      focusNode: _resetPasswordViewModel.passwordFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text,
                      validating: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                                .hasMatch(value)) {
                          return 'Password must contain 8+ characters with combination\nof uppercase,lowercase, numbers & symbols(@\$!%*?&)';
                        }
                        return null;
                      },
                      suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: _resetPasswordViewModel.toggleObscured,
                            child: Icon(
                              _resetPasswordViewModel.obscured.value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 24,
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.02,
                    ),
                    TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'Re-Enter Your Password',
                      lebelFontColor: const Color(0xff1A1A1A),
                      obscure: _resetPasswordViewModel.obscured.value,
                      borderRadius: BorderRadius.circular(10.0),
                      hint: 'Enter Your Password',
                      controller: _resetPasswordViewModel.conPasswordController.value,
                      focusNode: _resetPasswordViewModel.conPasswordFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text,
                      validating: (value) {
                        if (value!.isEmpty ||
                            value.compareTo(
                                _resetPasswordViewModel.passwordController.value.text) !=
                                0) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            onTap: _resetPasswordViewModel.toggleObscured,
                            child: Icon(
                              _resetPasswordViewModel.obscured.value
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 24,
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                  ],
                )
            ),
          )
      ),
    );
  }
}
