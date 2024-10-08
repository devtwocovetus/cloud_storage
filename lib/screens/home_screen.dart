import 'package:cold_storage_flutter/res/components/divider/basic_divider.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../res/components/image_view/network_image_view.dart';
import '../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../view_models/services/app_services.dart';
import '../../i10n/strings.g.dart' as i18n;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeViewModel = Get.put(HomeViewModel());
  late i18n.Translations translation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04,
                    0, Utils.deviceWidth(context) * 0.02, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.home,
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    if (Utils.decodedMap['account_setting'] == true) ...{
                      Padding(
                        padding: App.appSpacer.edgeInsets.top.none,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Get.toNamed(RouteName.settingDashboard);
                            },
                            icon: Image.asset(
                              height: 20,
                              width: 20,
                              'assets/images/ic_setting.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                    },
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            //
                            Get.toNamed(RouteName.notificationList)!
                                .then((value) {});
                          },
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(
                        () => IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                              //
                              Get.toNamed(RouteName.profileDashbordSetting)!
                                  .then((value) {});
                            },
                            icon: AppCachedImage(
                                roundShape: true,
                                height: 20,
                                width: 20,
                                url: UserPreference.profileLogo.value)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (Utils.decodedMap['view_entity'] == true) ...[
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0,
                  Utils.deviceWidth(context) * 0.04, 0),
              child: GestureDetector(
                onTap: () {
                  {
                    Get.toNamed(RouteName.entityListScreen, arguments: [
                      {"EOB": 'OLD',"from": 'Normal'}
                    ])!
                        .then((value) {});
                  }
                },
                child: Container(
                  height: Utils.deviceHeight(context) * 0.2,
                  width: Utils.deviceWidth(context) * 0.9,
                  decoration: const BoxDecoration(
                      color: Color(0xFFE2EBFF),
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 53,
                        width: 87,
                        'assets/images/ic_home_entity.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.entity,
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w400),
                      SizedBox(height: 7),
                      Padding(
                        padding: App.appSpacer.edgeInsets.x.sm,
                        child: CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.entity_description,
                          fontSize: 10,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          isMultyline: true,
                          line: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BasicDivider(width: App.appQuery.responsiveWidth(70)),
          ],

          if (Utils.decodedMap['view_client'] == true) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0,
                  Utils.deviceWidth(context) * 0.04, 0),
              child: GestureDetector(
                onTap: () {

 Get.toNamed(RouteName.clientListScreen, arguments: [
                      {
                        "from": 'Normal',
                      }
                    ])!
                        .then((value) {});


 
                },
                child: Container(
                  height: Utils.deviceHeight(context) * 0.2,
                  width: Utils.deviceWidth(context) * 0.9,
                  decoration: const BoxDecoration(
                      color: Color(0xFFE2EBFF),
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 53,
                        width: 87,
                        'assets/images/ic_home_client.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.vendors_and_customers,
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w400),
                      SizedBox(height: 7),
                      Padding(
                        padding: App.appSpacer.edgeInsets.x.sm,
                        child: CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.vendors_and_customers_description,
                          fontSize: 10,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          isMultyline: true,
                          line: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BasicDivider(width: App.appQuery.responsiveWidth(70)),
          ],

          if (Utils.decodedMap['view_material'] == true) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0,
                  Utils.deviceWidth(context) * 0.04, 0),
              child: GestureDetector(
                onTap: () {

  Get.toNamed(RouteName.materialListScreen, arguments: [
                      {
                        "from": 'Normal',
                      }
                    ])!
                        .then((value) {});

          
                },
                child: Container(
                  height: Utils.deviceHeight(context) * 0.2,
                  width: Utils.deviceWidth(context) * 0.9,
                  decoration: const BoxDecoration(
                      color: Color(0xFFE2EBFF),
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 53,
                        width: 87,
                        'assets/images/ic_home_material.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.material,
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w400),
                      SizedBox(height: 7),
                      Padding(
                        padding: App.appSpacer.edgeInsets.x.sm,
                        child: CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.material_description,
                          fontSize: 10,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          isMultyline: true,
                          line: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BasicDivider(width: App.appQuery.responsiveWidth(70)),
          ],

          if (Utils.decodedMap['view_asset'] == true) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0,
                  Utils.deviceWidth(context) * 0.04, 0),
              child: GestureDetector(
                onTap: () {
                  {
                    Get.toNamed(RouteName.assetListScreen, arguments: [
                      {
                        "from": 'Normal',
                      }
                    ])!
                        .then((value) {});
                  }
                },
                child: Container(
                  height: Utils.deviceHeight(context) * 0.2,
                  width: Utils.deviceWidth(context) * 0.9,
                  decoration: const BoxDecoration(
                      color: Color(0xFFE2EBFF),
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 53,
                        width: 87,
                        'assets/images/ic_home_asset.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.asset,
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w400),
                      SizedBox(height: 7),
                      Padding(
                        padding: App.appSpacer.edgeInsets.x.sm,
                        child: CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.asset_description,
                          fontSize: 10,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          isMultyline: true,
                          line: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

          SizedBox(height: 22),
          // MyCustomButton(
          //   backgroundColor: homeViewModel.btnStatus.value
          //       ? const Color(0xFF005AFF)
          //       : const Color(0xFF005AFF).withOpacity(0.2),
          //   width: App.appQuery.responsiveWidth(85) /*312.0*/,
          //   height: 48.0,
          //   borderRadius: BorderRadius.circular(10.0),
          //   onPressed: () => {
          //     if (homeViewModel.btnStatus.value)
          //       {
          //         if (homeViewModel.isEntity.value)
          //           {Get.toNamed(RouteName.entityListScreen)}
          //         else if (homeViewModel.isClient.value)
          //           {Utils.snackBar('Client', 'Coming soon')}
          //         else if (homeViewModel.isMaterial.value)
          //           {Utils.snackBar('Material', 'Coming soon')}
          //         else if (homeViewModel.isAsset.value)
          //           {Utils.snackBar('Asset', 'Coming soon')}
          //       }
          //   },
          //   text: 'Continue',
          // ),
          const SizedBox(height: 22),
        ],
      ))),
    );
  }

  toggleDone(bool bool) {}
}
