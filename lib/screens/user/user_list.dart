import 'dart:io';

import 'package:cold_storage_flutter/models/home/user_list_model.dart';
import 'package:cold_storage_flutter/res/components/cards/user_info_card.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user/userlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../view_models/services/app_services.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

  final UserlistViewModel controller = Get.put(UserlistViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: bottomGestureButtons,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        exit(0);
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 20,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'User List',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: controller.logoUrl.value.isNotEmpty
                                  ? NetworkImage(controller.logoUrl.value)
                                  : const AssetImage(
                                      'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'none', y: 'smm'),
          child: Column(
            children: [
              App.appSpacer.vHs,
              Obx(
                () => ListView.builder(
                  padding: App.appSpacer.edgeInsets.all.xs,
                  itemCount: controller.userList!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    UsersList user = controller.userList![index];

                    return UserInfoCardView(
                      cardWidth: App.appQuery.responsiveWidth(50),
                      cardHeight: App.appQuery.responsiveWidth(60),
                      user: user,
                    );
                  },
                ),
              ),
              _leftUserWarning,
              App.appSpacer.vHxxsl,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _leftUserWarning {
    return Obx(() {
      if (controller.userLeftCount.value > 0) {
        return Column(
          children: [
            App.appSpacer.vHs,
            CustomTextField(
                textAlign: TextAlign.center,
                text:
                    '${controller.userLeftCount.value}/${controller.totalUserCount.value} seats available',
                fontSize: 15.0,
                fontColor: kAppBlack,
                fontWeight: FontWeight.w500),
            App.appSpacer.vHs,
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget get bottomGestureButtons {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            if (controller.userLeftCount.value > 0)
              Get.toNamed(RouteName.createUserView)
            else
              {Utils.isCheck = true, Utils.snackBar('Error', 'No user left')}
          },
          text: 'Add User',
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Get.offNamed(RouteName.newEntityListScreen, arguments: [
              {"EOB": 'NEW'}
            ])!
                .then((value) {})
          },
          text: 'Continue',
        )
      ],
    );
  }
}
