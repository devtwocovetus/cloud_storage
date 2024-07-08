import 'dart:developer';

import 'package:cold_storage_flutter/res/assets/image_assets.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/divider/dash_line_divider.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:reusable_components/reusable_components.dart';
import '../dropdown/my_custom_drop_down.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key, this.screenCode = 1});

  final int screenCode;
  @override
  Widget build(BuildContext context) {
    return _drawerSlider;
  }


  Widget get _drawerSlider{
    return Container(
      decoration: const BoxDecoration(
          color: kAppDrawerBackground
      ),
      padding: App.appSpacer.edgeInsets.x.s,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                            },
                            icon: Image.asset(
                              height: 35,
                              width: 35,
                              'assets/images/ic_user_defualt.png',
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 45,
                        child: MyCustomDropDown<String>(
                          itemList: const ['Hindi','English'],
                          initialValue: 'English',
                          hintText: 'Select Language',
                          validator: (value) {
                            return null;
                          },
                          onChange: (item) {
                            log('changing value to: $item');
                            // controller.managerNameC = item ?? '';
                          },
                          validateOnChange: true,
                        ),
                      ),
                    ),
                  ],
                ),
                App.appSpacer.vHsm,
                screenCode == 1 ? _entityGestures()
                :screenCode == 2 ? _assetGestures()
                :screenCode == 3 ? _clientGestures()
                :_materialGestures(),
                App.appSpacer.vHxs,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DashLineSeparator(
                  height: 1,
                  color: Colors.white,
                  dashWidth: 3,
                ),
                App.appSpacer.vHxs,
                if(screenCode != 1)
                  _otherTileView(
                      tileName: 'Entity Management',
                      iconPath: ImageAssets.drawerEntityIcon,
                      onTap: () {

                      }
                  ),
                if(screenCode != 2)
                  _otherTileView(
                      tileName: 'Asset Management',
                      iconPath: ImageAssets.drawerAssetIcon,
                      onTap: () {

                      }
                  ),
                if(screenCode != 3)
                  _otherTileView(
                      tileName: 'Client Management',
                      iconPath: ImageAssets.drawerClientIcon,
                      onTap: () {

                      }
                  ),
                if(screenCode != 4)
                  _otherTileView(
                      tileName: 'Material Management',
                      iconPath: ImageAssets.drawerMaterialIcon,
                      onTap: () {

                      }
                  ),
                App.appSpacer.vHxs,
                const DashLineSeparator(
                  height: 1,
                  color: Colors.white,
                  dashWidth: 3,
                ),
                App.appSpacer.vHxs,
                _bottomProfileTile
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _entityGestures(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _currentViewMainTile(
          iconPath: ImageAssets.homeIcon,
          tileName: 'Entity Management',
          subTileName: 'Entity Management',
        ),
        App.appSpacer.vHxs,
        // Container(
        //   height: 300,
        //   child: ListView(
        //     shrinkWrap: true,
        //     physics: BouncingScrollPhysics(),
        //     children: [
        _currentViewChildTile(
            tileName: 'Inventory',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material In',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material Out',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Adjust Material',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _assetGestures(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _currentViewMainTile(
          iconPath: ImageAssets.homeIcon,
          tileName: 'Asset Management',
          subTileName: 'Asset Management',
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Inventory',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material In',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material Out',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Adjust Material',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
      ],
    );
  }

  Widget _clientGestures(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _currentViewMainTile(
          iconPath: ImageAssets.homeIcon,
          tileName: 'Client Management',
          subTileName: 'Client Management',
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Inventory',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material In',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material Out',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Adjust Material',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
      ],
    );
  }

  Widget _materialGestures(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _currentViewMainTile(
          iconPath: ImageAssets.homeIcon,
          tileName: 'Material Management',
          subTileName: 'Material Management',
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Inventory',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material In',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Material Out',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
        App.appSpacer.vHxs,
        _currentViewChildTile(
            tileName: 'Adjust Material',
            iconPath: ImageAssets.homeIcon,
            onTap: () {

            }
        ),
      ],
    );
  }

  Widget _currentViewMainTile({required String tileName, required String subTileName, required String iconPath}){
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 45,
        width: 45,
        padding: App.appSpacer.edgeInsets.all.xs,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10)
        ),
        child: SVGAssetImage(
          height: 25,
          width: 25,
          url: iconPath,
          fit: BoxFit.cover,
        ),
      ),
      title: CustomTextField(
          textAlign: TextAlign.left,
          text: tileName,
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          fontColor: kAppWhite
      ),
      subtitle: CustomTextField(
          textAlign: TextAlign.left,
          text: subTileName,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          fontColor: kAppWhite
      ),
      titleAlignment: ListTileTitleAlignment.titleHeight,
    );
  }

  Widget _currentViewChildTile({required String tileName, required String iconPath, required VoidCallback onTap}){
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        dense: true,
        // contentPadding: App.appQuery.responsiveWidth(percentage),
        leading: Container(
          height: 35,
          width: 35,
          padding: App.appSpacer.edgeInsets.all.xs,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5)
          ),
          child: SVGAssetImage(
            height: 25,
            width: 25,
            url: iconPath,
            fit: BoxFit.cover,
          ),
        ),
        title: CustomTextField(
            textAlign: TextAlign.left,
            text: tileName,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            fontColor: kAppWhite
        ),
        titleAlignment: ListTileTitleAlignment.titleHeight,
      ),
    );
  }

  Widget _otherTileView({required String tileName, required String iconPath, required VoidCallback onTap}){
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        dense: true,
        contentPadding: App.appSpacer.edgeInsets.x.xxs,
        leading: SizedBox(
          height: 25,
          width: 25,
          child: SVGAssetImage(
            url: iconPath,
            fit: BoxFit.cover,
          ),
        ),
        title: CustomTextField(
            textAlign: TextAlign.center,
            text: tileName,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontColor: kAppWhite
        ),
        titleAlignment: ListTileTitleAlignment.center,
        trailing: const SVGAssetImage(
          height: 20,
          width: 20,
          url: ImageAssets.linkIcon,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget get _bottomProfileTile{
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {

        },
        contentPadding: App.appSpacer.edgeInsets.x.xxs,
        leading: Container(
          height: 45,
          width: 45,
          padding: App.appSpacer.edgeInsets.all.xs,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: const SVGAssetImage(
            height: 25,
            width: 25,
            url: ImageAssets.homeIcon,
            fit: BoxFit.cover,
          ),
        ),
        title: const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Michael Smith',
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontColor: kAppWhite
        ),
        subtitle: const CustomTextField(
            textAlign: TextAlign.left,
            text: 'michaelsmith12@gmail.com',
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            fontColor: kAppWhite
        ),
        titleAlignment: ListTileTitleAlignment.center,
      ),
    );
  }
}
