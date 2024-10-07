import 'package:cold_storage_flutter/res/components/drawer/custom_app_drawer.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class EntityListDemo extends StatelessWidget {
  EntityListDemo({super.key});

  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
  GlobalKey<SliderDrawerState>();
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
      translation = i18n.Translations.of(context);
    return Scaffold(
      body: SliderDrawer(
        key: _sliderDrawerKey,
        appBar: SliderAppBar(
          appBarHeight: 90,
          appBarPadding: App.appSpacer.edgeInsets.top.md,
          appBarColor: Colors.white,
          drawerIcon: Padding(
            padding: App.appSpacer.edgeInsets.top.sm,
            child: IconButton(
              onPressed: () {
                _sliderDrawerKey.currentState!.toggle();
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
            child:  CustomTextField(
              textAlign: TextAlign.left,
              text: translation.entity_details,
              fontSize: 18.0,
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
                    height: 25,
                    width: 25,
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
                    // Get.toNamed(RouteName.notificationList)!.then((value) {});
                  },
                  icon: Image.asset(
                    height: 25,
                    width: 25,
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
              )
            ],
          ),
        ),
        slider: const CustomAppDrawer(screenCode: 1,),
        child: Container(),
      ),
    );
  }
}
