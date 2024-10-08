import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class ThankyouSignUp extends StatefulWidget {
  const ThankyouSignUp({super.key});

  @override
  State<ThankyouSignUp> createState() => _ThankyouSignUpState();
}

class _ThankyouSignUpState extends State<ThankyouSignUp> {
  bool isChecked = false;
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  MyCustomButton(
                       width: App.appQuery.responsiveWidth(70),
                        height: 48.0,
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: () => {
                        Get.offAllNamed(RouteName.loginView)
                        },
                        text: translation.login,
                      ),
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/ic_thank_you.png',
                      width: 150.0,
                      height: 96.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 35.0),
                    CustomTextField(
                        text: translation.text_thank_you,
                        fontSize: 22.0,
                        fontColor: const Color(0xFF000000),
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 8.0),
                    CustomTextField(
                        text: translation.sign_up_success,
                        fontSize: 22.0,
                        fontColor: const Color(0xFF000000),
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 215.0),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
