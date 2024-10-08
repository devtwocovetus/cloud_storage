import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../view_models/setting/profile_update_password_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class ProfileUpdatePassword extends StatelessWidget {
  ProfileUpdatePassword({super.key});

  final _formKey = GlobalKey<FormState>();
  final ProfileUpdatePasswordViewModel _updatePasswordViewModel = Get.put(ProfileUpdatePasswordViewModel());
  late i18n.Translations translation;

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
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Utils.isCheck = true,
            if (_formKey.currentState!.validate())
              {
                _updatePasswordViewModel.submitPasswordForm()
              }
          },
          text: translation.update,
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
                  CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.update_password,
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
                    lebelText: translation.enter_new_password_label,
                    lebelFontColor: const Color(0xff1A1A1A),
                    obscure: _updatePasswordViewModel.obscured.value,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: translation.enter_new_password_hint,
                    controller: _updatePasswordViewModel.passwordController.value,
                    focusNode: _updatePasswordViewModel.passwordFocusNode.value,
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
                    lebelText: translation.reenter_password_label,
                    lebelFontColor: const Color(0xff1A1A1A),
                    obscure: _updatePasswordViewModel.obscuredConfirm.value,
                    borderRadius: BorderRadius.circular(10.0),
                    hint: translation.password_hint,
                    controller: _updatePasswordViewModel.confirmPasswordController.value,
                    focusNode: _updatePasswordViewModel.confirmPasswordFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text,
                    validating: (value) {
                      if (value!.isEmpty ||
                          value.compareTo(
                              _updatePasswordViewModel.passwordController.value.text) !=
                              0) {
                        return translation.passwords_do_not_match;
                      }
                      return null;
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _updatePasswordViewModel.toggleConfirmObscured,
                        child: Icon(
                          _updatePasswordViewModel.obscuredConfirm.value
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
