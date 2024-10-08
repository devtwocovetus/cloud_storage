import 'package:cold_storage_flutter/models/notification/notification_main_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/notification/notification_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';


class NotificationList extends StatelessWidget {
  NotificationList({super.key});

  final controller = Get.put(NotificationListViewModel());

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
          child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: App.appSpacer.edgeInsets.y.smm,
        child: Obx(
          () => !controller.isLoading.value
              ? controller.notificationList.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.notificationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return notificationTile(
                            index, context, controller.notificationList[index]);
                      })
                  : Padding(
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
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTextField(
                                    textAlign: TextAlign.center,
                                    text: 'No Notification Found',
                                    fontSize: 18.0,
                                    fontColor: Color(0xFF000000),
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          // const Spacer(),
                        ],
                      ),
                    )
              : const SizedBox.expand(),
        ),
        // _addButtonWidget
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
                  "from": 'Normal'
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
                  "from": 'Normal',
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
                  "from": 'Normal',
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
                width: 30,
                height: 30,
                child: notification.read == 0
                    ? Image.asset(
                        height: 30,
                        width: 30,
                        'assets/images/ic_notification_unread.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        height: 30,
                        width: 30,
                        'assets/images/ic_notification_read.png',
                        fit: BoxFit.cover,
                      ), // Example icon, you can replace with Image
              ),

              const SizedBox(width: 10), // Space between icon and text

              // Column containing text
              Expanded(
                // Expanded to take the remaining width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      textAlign: TextAlign.left,
                      text: notification.title.toString(),
                      fontSize: 14,
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
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff64748B),
                    ),
                    App.appSpacer.vHxxxs,
                    Row(
                      children: [
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text: Utils.dateFormateNotification(
                              notification.createdAt.toString()),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontColor: const Color(0xff1E293B),
                        ),
                      ],
                    ),
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                  ],
                ),
              ),

              if (notification.action == 1 &&
                  notification.actionCompleted == 0) ...[
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    height: 30,
                    width: 30,
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
