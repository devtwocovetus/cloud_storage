import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/cards/base_card_view.dart';
import 'package:cold_storage_flutter/res/components/divider/basic_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/routes/routes_name.dart';
import '../../res/variables/var_string.dart';
import '../../view_models/services/app_services.dart';

class EntityOnboarding extends StatelessWidget {
  const EntityOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'sm',y: 'smm'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Select Your Entity!',
                  fontSize: 20.0,
                  fontColor: kAppBlack,
                  fontWeight: FontWeight.w500
                ),
              ),
              Column(
                children: [
                  BaseCardView(
                    cardHeight: App.appQuery.responsiveWidth(55),
                    cardWidth: App.appQuery.responsiveWidth(85),
                    backgroundColor: kCardBackground,
                    image: wareHouseImage2,
                    heading: 'Cold Storage | Warehouse',
                    subHeading: 'Unlock all Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    onTap: () {
                      Get.toNamed(RouteName.createWarehouse);

                    },
                  ),
                  BasicDivider(width: App.appQuery.responsiveWidth(75)),
                  BaseCardView(
                    cardHeight: App.appQuery.responsiveWidth(55),
                    cardWidth: App.appQuery.responsiveWidth(85),
                    backgroundColor: kCardBackground,
                    image: wareHouseImage2,
                    heading: 'Farm | Grower',
                    subHeading: 'Unlock all Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    onTap: () {
                      Get.toNamed(RouteName.createFarmhouse);
                    },
                  ),
                ],
              ),
              MyCustomButton(
                width: App.appQuery.responsiveWidth(85)/*312.0*/,
                height: 48.0,
                borderRadius: BorderRadius.circular(10.0),
                onPressed: () => {
                  // Get.toNamed(RouteName.createWarehouse),
                },
                text: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
