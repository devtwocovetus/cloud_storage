import 'package:cold_storage_flutter/res/components/drawer/custom_app_drawer.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';

class EntityDashboard extends StatelessWidget {
  EntityDashboard({super.key});

  final GlobalKey<SliderDrawerState> _entityDrawerKey =
  GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        key: _entityDrawerKey,
        appBar: SliderAppBar(
          appBarHeight: 100,
          appBarPadding: App.appSpacer.edgeInsets.top.md,
          appBarColor: Colors.white,
          drawerIcon: Padding(
            padding: App.appSpacer.edgeInsets.top.sm,
            child: IconButton(
                onPressed: () {
                  _entityDrawerKey.currentState!.toggle();
                },
                icon: Image.asset(
                  height: 20,
                  width: 20,
                  'assets/images/ic_sidemenu_icon.png',
                  fit: BoxFit.cover,
                )
            ),
          ),
          isTitleCenter: false,
          title: Padding(
            padding: App.appSpacer.edgeInsets.top.sm,
            child: const CustomTextField(
                textAlign: TextAlign.left,
                text: 'Dashboard',
                fontSize: 20.0,
                fontColor: Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
                child: IconButton(
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: const SVGAssetImage(
                      height: 20,
                      width: 20,
                      url: 'assets/images/default/ic_home.svg',
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
                child: IconButton(
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
                child: IconButton(
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: Image.asset(
                      height: 25,
                      width: 25,
                      'assets/images/ic_user_defualt.png',
                      fit: BoxFit.cover,
                    )
                ),
              ),
              App.appSpacer.vWxxs
            ],
          ),
        ),
        slider: const CustomAppDrawer(screenCode: 1,),
        child: SingleChildScrollView(
          padding: App.appSpacer.edgeInsets.x.sm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _pageHeadingWidget,
              GridView.count(
                padding: App.appSpacer.edgeInsets.y.sm,
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                crossAxisSpacing: App.appSpacer.lg,
                mainAxisSpacing: App.appSpacer.spacer_28,
                physics: const AlwaysScrollableScrollPhysics(),
                childAspectRatio: App.appQuery.width /
                    (App.appQuery.height / 6),
                children: [
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {

                    },
                    fontWeight: FontWeight.w600,
                    text: 'Material In',
                  ),
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {

                    },
                    fontWeight: FontWeight.w600,
                    text: 'Material Out',
                  ),
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {

                    },
                    fontWeight: FontWeight.w600,
                    text: 'Adjust',
                  ),
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {

                    },
                    fontWeight: FontWeight.w600,
                    text: 'Add Material',
                  ),
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {

                    },
                    fontWeight: FontWeight.w600,
                    text: 'View Inventory',
                  ),
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {

                    },
                    fontWeight: FontWeight.w600,
                    text: 'Add Category',
                  ),
                  MyCustomButton(
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {

                    },
                    text: 'Transfer',
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _pageHeadingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.y.s,
      child: const CustomTextField(
          textAlign: TextAlign.left,
          text: 'Central Hub Warehousing',
          fontSize: 17.0,
          fontColor: kAppBlack,
          fontWeight: FontWeight.w500
      ),
    );
  }
}
