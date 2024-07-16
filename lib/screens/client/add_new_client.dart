import 'package:cold_storage_flutter/res/components/search_field/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/drawer/custom_app_drawer.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../view_models/services/app_services.dart';

class AddNewClient extends StatelessWidget {
  AddNewClient({super.key});

  final GlobalKey<SliderDrawerState> _materialOutDrawerKey =
  GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
          key: _materialOutDrawerKey,
          appBar: SliderAppBar(
            appBarHeight: 100,
            appBarPadding: App.appSpacer.edgeInsets.top.md,
            appBarColor: Colors.white,
            drawerIcon: Padding(
              padding: App.appSpacer.edgeInsets.top.sm,
              child: IconButton(
                  onPressed: () {
                    _materialOutDrawerKey.currentState!.toggle();
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
                  text: 'Add New Client',
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
                  child: /*Obx(()=>*/
                  IconButton(
                      onPressed: () {
                        // _sliderDrawerKey.currentState!.toggle();
                      },
                      icon: const AppCachedImage(
                          roundShape: true,
                          height: 30,
                          width: 30,
                          url: 'controller.logoUrl.value'
                      )
                  ),
                  // )
                ),
                App.appSpacer.vWxxs
              ],
            ),
          ),
          slider: const CustomAppDrawer(screenCode: 3,),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: App.appSpacer.edgeInsets.y.smm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchField(searchController: TextEditingController(),),
              ],
            ),
          )
      ),
    );
  }
}
