import 'dart:io';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/setting/profile_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

class ProfileDashbordSetting extends StatefulWidget {
  const ProfileDashbordSetting({super.key});

  @override
  State<ProfileDashbordSetting> createState() => _ProfileDashbordSettingState();
}

class _ProfileDashbordSettingState extends State<ProfileDashbordSetting> {
  final profileDashboardViewModel = Get.put(ProfileDashboardViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          profileDashboardViewModel.logout();
        },
        child: Container(
          width: Utils.deviceWidth(context) * 0.80,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff000000),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CustomTextField(
            textAlign: TextAlign.center,
            text: 'Logout',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontColor: Color(0xff000000),
          ),
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
                        text: 'Profile',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 22.0,
                ),
                Center(
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: AppCachedImage(
                                  roundShape: true,
                                  height: 90,
                                  width: 90,
                                  url: profileDashboardViewModel.logoUrl.value),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const CustomTextField(
                                text: 'Akhilesh Pathak',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xff000000)),
                            const SizedBox(
                              height: 5,
                            ),
                            const CustomTextField(
                              text: 'akhilesh.covetus@gmail.com',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              fontColor: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const CustomTextField(
                //         text: 'Inactive',
                //         fontSize: 13.0,
                //         fontWeight: FontWeight.w400,
                //         fontColor: Color(0xff000000)),
                //     const SizedBox(
                //       width: 5.0,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         createUserViewModel.isActive.value =
                //             !createUserViewModel.isActive.value;
                //       },
                //       child: createUserViewModel.isActive.value
                //           ? Image.asset(
                //               'assets/images/ic_switch_on.png',
                //               width: 34,
                //               height: 20,
                //               fit: BoxFit.cover,
                //             )
                //           : Image.asset(
                //               'assets/images/ic_switch_off.png',
                //               width: 34,
                //               height: 20,
                //               fit: BoxFit.cover,
                //             ),
                //     ),
                //     const SizedBox(
                //       width: 5.0,
                //     ),
                //     const CustomTextField(
                //         text: 'Active',
                //         fontSize: 13.0,
                //         fontWeight: FontWeight.w400,
                //         fontColor: Color(0xff000000))
                //   ],
                // ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteName.profileUpdateSetting)!
                        .then((value) {});
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F2F2),
                        border: Border.all(
                          color: const Color(0xffF2F2F2),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            height: 25,
                            width: 25,
                            'assets/images/ic_profile_user.png',
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Update Profile',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontColor: Color(0xff000000),
                          ),
                          const Spacer(),
                          Image.asset(
                            height: 25,
                            width: 25,
                            'assets/images/ic_profile_forward.png',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Utils.deviceWidth(context) * 0.04,
                      0,
                      Utils.deviceWidth(context) * 0.04,
                      0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F2F2),
                      border: Border.all(
                        color: const Color(0xffF2F2F2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          height: 25,
                          width: 25,
                          'assets/images/ic_profile_password.png',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Update Password',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff000000),
                        ),
                        const Spacer(),
                        Image.asset(
                          height: 25,
                          width: 25,
                          'assets/images/ic_profile_forward.png',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}