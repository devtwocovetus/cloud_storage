import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../helperstripe/utils/subscription_process.dart';

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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 31.0,
            ),
            Image.asset(
              'assets/images/ic_logo_subscriptions.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff005AFF)),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CustomTextField(
                        text: 'Get Premium At',
                        fontSize: 24,
                        fontColor: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CustomTextField(
                        text: '\$299/Year Base price',
                        fontSize: 16,
                        fontColor: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Get started with all the essential features',
                        fontSize: 16,
                        fontColor: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ic_vector_right.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: '1 User',
                          fontSize: 16,
                          fontColor: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ic_vector_right.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Unlimited Entities',
                          fontSize: 16,
                          fontColor: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ic_vector_right.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Unlimited Clients',
                          fontSize: 16,
                          fontColor: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ic_vector_right.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Unlimited Assets',
                          fontSize: 16,
                          fontColor: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/ic_vector_right.png',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Unlimited Materials',
                          fontSize: 16,
                          fontColor: Color(0xFFFFFFFF),
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
                  const Row(children: [
                    CustomTextField(
                        text: 'Additional Users',
                        fontSize: 16,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w700),
                    Spacer(),
                    CustomTextField(
                        text: '\$99/',
                        fontSize: 24,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w400),
                    CustomTextField(
                        text: 'user /Year',
                        fontSize: 13,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w400)
                  ]),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFE6E6E6),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Add them to your plan!',
                        fontSize: 12,
                        fontColor: Color(0xFF808080),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 12.0,
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
                          width: 50,
                          height: 48,
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
                          child: const Center(
                            child: CustomTextField(
                                text: '-',
                                fontSize: 30,
                                fontColor: Color(0xFF000000),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      CustomTextFormFieldNon(
                        width: 80.0,
                        height: 50.0,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                        ],
                        hint: 'Count',
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
                          width: 50,
                          height: 48,
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
                          child: const Center(
                            child: CustomTextField(
                                text: '+',
                                fontSize: 30,
                                fontColor: Color(0xFF000000),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 70,
                        height: 48,
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
                              fontSize: 12,
                              fontColor: const Color(0xFF000000),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            MyCustomButton(
              fontSize: 16,
              width: 350.0,
              height: 48.0,
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
              text: "Proceed To Pay \$$totalValue",
            ),
            const SizedBox(
              height: 26.0,
            ),
          ],
        ),
      ),
    );
  }
}
