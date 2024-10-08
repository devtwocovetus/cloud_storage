import 'package:cold_storage_flutter/extensions/extension.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/setting/profile_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/colors/app_color.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class ProfileDashbordSetting extends StatefulWidget {
  const ProfileDashbordSetting({super.key});

  @override
  State<ProfileDashbordSetting> createState() => _ProfileDashbordSettingState();
}

class _ProfileDashbordSettingState extends State<ProfileDashbordSetting> {
  final profileDashboardViewModel = Get.put(ProfileDashboardViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          profileDashboardViewModel.getAppLogOut();
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
          child: CustomTextField(
            textAlign: TextAlign.center,
            text: translation.logout,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontColor: const Color(0xff000000),
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
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.profile,
                        fontSize: 18.0,
                        fontColor: const Color(0xFF000000),
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
                                  url: UserPreference.profileLogo.value),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                                text: UserPreference.profileUserName.value.toCapitalize(),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                fontColor: const Color(0xff000000)),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              text: UserPreference.profileUserEmail.value,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              fontColor: kAppGreyADark,
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
                          CustomTextField(
                            textAlign: TextAlign.left,
                            text: translation.update_profile,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontColor: const Color(0xff000000),
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
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteName.profileUpdatePassword);
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
                            'assets/images/ic_profile_password.png',
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomTextField(
                            textAlign: TextAlign.left,
                            text: translation.update_password,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontColor: const Color(0xff000000),
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
