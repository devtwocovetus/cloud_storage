import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final myController = TextEditingController(text: '0');
  int totalValue = 10;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomTextField(
              text: 'Get Premium',
              fontSize: 32.0,
              fontColor: Color(0xFF000000),
              fontWeight: FontWeight.w700),
          const SizedBox(
            height: 20.0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: CustomTextField(
                textAlign: TextAlign.center,
                text:
                    'Unlock all Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                fontSize: 14.0,
                fontColor: Color(0xFF092765),
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Image.asset(
            'assets/images/ic_logo_subscriptions.png',
            fit: BoxFit.cover,
          ),
          Container(
            width: 350,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(13.0),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff005AFF))),
            child: const Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'BASE PLAN',
                            fontSize: 20,
                            fontColor: Color(0xFF000000),
                            fontWeight: FontWeight.w700),
                      ),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text:
                              'In this plan, you will get only one default user. If you want extra users, then the user will be an add-on at \$4 per user along with the base plan.',
                          fontSize: 15,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                Spacer(),
                CustomTextField(
                    text: '\$10',
                    fontSize: 40,
                    fontColor: Color(0xFF000000),
                    fontWeight: FontWeight.w700),
              ],
            ),
          ),
          CustomTextFormField(
            width: 350.0,
            height: 45.0,
            borderRadius: BorderRadius.circular(8.0),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
            ],
            hint: 'User count',
            controller: myController,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              print('<><><> ${myController.text}');

              setState(() {
                if (myController.text.isEmpty) {
                  totalValue = 10;
                } else {
                  totalValue = 10 + int.parse(myController.text) * 4;
                }
              });
            },
          ),
          const SizedBox(
            height: 50.0,
          ),
          MyCustomButton(
            width: 350.0,
            height: 48.0,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () => init(),
            fontWeight: FontWeight.w600,
            text: "Subscribe \$$totalValue",
          )
        ],
      ),
    );
  }
}
