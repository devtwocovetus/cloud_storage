import 'package:cold_storage_flutter/res/components/cards/user_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../view_models/services/app_services.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: bottomGestureButtons,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'none',y: 'smm'),
          child: Column(
            children: [
              App.appSpacer.vHxs,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: App.appSpacer.edgeInsets.symmetric(x: 'smmm',y: 'none'),
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'User List',
                    fontSize: 20.0,
                    fontColor: kAppBlack,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              App.appSpacer.vHs,
              ListView.builder(
                padding: App.appSpacer.edgeInsets.all.xs,
                itemCount: 2,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if(index==0){
                    return UserInfoCardView(
                      cardWidth: App.appQuery.responsiveWidth(50),
                      cardHeight: App.appQuery.responsiveWidth(60),
                      isCardEnable: false
                    );
                  }
                  return UserInfoCardView(
                    cardWidth: App.appQuery.responsiveWidth(50),
                    cardHeight: App.appQuery.responsiveWidth(60),
                    isCardEnable: true
                  );
                },
              ),
              App.appSpacer.vHs,
              _leftUserWarning,
              App.appSpacer.vHs,
              App.appSpacer.vHxxsl,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _leftUserWarning{
    return const CustomTextField(
      textAlign: TextAlign.center,
      text: '1 User Left',
      fontSize: 15.0,
      fontColor: kAppBlack,
      fontWeight: FontWeight.w500
    );
  }

  Widget get bottomGestureButtons{
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35)/*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {

          },
          text: 'Add User',
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35)/*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {

          },
          text: 'Continue',
        )
      ],
    );
  }
}
