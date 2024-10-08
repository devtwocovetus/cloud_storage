import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../res/colors/app_color.dart';
import '../view_models/controller/login/first_login_password_update_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class ChangePasswordOnFirstLogin extends StatelessWidget {
   ChangePasswordOnFirstLogin({super.key});

  final _passwordFormKey = GlobalKey<FormState>();
  final FirstLoginPasswordUpdateViewModel _passwordUpdateViewModel = Get.put(FirstLoginPasswordUpdateViewModel());
   late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: MyCustomButton(
                width: App.appQuery.responsiveWidth(70),
                height: Utils.deviceHeight(context) * 0.06,
                padding: App.appSpacer.s,
                borderRadius: BorderRadius.circular(10.0),
                onPressed: () => {
                  Utils.isCheck = true,
                  _passwordUpdateViewModel.logout()
                },
                text: translation.logout,
              ),
            ),
            Expanded(
              flex: 1,
              child: MyCustomButton(
                width: App.appQuery.responsiveWidth(70),
                height: Utils.deviceHeight(context) * 0.06,
                padding: App.appSpacer.s,
                borderRadius: BorderRadius.circular(10.0),
                onPressed: () => {
                  Utils.isCheck = true,
                  if (_passwordFormKey.currentState!.validate())
                    {
                      _passwordUpdateViewModel.submitPassword()
                    }
                },
                text: translation.create_password_button,
              ),
            ),
          ],
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
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     Get.back();
                    //   },
                    //   padding: EdgeInsets.zero,
                    //   icon: Image.asset(
                    //     height: 15,
                    //     width: 10,
                    //     'assets/images/ic_back_btn.png',
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.create_password,
                        fontSize: 18.0,
                        fontColor: const Color(0xFF000000),
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
            child: Obx(()=>
              Form(
                  key: _passwordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Utils.deviceWidth(context) * 0.04),
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: translation.please_enter_new_password,
                            isMultyline: true,
                            line: 2,
                            fontSize: 17.0,
                            fontColor: kAppBlack,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.03,
                      ),
                      TextFormFieldLabel(
                        padding: Utils.deviceWidth(context) * 0.04,
                        lebelText: translation.enter_new_password_label,
                        lebelFontColor: const Color(0xff1A1A1A),
                        obscure: _passwordUpdateViewModel.obscured.value,
                        borderRadius: BorderRadius.circular(10.0),
                        hint: translation.enter_new_password_hint,
                        controller: _passwordUpdateViewModel.passwordController.value,
                        focusNode: _passwordUpdateViewModel.passwordFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                        validating: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                                  .hasMatch(value)) {
                            return '${translation.password_validation_error}(@\$!%*?&)';
                          }
                          return null;
                        },
                        suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _passwordUpdateViewModel.toggleObscured,
                              child: Icon(
                                _passwordUpdateViewModel.obscured.value
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
                        lebelText: translation.reenter_password_label,
                        lebelFontColor: const Color(0xff1A1A1A),
                        obscure: _passwordUpdateViewModel.obscuredConfirm.value,
                        borderRadius: BorderRadius.circular(10.0),
                        hint: translation.reenter_password_label,
                        controller: _passwordUpdateViewModel.confirmPasswordController.value,
                        focusNode: _passwordUpdateViewModel.confirmPasswordFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text,
                        validating: (value) {
                          if (value!.isEmpty ||
                              value.compareTo(
                                  _passwordUpdateViewModel.passwordController.value.text) !=
                                  0) {
                            return translation.passwords_do_not_match;
                          }
                          return null;
                        },
                        suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _passwordUpdateViewModel.toggleConfirmObscured,
                              child: Icon(
                                _passwordUpdateViewModel.obscuredConfirm.value
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
            ),
          )
      ),
    );
  }
}
