import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/cards/base_card_view.dart';
import 'package:cold_storage_flutter/res/components/divider/basic_divider.dart';
import 'package:cold_storage_flutter/view_models/controller/entity/entityonboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/routes/routes_name.dart';
import '../../res/variables/var_string.dart';
import '../../view_models/services/app_services.dart';

class EntityOnboarding extends StatefulWidget {
  const EntityOnboarding({super.key});
  @override
  State<EntityOnboarding> createState() => _EntityOnboardingState();
}

class _EntityOnboardingState extends State<EntityOnboarding> {
  final entityOnboardingViewModel = Get.put(EntityonboardingViewModel());
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
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Select Your Entity!',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: entityOnboardingViewModel.logoUrl.value.isNotEmpty
                                  ? NetworkImage(entityOnboardingViewModel.logoUrl.value)
                                  : const AssetImage(
                                      'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Obx(
        () => Padding(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'sm', y: 'smm'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Column(
                children: [
                  BaseCardView(
                    cardHeight: 185,
                    cardWidth: 385,
                    backgroundColor: kCardBackground,
                    image: wareHouseImage2,
                    heading: 'Cold Storage | Warehouse',
                    subHeading: 'Unlock all Lorem ipsum dolor sit amet,',
                    sub2Heading: 'consectetur adipiscing elit.',
                    onTap: () {

                      Get.toNamed(RouteName.createWarehouse);


                      // entityOnboardingViewModel.userOption(0);

                    },
                    isActive: entityOnboardingViewModel.isColdWarehouse.value,
                  ),
                  BasicDivider(width: App.appQuery.responsiveWidth(75)),
                  BaseCardView(
                    cardHeight: 185,
                    cardWidth: 385,
                    backgroundColor: kCardBackground,
                    image: wareHouseImage2,
                    heading: 'Farm | Grower',
                    subHeading: 'Unlock all Lorem ipsum dolor sit amet,',
                    sub2Heading: 'consectetur adipiscing elit.',
                    onTap: () {

                      Get.toNamed(RouteName.createFarmhouse);

                      // entityOnboardingViewModel.userOption(1);

                    },
                    isActive: entityOnboardingViewModel.isFarmGrower.value,
                  ),
                ],
              ),
              // MyCustomButton(
              //   backgroundColor: entityOnboardingViewModel.btnStatus.value
              //             ? const Color(0xFF005AFF)
              //             : const Color(0xFF005AFF).withOpacity(0.2),
              //   width: App.appQuery.responsiveWidth(85) /*312.0*/,
              //   height: 48.0,
              //   borderRadius: BorderRadius.circular(10.0),
              //   onPressed: () => {
              //     // Get.toNamed(RouteName.createWarehouse),
              //   },
              //   text: 'Continue',
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
