import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/view_models/setting/setting_subscription_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class SettingSubscription extends StatefulWidget {
  const SettingSubscription({
    super.key,
  });

  @override
  State<SettingSubscription> createState() => _SettingSubscriptionState();
}

class _SettingSubscriptionState extends State<SettingSubscription> {
  final subscriptionViewModel = Get.put(SettingSubscriptionViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Container(
              height: 60.h,
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
                          height: 15.h,
                          width: 10.h,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.add_user,
                          fontSize: 18.0.sp,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                      const Spacer(),
                      // Padding(
                      //   padding: App.appSpacer.edgeInsets.top.none,
                      //   child: Obx(() => IconButton(
                      //       padding: EdgeInsets.zero,
                      //       onPressed: () {
                      //         // _sliderDrawerKey.currentState!.toggle();
                      //       },
                      //       icon: AppCachedImage(
                      //           roundShape: true,
                      //           height: 20,
                      //           width: 20,
                      //           fit: BoxFit.cover,
                      //           url: UserPreference.profileLogo.value))),
                      // ),
                    ],
                  ),
                ),
              ),
            )),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 31.0.h,
                ),
                Image.asset(
                  height: 191.h,
                  width: 234.h,
                  'assets/images/ic_logo_subscriptions.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff005AFF)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomTextField(
                            text: translation.get_premium_at,
                            fontSize: 24.sp,
                            fontColor: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomTextField(
                            text: '\$299 ${translation.year_base_price}',
                            fontSize: 16.sp,
                            fontColor: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: translation.essential_features,
                            fontSize: 16.sp,
                            fontColor: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            width: 10.h,
                            height: 8.h,
                            'assets/images/ic_vector_right.png',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 12.0.h,
                          ),
                          CustomTextField(
                              textAlign: TextAlign.left,
                              text: translation.user,
                              fontSize: 16.sp,
                              fontColor: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            width: 10.h,
                            height: 8.h,
                            'assets/images/ic_vector_right.png',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 12.0.h,
                          ),
                          CustomTextField(
                              textAlign: TextAlign.left,
                              text: translation.unlimited_entities,
                              fontSize: 16.sp,
                              fontColor: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            width: 10.h,
                            height: 8.h,
                            'assets/images/ic_vector_right.png',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 12.0.h,
                          ),
                          CustomTextField(
                              textAlign: TextAlign.left,
                              text: translation.unlimited_clients,
                              fontSize: 16.sp,
                              fontColor: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            width: 10.h,
                            height: 8.h,
                            'assets/images/ic_vector_right.png',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 12.0.h,
                          ),
                          CustomTextField(
                              textAlign: TextAlign.left,
                              text: translation.unlimited_assets,
                              fontSize: 16.sp,
                              fontColor: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            width: 10.h,
                            height: 8.h,
                            'assets/images/ic_vector_right.png',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 12.0.h,
                          ),
                          CustomTextField(
                              textAlign: TextAlign.left,
                              text: translation.unlimited_materials,
                              fontSize: 16.sp,
                              fontColor: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: const Color(0xffE6E6E6), width: 1),
                      color: const Color(0xffffffff)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Expanded(
                          child: CustomTextField(
                            textAlign: TextAlign.left,
                              text: translation.additional_users,
                              fontSize: 16.sp,
                              line: 2,
                              isMultyline: true,
                              fontColor: const Color(0xFF000000),
                              fontWeight: FontWeight.w700),
                        ),
                        CustomTextField(
                            text: '\$99/',
                            fontSize: 22.sp,
                            fontColor: Color(0xFF000000),
                            fontWeight: FontWeight.w400),
                        CustomTextField(
                            text: translation.user_year,
                            fontSize: 13.sp,
                            fontColor: const Color(0xFF000000),
                            fontWeight: FontWeight.w400)
                      ]),
                      SizedBox(
                        height: 12.0.h,
                      ),
                      Divider(
                        height: 1.h,
                        thickness: 1.h,
                        color: Color(0xFFE6E6E6),
                      ),
                      SizedBox(
                        height: 12.0.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: translation.add_to_plan,
                            fontSize: 12.sp,
                            fontColor: const Color(0xFF808080),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 12.0.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {

                              if(subscriptionViewModel.totalValueOld.value !=
                                  subscriptionViewModel.totalValue.value){
                                if (subscriptionViewModel
                                    .myController.value.text.isEmpty ||
                                    subscriptionViewModel
                                        .myController.value.text ==
                                        '0') {
                                  subscriptionViewModel.myController.value.text =
                                  '0';
                                  subscriptionViewModel.totalValue.value = 299 +
                                      int.parse(subscriptionViewModel
                                          .myController.value.text) *
                                          99;
                                  subscriptionViewModel.userValue.value =
                                      int.parse(subscriptionViewModel
                                          .myController.value.text) *
                                          99;
                                } else {
                                  subscriptionViewModel.myController.value.text =
                                      '${int.parse(subscriptionViewModel.myController.value.text) - 1}'
                                          .toString();
                                  subscriptionViewModel.totalValue.value = 299 +
                                      int.parse(subscriptionViewModel
                                          .myController.value.text) *
                                          99;
                                  subscriptionViewModel.userValue.value =
                                      int.parse(subscriptionViewModel
                                          .myController.value.text) *
                                          99;
                                }

                                subscriptionViewModel.updateUserCount('-');
                              }

                            },
                            child: Container(
                              width: 50.h,
                              height: 48.h,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                                border: Border(
                                  left: BorderSide(
                                      color: Color(0xFFD0D5DD), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFFD0D5DD), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFFD0D5DD), width: 1),
                                ),
                              ),
                              child: Center(
                                child: CustomTextField(
                                    text: '-',
                                    fontSize: 30.sp,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          CustomTextFormFieldNon(
                            width: 80.0.h,
                            height: 50.0.h,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"))
                            ],
                            readOnly: true,
                            hint: translation.count,
                            controller:
                                subscriptionViewModel.myController.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (subscriptionViewModel
                                  .myController.value.text.isEmpty) {
                                subscriptionViewModel.totalValue.value = 299;
                                subscriptionViewModel.userValue.value = 0;
                              } else {
                                subscriptionViewModel.totalValue.value = 299 +
                                    int.parse(subscriptionViewModel
                                            .myController.value.text) *
                                        99;
                                subscriptionViewModel.userValue.value =
                                    int.parse(subscriptionViewModel
                                            .myController.value.text) *
                                        99;
                              }
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (subscriptionViewModel
                                      .myController.value.text.isEmpty ||
                                  subscriptionViewModel
                                          .myController.value.text ==
                                      '0') {
                                subscriptionViewModel.myController.value.text =
                                    '1';
                                subscriptionViewModel.totalValue.value = 299 +
                                    int.parse(subscriptionViewModel
                                            .myController.value.text) *
                                        99;
                                subscriptionViewModel.userValue.value =
                                    int.parse(subscriptionViewModel
                                            .myController.value.text) *
                                        99;
                              } else {
                                subscriptionViewModel.myController.value.text =
                                    '${int.parse(subscriptionViewModel.myController.value.text) + 1}'
                                        .toString();
                                subscriptionViewModel.totalValue.value = 299 +
                                    int.parse(subscriptionViewModel
                                            .myController.value.text) *
                                        99;
                                subscriptionViewModel.userValue.value =
                                    int.parse(subscriptionViewModel
                                            .myController.value.text) *
                                        99;
                              }
                              subscriptionViewModel.updateUserCount('+');
                            },
                            child: Container(
                              width: 50.h,
                              height: 48.h,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                                border: Border(
                                  right: BorderSide(
                                      color: Color(0xFFD0D5DD), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFFD0D5DD), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFFD0D5DD), width: 1),
                                ),
                              ),
                              child: Center(
                                child: CustomTextField(
                                    text: '+',
                                    fontSize: 30.sp,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 70.h,
                            height: 48.h,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                left: BorderSide(
                                    color: Color(0xFFD0D5DD), width: 1),
                                top: BorderSide(
                                    color: Color(0xFFD0D5DD), width: 1),
                                bottom: BorderSide(
                                    color: Color(0xFFD0D5DD), width: 1),
                                right: BorderSide(
                                    color: Color(0xFFD0D5DD), width: 1),
                              ),
                            ),
                            child: Center(
                              child: CustomTextField(
                                  text:
                                      '${subscriptionViewModel.userValue.value}\$',
                                  fontSize: 12.sp,
                                  fontColor: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      if (subscriptionViewModel.totalValueOld.value !=
                              subscriptionViewModel.totalValue.value &&
                          subscriptionViewModel.isIncrees.value == false) ...[
                         SizedBox(
                          height: 12.0.h,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomTextField(
                              textAlign: TextAlign.left,
                              text:
                              translation.this_reflected_next_billing,
                              fontSize: 14.sp,
                              fontColor: const Color(0xFF000000),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 12.0.h,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(
                  height: 26.0.h,
                ),
                MyCustomButton(
                  fontSize: 16.sp,
                  width: 350.0.h,
                  height: 48.0.h,
                  backgroundColor: subscriptionViewModel.totalValueOld.value ==
                          subscriptionViewModel.totalValue.value
                      ? kAppGrey
                      : kAppPrimary, //gray
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () => {
                    if (subscriptionViewModel.isIncrees.value)
                      {
                        subscriptionViewModel.proceedToPay(int.parse(subscriptionViewModel.myController.value.text) + 1,subscriptionViewModel.mFinalUserCount.value * 99)
                      }
                    else
                      {
                        subscriptionViewModel.proceedOnly(
                          int.parse(subscriptionViewModel
                                  .myController.value.text) +
                              1
                        )
                      }
                  },
                  fontWeight: FontWeight.w600,
                  text: subscriptionViewModel.isIncrees.value
                      ? '${translation.proceed_to_pay} \$${subscriptionViewModel.mFinalUserCount.value * 99}'
                      : translation.proceed,
                ),
                SizedBox(
                  height: 26.0.h,
                ),
              ],
            ),
          ),
        ));
  }
}
