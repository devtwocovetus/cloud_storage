import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/res/components/drawer/custom_app_drawer.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/materiallist_view_model.dart';

import '../../res/components/search_field/custom_search_field.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class MaterialListScreen extends StatefulWidget {
  const MaterialListScreen({super.key});

  @override
  State<MaterialListScreen> createState() => _MaterialListScreenState();
}

class _MaterialListScreenState extends State<MaterialListScreen> {
  final materialListViewModel = Get.put(MateriallistViewModel());
  final emailController = TextEditingController();
  final _materialDrawerKey = GlobalKey<SliderDrawerState>();

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    double fullWidth = Utils.deviceWidth(context) * 0.9;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      // appBar: PreferredSize(
      //     preferredSize: const Size.fromHeight(80),
      //     child: SafeArea(
      //       child: Container(
      //         height: 60,
      //         decoration: const BoxDecoration(
      //           color: Colors.white,
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                 onTap: () => {Get.back()},
      //                 child: Image.asset(
      //                   height: 15,
      //                   width: 10,
      //                   'assets/images/ic_sidemenu_icon.png',
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 15,
      //               ),
      //               const CustomTextField(
      //                   textAlign: TextAlign.center,
      //                   text: 'Material',
      //                   fontSize: 18.0,
      //                   fontColor: Color(0xFF000000),
      //                   fontWeight: FontWeight.w500),
      //               const Spacer(),
      //               GestureDetector(
      //                 onTap: () {
      //                   Get.until((route) =>
      //                       Get.currentRoute == RouteName.homeScreenView);
      //                 },
      //                 child: Image.asset(
      //                   height: 20,
      //                   width: 20,
      //                   'assets/images/ic_home_icon.png',
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 15,
      //               ),
      //               Image.asset(
      //                 height: 20,
      //                 width: 20,
      //                 'assets/images/ic_notification_bell.png',
      //                 fit: BoxFit.cover,
      //               ),
      //               const SizedBox(
      //                 width: 15,
      //               ),
      //               Container(
      //                   width: 25.0,
      //                   height: 25.0,
      //                   decoration: const BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     image: DecorationImage(
      //                         fit: BoxFit.fitWidth,
      //                         image: AssetImage(
      //                             'assets/images/ic_user_defualt.png')),
      //                   ))
      //             ],
      //           ),
      //         ),
      //       ),
      //     )),
      body: SliderDrawer(
        key: _materialDrawerKey,
        appBar: SliderAppBar(
          appBarHeight: 90,
          appBarPadding: App.appSpacer.edgeInsets.top.md,
          appBarColor: Colors.white,
          drawerIcon: Padding(
            padding: App.appSpacer.edgeInsets.top.sm,
            child: IconButton(
                onPressed: () {
                  _materialDrawerKey.currentState!.toggle();
                },
                icon: Image.asset(
                  height: 20,
                  width: 20,
                  'assets/images/ic_sidemenu_icon.png',
                  fit: BoxFit.cover,
                )),
          ),
          isTitleCenter: false,
          title: Padding(
            padding: App.appSpacer.edgeInsets.top.sm,
            child: const CustomTextField(
                textAlign: TextAlign.left,
                text: 'Material',
                fontSize: 18.0,
                fontColor: Color(0xFF000000),
                fontWeight: FontWeight.w500),
          ),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.until((route) =>
                          Get.currentRoute == RouteName.homeScreenView);
                    },
                    icon: const SVGAssetImage(
                      height: 20,
                      width: 20,
                      url: 'assets/images/default/ic_home.svg',
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: App.appSpacer.edgeInsets.top.sm,
                child: Obx(
                  () => IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // _sliderDrawerKey.currentState!.toggle();
                      },
                      icon: AppCachedImage(
                          roundShape: true,
                          height: 20,
                          width: 20,
                          url: UserPreference.profileLogo.value)),
                ),
              ),
              App.appSpacer.vWxxs
            ],
          ),
        ),
        slider: const CustomAppDrawer(
          screenCode: 4,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (Utils.decodedMap['add_material'] == true) ...[
                Padding(
                  padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 10, Utils.deviceWidth(context) * 0.03, 0),
                  child: Row(
                    children: [
                      const CustomTextField(
                        text: 'Add New Material',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff000000),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteName.createMaterialScreen);
                        },
                        child: Image.asset(
                            width: 30,
                            height: 30,
                            'assets/images/ic_add_new.png'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
              Padding(
                padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0, Utils.deviceWidth(context) * 0.03, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 6,
                        child: CustomSearchField(
                          margin: App.appSpacer.edgeInsets.x.none,
                          searchController: TextEditingController(),
                          prefixIconVisible: true,
                          filled: true,
                        )
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        decoration: const BoxDecoration(
                            color: Color(0xFFEFF8FF),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: const CustomTextField(
                              text: 'Sort By',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontColor: Color(0xff828282),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Expanded(
                  child: !materialListViewModel.isLoading.value
                      ? materialListViewModel.materialList!.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(
                                  fullWidth * 0.05, 0, fullWidth * 0.05, 0),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: materialListViewModel
                                      .materialList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return listItem(
                                        materialListViewModel
                                            .materialList![index],
                                        index);
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            'assets/images/ic_blank_list.png'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const CustomTextField(
                                            textAlign: TextAlign.center,
                                            text: 'No Material Found',
                                            fontSize: 18.0,
                                            fontColor: Color(0xFF000000),
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                  if (Utils.decodedMap['add_material'] ==
                                      true) ...[
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: MyCustomButton(
                                        height:
                                            Utils.deviceHeight(context) * 0.06,
                                        padding:
                                            Utils.deviceWidth(context) * 0.10,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        onPressed: () => {
                                          Get.toNamed(
                                              RouteName.createMaterialScreen)
                                        },
                                        text: 'Add Material',
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            )
                      : const SizedBox.expand(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(MaterialItem material, int ind) {
    double fullWidth = Utils.deviceWidth(context) * 0.9;

    return GestureDetector(
      onTap: () => {
        // if (Utils.decodedMap['view_material_unit'] == true)
        //   {
        //     Get.toNamed(RouteName.materialUnitListScreen, arguments: [
        //       {
        //         "MaterialName": material.name,
        //         "MaterialNameId": material.id.toString(),
        //         "MaterialCategory": material.categoryName,
        //         "MaterialCategoryId": material.categoryId.toString(),
        //         "MaterialDescription": material.description,
        //         "MOUValue": material.mouValue.toString(),
        //         "MOUType": material.mouType.toString(),
        //         "MOUID": material.mouId.toString(),
        //         "MOUNAME": material.mouName,
        //       }
        //     ])
        //   }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(fullWidth * 0.05, fullWidth * 0.025,
            fullWidth * 0.05, fullWidth * 0.025),
        decoration: BoxDecoration(
            color: ind % 2 == 0
                ? const Color(0xffEFF8FF)
                : const Color(0xffFFFFFF),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
             SizedBox(
              width: fullWidth * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Name',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff000000),
                  ),
                  App.appSpacer.vHxs,
                  CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        material.name.toString()),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff074173),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: fullWidth * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Category',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff000000),
                  ),
                  App.appSpacer.vHxs,
                  CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        material.categoryName.toString()),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff074173),
                  ),
                ],
              ),
            ),
           
            if (Utils.decodedMap['edit_material'] == true ||
                Utils.decodedMap['delete_material'] == true) ...[
              SizedBox(
                width: fullWidth * 0.20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Action',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff000000),
                    ),
                    App.appSpacer.vHxs,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (Utils.decodedMap['delete_material'] == true) ...[
                          GestureDetector(
                            onTap: () {
                              DialogUtils.showDeleteConfirmDialog(
                                context,
                                okBtnFunction: () {
                                  Get.back(closeOverlays: true);
                                  materialListViewModel
                                      .deleteMaterial(material.id.toString());
                                },
                              );
                            },
                            child: Image.asset(
                                height: 20,
                                width: 20,
                                'assets/images/ic_delete_dark_blue.png'),
                          ),
                        ],
                        if (Utils.decodedMap['delete_material'] == true &&
                            Utils.decodedMap['edit_material'] == true) ...[
                          SizedBox(
                            width: fullWidth * 0.025,
                          ),
                          const CustomTextField(
                            textAlign: TextAlign.center,
                            text: '|',
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                            fontColor: Color(0xff9CBFFF),
                          ),
                          SizedBox(
                            width: fullWidth * 0.015,
                          ),
                        ],
                        if (Utils.decodedMap['edit_material'] == true) ...[
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteName.updateMaterialScreen,
                                  arguments: jsonEncode(material.toJson()));
                            },
                            child: Image.asset(
                                height: 20,
                                width: 20,
                                'assets/images/ic_edit_dark_blue.png'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  toggleDone(bool bool) {}
}
