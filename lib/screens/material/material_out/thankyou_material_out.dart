import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

class ThankyouMaterialOut extends StatefulWidget {
  const ThankyouMaterialOut({super.key});

  @override
  State<ThankyouMaterialOut> createState() => _ThankyouMaterialOutState();
}

class _ThankyouMaterialOutState extends State<ThankyouMaterialOut> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  MyCustomButton(
                       width: App.appQuery.responsiveWidth(70),
                        height: 48.0,
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: () => {
                         Get.until((route) => Get.currentRoute == RouteName.entityDashboard)
                        },
                        text: 'Dashboard',
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ic_thank_you.png',
                        width: 150.0,
                        height: 96.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 35.0),
                      const CustomTextField(
                          text: 'Thank You !',
                          fontSize: 22.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w600),
                      const SizedBox(height: 8.0),
                      const CustomTextField(
                          text: 'Material is in Transit',
                          fontSize: 22.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w600),
                      const SizedBox(height: 215.0),
                    
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
