import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class ThankyouMaterialInClient extends StatefulWidget {
  const ThankyouMaterialInClient({super.key});

  @override
  State<ThankyouMaterialInClient> createState() =>
      _ThankyouMaterialInClientState();
}

class _ThankyouMaterialInClientState extends State<ThankyouMaterialInClient> {
  bool isChecked = false;
  String comeFrom = '';
  dynamic argumentData = Get.arguments;
    late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }
  @override
  void initState() {
    if (argumentData != null) {
      comeFrom = argumentData[0]['from'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyCustomButton(
        width: App.appQuery.responsiveWidth(70),
        height: 48.0.h,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () => {
          if (comeFrom == 'Normal')
            {
              Get.until(
                  (route) => Get.currentRoute == RouteName.clientListScreen)
            }
          else
            {Get.offAllNamed(RouteName.homeScreenView, arguments: [])}
        },
        text: translation.dashboard,
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
                      width: 150.0.h,
                      height: 96.0.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 35.0.h),
                     CustomTextField(
                        text: translation.thank_you,
                        fontSize: 22.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w600),
                    SizedBox(height: 8.0.h),
                     CustomTextField(
                        text: translation.material_in_successfully,
                        fontSize: 22.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w600),
                    SizedBox(height: 215.0.h),
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
