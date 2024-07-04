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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'none', y: 'smm'),
          child: Column(
            children: [
              controller.logoUrl.value.isNotEmpty
                      ? const SizedBox(
                          height: 22.0,
                        )
                      : Container(),
                  controller.logoUrl.value.isEmpty
                      ? Container()
                      : Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                    controller.logoUrl.value)),
                          )),
                
              App.appSpacer.vHxs,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      App.appSpacer.edgeInsets.symmetric(x: 'smmm', y: 'none'),
                  child: const CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'User List',
                      fontSize: 20.0,
                      fontColor: kAppBlack,
                      fontWeight: FontWeight.w500),
                ),
              ),
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
      if (controller.userLeftCount.value > 0){
        return Column(
          children: [
            App.appSpacer.vHs,
            CustomTextField(
                textAlign: TextAlign.center,
                text: '${controller.userLeftCount.value} User Left',
                fontSize: 15.0,
                fontColor: kAppBlack,
                fontWeight: FontWeight.w500
            ),
            App.appSpacer.vHs,
          ],
        );
      }else{
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
              {Utils.snackBar('Error', 'No user left')}
          },
          text: 'Add User',
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Get.toNamed(RouteName.entityOnboarding)!.then((value) {})
          },
          text: 'Continue',
        )
      ],
    );
  }
}
