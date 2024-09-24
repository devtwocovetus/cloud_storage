import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../view_models/setting/profile_update_password_view_model.dart';

class ProfileUpdatePassword extends StatelessWidget {
  ProfileUpdatePassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final ProfileUpdatePasswordViewModel _updatePasswordViewModel = Get.put(ProfileUpdatePasswordViewModel());

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
                // signupVM.signUpApi()
              }
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
                    text: 'Update Password',
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
            child: Obx(()=>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.03,
                  ),
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Enter New Password',
                    lebelFontColor: const Color(0xff1A1A1A),
                    obscure: _updatePasswordViewModel.obscured.value,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Enter New Password',
                    controller: _updatePasswordViewModel.passwordController.value,
                    focusNode: _updatePasswordViewModel.passwordFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                              .hasMatch(value)) {
                        return 'Password must contain 8+ characters with combination of uppercase,lowercase, numbers & symbols(@\$!%*?&)';
                      }
                      return null;
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _updatePasswordViewModel.toggleObscured,
                        child: Icon(
                          _updatePasswordViewModel.obscured.value
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
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Re-Enter Your Password',
                    lebelFontColor: const Color(0xff1A1A1A),
                    obscure: _updatePasswordViewModel.obscured.value,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: 'Enter Your Password',
                    controller: _updatePasswordViewModel.confirmPasswordController.value,
                    focusNode: _updatePasswordViewModel.confirmPasswordFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                    validating: (value) {
                      if (value!.isEmpty ||
                          value.compareTo(
                              _updatePasswordViewModel.passwordController.value.text) !=
                              0) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _updatePasswordViewModel.toggleObscured,
                        child: Icon(
                          _updatePasswordViewModel.obscured.value
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
              ),
            )
          ),
        )
      ),
    );
  }
}
