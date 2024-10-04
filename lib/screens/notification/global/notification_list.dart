import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/view_models/notification/notification_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../models/notification/notification_list_model.dart';

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
          ),
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: App.appSpacer.edgeInsets.y.smm,
          child: Obx(() =>
          !controller.isLoading.value
              ? controller.notificationList.isNotEmpty ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.notificationList.length,
                          itemBuilder: (BuildContext context, int index) {
              return notificationTile(
                  index, context, controller.notificationList[index]);
                          }) : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                              'assets/images/ic_blank_list.png'),
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
              ) : const SizedBox.expand(),
          ),
          // _addButtonWidget
        )
      ),
    );
  }

   Widget notificationTile(
       int index, BuildContext context, NotificationModel notification) {
     return GestureDetector(
       onTap: () {
         // Get.offAndToNamed(RouteName.transferIncomingMaterialScreen, arguments: [
         //   {"tranferId": notification.id.toString()}
         // ]);
       },
       child: Container(
         // margin: App.appSpacer.edgeInsets.x.sm,
         padding: App.appSpacer.edgeInsets.x.sm,
         decoration: const BoxDecoration(
           color: Color(0xffFFFFFF),
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 CustomTextField(
                   textAlign: TextAlign.left,
                   text: notification.title
                       .toString(),
                   fontSize: 14,
                   isMultyline: true,
                   line: 5,
                   fontWeight: FontWeight.w600,
                   fontColor: const Color(0xff1E293B),
                 ),
                 App.appSpacer.vHxxxs,
                 App.appSpacer.vHxxxs,
                 CustomTextField(
                   textAlign: TextAlign.left,
                   text: notification.description
                       .toString(),
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
                       text: Utils.dateFormate(notification.createdAt.toString()),
                       fontSize: 14,
                       fontWeight: FontWeight.w600,
                       fontColor: const Color(0xff1E293B),
                     ),
                     // CustomTextField(
                     //   textAlign: TextAlign.left,
                     //   text:
                     //   Utils.textCapitalizationString('${notification.incomingTotalQuantity.toString()} ${notification.mouName.toString()}'),
                     //   fontSize: 13,
                     //   fontWeight: FontWeight.w400,
                     //   fontColor: const Color(0xff64748B),
                     // ),
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
