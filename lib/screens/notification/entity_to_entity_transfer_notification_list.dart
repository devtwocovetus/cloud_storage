import 'package:cold_storage_flutter/models/transfer/entity_to_entity_transfer_notification.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/entity_to_entity_transfer_notification_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class EntityToEntityTransferNotificationList extends StatelessWidget {
  EntityToEntityTransferNotificationList({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(EntityToEntityTransferNotificationViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
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
                    Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.notifications,
                          fontSize: 18.0.sp,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20.h,
                              width: 20.h,
                              url: UserPreference.profileLogo.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: App.appSpacer.edgeInsets.y.smm,
        child: Obx(() => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.incomingRequestList!.length,
            itemBuilder: (BuildContext context, int index) {
              return notificationTile(
                  index, context, controller.incomingRequestList![index]);
            })),

        // _addButtonWidget
      )),
    );
  }

  String getDates(String text)  {
    String dates = '';
  dates = Utils.dateFormateNew(text.toString());
  return dates;
}

  Widget notificationTile(
      int index, BuildContext context, InternalRequest incomingRequest) {
    return GestureDetector(
      onTap: () {
         Get.offAndToNamed(RouteName.entityToEntityMaterialMapping, arguments: [
           {"notificationId": incomingRequest.id.toString(),"from": 'Normal'}
         ]);
      },
      child: Container(
        margin: App.appSpacer.edgeInsets.x.sm,
        padding: EdgeInsets.fromLTRB(
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            0),
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: incomingRequest.senderEntity
                          .toString(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontColor: const Color(0xff1E293B),
                    ),
                    SizedBox(height: 4.h,),
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.has_transferred_new_material,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff64748B),
                    ),
                    SizedBox(height: 4.h,),
                    Row(
                      children: [
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text:  getDates(incomingRequest.transactionDate.toString()),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          fontColor: const Color(0xff1E293B),
                        ),
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text:
                             Utils.textCapitalizationString('${incomingRequest.quantity.toString()} material(s)'),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff64748B),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            const Divider(
              color: kAppGreyC,
            ),
            SizedBox(height: 10.h,),
          ],
        ),
      ),
    );
  }
}
