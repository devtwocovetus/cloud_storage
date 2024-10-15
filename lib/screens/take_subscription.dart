import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../helperstripe/utils/subscription_process.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class TakeSubscription extends StatefulWidget {
  const TakeSubscription({
    super.key,
  });

  @override
  State<TakeSubscription> createState() => _TakeSubscriptionState();
}

class _TakeSubscriptionState extends State<TakeSubscription> {
  final subscriptionViewModel = Get.put(SubscriptionViewModel());
  final myController = TextEditingController(text: '0');
  int totalValue = 299;
  int userValue = 0;
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  border: Border.all(color: const Color(0xffE6E6E6), width: 1),
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
                          setState(() {
                            if (myController.text.isEmpty ||
                                myController.text == '0') {
                              myController.text = '0';
                              totalValue =
                                  299 + int.parse(myController.text) * 99;
                              userValue = int.parse(myController.text) * 99;
                            } else {
                              myController.text =
                                  '${int.parse(myController.text) - 1}'
                                      .toString();
                              totalValue =
                                  299 + int.parse(myController.text) * 99;
                              userValue = int.parse(myController.text) * 99;
                            }
                          });
                         
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
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                        ],
                        readOnly: true,
                        hint: translation.count,
                        controller: myController,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            if (myController.text.isEmpty) {
                              totalValue = 299;
                              userValue = 0;
                            } else {
                              totalValue =
                                  299 + int.parse(myController.text) * 99;
                              userValue = int.parse(myController.text) * 99;
                            }
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                           setState(() {
                            if (myController.text.isEmpty ||
                                myController.text == '0') {
                              myController.text = '1';
                              totalValue =
                                  299 + int.parse(myController.text) * 99;
                              userValue = int.parse(myController.text) * 99;
                            } else {
                              myController.text =
                                  '${int.parse(myController.text) + 1}'
                                      .toString();
                              totalValue =
                                  299 + int.parse(myController.text) * 99;
                              userValue = int.parse(myController.text) * 99;
                            }
                          });
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
                                fontSize: 30.h,
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            top: BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            bottom:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                            right:
                                BorderSide(color: Color(0xFFD0D5DD), width: 1),
                          ),
                        ),
                        child: Center(
                          child: CustomTextField(
                              text: '$userValue\$',
                              fontSize: 12.h,
                              fontColor: const Color(0xFF000000),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
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
              borderRadius: BorderRadius.circular(10.0),
              onPressed: () =>{
                print('subResponce myController.text ${myController.text}'),
                if(myController.text.isEmpty || myController.text == '0'){
                  subscriptionViewModel.takeSubscription('0',totalValue.toString())
                }else{
                  subscriptionViewModel.takeSubscription(myController.text,totalValue.toString())
                }
              } ,
              fontWeight: FontWeight.w600,
              text: "${translation.proceed_to_pay} \$$totalValue",
            ),
            SizedBox(
              height: 26.0.h,
            ),
          ],
        ),
      ),
    );
  }
}
