import 'package:cold_storage_flutter/res/components/divider/basic_divider.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../view_models/services/app_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeViewModel = Get.put(HomeViewModel());
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
                    0, Utils.deviceWidth(context) * 0.04, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Home',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: homeViewModel.logoUrl.value.isNotEmpty
                                  ? NetworkImage(homeViewModel.logoUrl.value)
                                  : const AssetImage(
                                      'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
            child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.04,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(11)),
                        elevation: 20,
                        child: GestureDetector(
                          onTap: () {
                            {
                              Get.toNamed(RouteName.entityListScreen,
                                      arguments: [
                                    {"first": 'FromHome'}
                                  ])!
                                  .then((value) {});
                            }
                          },
                          child: Container(
                            height: Utils.deviceHeight(context) * 0.2,
                            width: Utils.deviceWidth(context) * 0.9,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE2EBFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 53,
                                  width: 87,
                                  'assets/images/ic_home_entity.png',
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'Entity',
                                    fontSize: 18.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const SizedBox(height: 7),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text:
                                        'Unlock all Lorem ipsum dolor sit amet,',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'consectetur adipiscing elit.',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    BasicDivider(width: App.appQuery.responsiveWidth(70)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.04,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(11)),
                        elevation: 20,
                        child: GestureDetector(
                          onTap: () {
                            Utils.isCheck = true;
                            Utils.snackBar('Client', 'Coming soon');
                          },
                          child: Container(
                            height: Utils.deviceHeight(context) * 0.2,
                            width: Utils.deviceWidth(context) * 0.9,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE2EBFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 53,
                                  width: 87,
                                  'assets/images/ic_home_client.png',
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'Client',
                                    fontSize: 18.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const SizedBox(height: 7),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text:
                                        'Unlock all Lorem ipsum dolor sit amet,',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'consectetur adipiscing elit.',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    BasicDivider(width: App.appQuery.responsiveWidth(70)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.04,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(11)),
                        elevation: 20,
                        child: GestureDetector(
                          onTap: () {
                            Utils.isCheck = true;
                            Utils.snackBar('Material', 'Coming soon');
                          },
                          child: Container(
                            height: Utils.deviceHeight(context) * 0.2,
                            width: Utils.deviceWidth(context) * 0.9,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE2EBFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 53,
                                  width: 87,
                                  'assets/images/ic_home_material.png',
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'Material',
                                    fontSize: 18.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const SizedBox(height: 7),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text:
                                        'Unlock all Lorem ipsum dolor sit amet,',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'consectetur adipiscing elit.',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    BasicDivider(width: App.appQuery.responsiveWidth(70)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.04,
                          0,
                          Utils.deviceWidth(context) * 0.04,
                          0),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(11)),
                        elevation: 20,
                        child: GestureDetector(
                          onTap: () {
                            Utils.isCheck = true;
                            Utils.snackBar('Asset', 'Coming soon');
                          },
                          child: Container(
                            height: Utils.deviceHeight(context) * 0.2,
                            width: Utils.deviceWidth(context) * 0.9,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE2EBFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 53,
                                  width: 87,
                                  'assets/images/ic_home_asset.png',
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'Asset',
                                    fontSize: 18.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const SizedBox(height: 7),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text:
                                        'Unlock all Lorem ipsum dolor sit amet,',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'consectetur adipiscing elit.',
                                    fontSize: 10.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
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
