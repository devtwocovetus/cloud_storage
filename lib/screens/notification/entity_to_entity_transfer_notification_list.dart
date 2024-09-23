import 'package:cold_storage_flutter/models/transfer/entity_to_entity_transfer_notification.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/entity_to_entity_transfer_notification_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class EntityToEntityTransferNotificationList extends StatelessWidget {
  EntityToEntityTransferNotificationList({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(EntityToEntityTransferNotificationViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Notifications',
                          fontSize: 18.0,
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
                              height: 20,
                              width: 20,
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
            physics: const BouncingScrollPhysics(),
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
        // Get.offAndToNamed(RouteName.transferIncomingMaterialScreen, arguments: [
        //   {"tranferId": incomingRequest.id.toString()}
        // ]);
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontColor: const Color(0xff1E293B),
                    ),
                     App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                    const CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Has transferred a new material',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff64748B),
                    ),
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                    Row(
                      children: [
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text:  getDates(incomingRequest.transactionDate.toString()),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontColor: const Color(0xff1E293B),
                        ),
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text:
                             Utils.textCapitalizationString('${incomingRequest.quantity.toString()} ${incomingRequest.mouName.toString()}'),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff64748B),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            const Divider(
              color: kAppGreyC,
            ),
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
          ],
        ),
      ),
    );
  }
}
