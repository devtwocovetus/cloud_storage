import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/material_transfer_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

class NotificationList extends StatelessWidget {
  NotificationList({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(MaterialTransferViewModel());
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
                        height: 20,
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
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 25,
                              width: 25,
                              url: controller.logoUrl.value)),
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
        child: ListView.builder(
             physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return notificationTile(index, context);
                }),
            
            // _addButtonWidget
        
      )),
    );
  }

  Widget notificationTile(int index, BuildContext context) {
    return Container(
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
                  const Row(
                    children: [
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Henry Jack',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontColor: Color(0xff1E293B),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: ' has transfer a new material',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff64748B),
                      ),
                    ],
                  ),
                  App.appSpacer.vHxxxs,
                  App.appSpacer.vHxxxs,
                  const Row(
                    children: [
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: '06-14-2024',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontColor: Color(0xff1E293B),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: ' 50 box',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff64748B),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
               Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: '14h',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontColor: Color(0xff475569),
                  ),
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                   Image.asset(
                    'assets/images/ic_three_dot.png',
                    width: 20,
                    height: 20,
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
    );
  }
}
