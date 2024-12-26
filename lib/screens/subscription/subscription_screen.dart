import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/subscription/subscription_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {

  final TakeSubscriptionViewModel controller = Get.put(TakeSubscriptionViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(()=> MyCustomButton(
          fontSize: 16.sp,
          width: 350.0.h,
          height: 48.0.h,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () =>{

            // if(myController.text.isEmpty || myController.text == '0'){
            //   subscriptionViewModel.takeSubscription('0',totalValue.toString())
            // }else{
            //   subscriptionViewModel.takeSubscription(myController.text,totalValue.toString())
            // }
          } ,
          fontWeight: FontWeight.w600,
          text: "${translation.proceed_to_pay} \$${controller.totalValue.value}",
        ),
      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CustomTextField(
                              text: 'Get Premium',
                              fontSize: 24.sp,
                              fontColor: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Stack(
                        children: [
                          TextButton(
                            onPressed: () {
                              _getDialog();
                              // setState(() {
                              //   visible = !visible;
                              // });
                            },
                            onHover: (value) {

                            },
                            child: Text(
                              'Terms and Condition',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: kAppWhite,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kAppWhite,
                                  decorationThickness: 1.5,
                                  decorationStyle: TextDecorationStyle.solid
                                )
                              ),
                              textAlign: TextAlign.right,
                            )
                          ),
                          // _getDialog(),
                        ],
                      )
                    ],
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
                        fontWeight: FontWeight.w400
                      ),
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
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: controller.subscriptionList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _subscriptionTile(index);
                },
              ),
            ),
            100.0.verticalSpaceFromWidth,
            // SizedBox(
            //   height: 90.verticalSpace,
            // ),
          ],
        ),
      ),
    );
  }

  bool visible = false;

  Future _getDialog(){
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        backgroundColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Terms and Condition',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: kAppPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  )
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.fiber_manual_record_rounded,size: 12,color: kAppPrimary,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      'This subscription will automatically renew at the end of the period unless cancelled',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: kAppPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        )
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.fiber_manual_record_rounded,size: 12,color: kAppPrimary,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      'You can cancel your subscription anytime before the renewal date through the app settings',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: kAppPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        )
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.fiber_manual_record_rounded,size: 12,color: kAppPrimary,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      'You can cancel at any time before the renewal date',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: kAppPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        )
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.fiber_manual_record_rounded,size: 12,color: kAppPrimary,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      'No refund after the billing cycle begins',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: kAppPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        )
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subscriptionTile(int index){
    return Obx(()=>
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: index == controller.selectedIndex.value ? const BorderSide(
              color: kAppPrimary,
              width: 2
          ) : BorderSide.none,
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.h,vertical: 5.h),
        color: kAppWhite,
        elevation: 16,
        borderOnForeground: false,
        child: ListTile(
          dense: true,
          selected: true,
          isThreeLine: false,

          contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
          title: Text(
            controller.subscriptionList[index]['title'],
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: kAppBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                )
            ),
            textAlign: TextAlign.left,
          ),
          subtitle: Text(
            controller.subscriptionList[index]['description'],
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: kAppText,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                )
            ),
            textAlign: TextAlign.left,
          ),
          trailing: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 100.w),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                '\$${controller.subscriptionList[index]['price']}/Year',
                maxLines: 2,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: kAppBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    )
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          splashColor: Colors.transparent,
          onTap: () {
            controller.onSubscriptionTap(index: index);
            // setState(() {
            //   selectedIndex = index;
            // });
          },
        ),
      ),
    );
  }
}
class CustomStyleArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    const double triangleH = 10;
    const double triangleW = 25.0;
    final double width = size.width;
    final double height = size.height;

    final Path trianglePath = Path()
      ..moveTo(width / 2 - triangleW / 2, height)
      ..lineTo(width / 2, triangleH + height)
      ..lineTo(width / 2 + triangleW / 2, height)
      ..close();

    canvas.drawPath(trianglePath, paint);
    final BorderRadius borderRadius = BorderRadius.circular(15);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}