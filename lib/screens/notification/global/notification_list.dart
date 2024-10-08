import 'package:cold_storage_flutter/models/notification/notification_main_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/notification/notification_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;


class NotificationList extends StatelessWidget {
  NotificationList({super.key});

  final controller = Get.put(NotificationListViewModel());
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
                    // Obx(
                    //   () => IconButton(
                    //   onPressed: () {
                    //     // _sliderDrawerKey.currentState!.toggle();
                    //     Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                    //   },
                    //   icon: AppCachedImage(
                    //     roundShape: true,
                    //     height: 20,
                    //     width: 20,
                    //     url: UserPreference.profileLogo.value)
                    //   ),
                    // ),
                  ],

            ),
          ),
        )
      ),),
      body: SafeArea(
          child: Obx(()=>!controller.isLoading.value
              ? controller.notificationList.isNotEmpty
              ? SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: App.appSpacer.edgeInsets.y.smm,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.notificationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return notificationTile(
                              index, context, controller.notificationList[index]);
                        }) // _addButtonWidget
                  ) : Center(
                    child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // const Spacer(),
                                    Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset('assets/images/ic_blank_list.png'),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                            textAlign: TextAlign.center,
                            text: translation.no_notification_found,
                            fontSize: 18.0.sp,
                            fontColor: Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                                    ),
                                    // const Spacer(),
                                  ],
                                ),
                              ),
                  )
              : const SizedBox.expand(),
          )),
    );
  }

  Widget notificationTile(
      int index, BuildContext context, NotificationItemData notification) {
    return GestureDetector(
        onTap: () {
          if (notification.action == 1 && notification.actionCompleted == 0) {
//this
            if (notification.dataNotification!.mainModule == 'Transfer' &&
                notification.dataNotification!.subModule ==
                    'AccountToAccount') {
              Get.toNamed(RouteName.transferIncomingMaterialScreen, arguments: [
                {
                  "tranferId": notification
                      .dataNotification!.materialIncomingRequestId
                      .toString(),
                  "from": 'Notification'
                }
              ]);
            }

//this
            if (notification.dataNotification!.mainModule == 'Transfer' &&
                notification.dataNotification!.subModule == 'EntityToEntity') {
              Get.toNamed(RouteName.entityToEntityMaterialMapping, arguments: [
                {
                  "notificationId": notification
                      .dataNotification!.internalTranferId
                      .toString(),
                  "from": 'Notification',
                }
              ]);
            }

//this
            if (notification.dataNotification!.mainModule == 'Client' &&
                notification.dataNotification!.subModule == 'ClientDetails') {
              Get.toNamed(RouteName.clientDetailsScreen, arguments: [
                {
                  "clientId":
                      notification.dataNotification!.clientId.toString(),
                  "clientIsRequest": 'true',
                  "clientIsManual": '0',
                  "requestSent": 'false',
                  "outgoingRequestAccepted": 'false',
                  "incomingRequestAccepted": 'false',
                  "requestIncoming": 'true',
                  "from": 'Notification',
                }
              ]);
            }
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.01,
            Utils.deviceWidth(context) * 0.03,
            0,
          ),
          padding: EdgeInsets.fromLTRB(
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: notification.read == 0
                ? const Color(0xffEFF8FF)
                : const Color(0xffF2F2F2), // Consistent color
          ),
          child: Row(
            // Row layout to add icon and text side by side
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center both icons vertically
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Push items to the edges
            children: [
              // Icon or Image on the left side
              SizedBox(
                width: 30.h,
                height: 30.h,
                child: notification.read == 0
                    ? Image.asset(
                        height: 30.h,
                        width: 30.h,
                        'assets/images/ic_notification_unread.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        height: 30.h,
                        width: 30.h,
                        'assets/images/ic_notification_read.png',
                        fit: BoxFit.cover,
                      ), // Example icon, you can replace with Image
              ),

              SizedBox(width: 10.h), // Space between icon and text

              // Column containing text
              Expanded(
                // Expanded to take the remaining width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: notification.title.toString(),
                      fontSize: 14.sp,
                      isMultyline: true,
                      line: 5,
                      fontWeight: FontWeight.w600,
                      fontColor: const Color(0xff1E293B),
                    ),
                    App.appSpacer.vHxxxs,
                    CustomTextField(
                      isMultyline: true,
                      line: 2,
                      textAlign: TextAlign.left,
                      text: notification.description.toString(),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff64748B),
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      children: [
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text: Utils.dateFormateNotification(
                              notification.createdAt.toString()),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          fontColor: const Color(0xff1E293B),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),

              if (notification.action == 1 &&
                  notification.actionCompleted == 0) ...[
                SizedBox(
                  width: 30.h,
                  height: 30.h,
                  child: Image.asset(
                    height: 30.h,
                    width: 30.h,
                    'assets/images/ic_action.png',
                    fit: BoxFit.cover,
                  ), // Example icon on right side
                ),
              ]
            ],
          ),
        ));
  }
}
