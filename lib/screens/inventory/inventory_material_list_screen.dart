import 'dart:developer';

import 'package:cold_storage_flutter/models/inventory/inventory_client_list_model.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_material_list_model.dart';
import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_client_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_material_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/material/materiallist_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/dropdown/model/dropdown_item_model.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class InventoryMaterialListScreen extends StatefulWidget {
  const InventoryMaterialListScreen({super.key});

  @override
  State<InventoryMaterialListScreen> createState() =>
      _InventoryMaterialListScreenState();
}

class _InventoryMaterialListScreenState
    extends State<InventoryMaterialListScreen> {
  final inventoryMaterialViewModel = Get.put(InventoryMaterialViewModel());
  final emailController = TextEditingController();

   late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Image.asset(
                          height: 15,
                          width: 10,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )
                    ),
                    Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: Utils.textCapitalizationString(
                              inventoryMaterialViewModel.entityName.value),
                          fontSize: 18.0,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                   
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
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
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.toNamed(RouteName.notificationList)!.then((value) {});
                          },
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(()=> IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                              url: UserPreference.profileLogo.value
                          )
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
                Utils.deviceWidth(context) * 0.03, 0),
            child:  Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.inventory,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
          App.appSpacer.vHs,
          Padding(
            padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
                Utils.deviceWidth(context) * 0.03, 0),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: CustomSearchField(
                      margin: App.appSpacer.edgeInsets.x.none,
                      searchController: inventoryMaterialViewModel.searchController.value,
                      prefixIconVisible: true,
                      filled: true,
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          inventoryMaterialViewModel.searchFilter('');
                        } else if (value.isNotEmpty) {
                          inventoryMaterialViewModel.searchFilter(value);
                        }
                      },
                      onSubmit: (value) async {
                        if (value.isEmpty) {
                          inventoryMaterialViewModel.searchFilter('');
                        } else if (value.isNotEmpty) {
                          inventoryMaterialViewModel.searchFilter(value);
                        }
                      },
                      onCrossTapped: () {
                        inventoryMaterialViewModel.searchFilter('');
                        inventoryMaterialViewModel.searchController.value.clear();
                      },
                    )
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    decoration: const BoxDecoration(
                        color: Color(0xFFEFF8FF),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: sortingDropdown(),
                  ),
                ),
              ],
            ),
          ),
          App.appSpacer.vHs,
         Expanded(
              child: !inventoryMaterialViewModel.isLoading.value ? inventoryMaterialViewModel.materialList!.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          inventoryMaterialViewModel.materialList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return clientViewTile(index, context,
                            inventoryMaterialViewModel.materialList![index]);
                      })
                  : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                           CustomTextField(
                              textAlign: TextAlign.center,
                              text: translation.no_inventory_found,
                              fontSize: 18.0,
                              fontColor: Color(0xFF000000),
                              fontWeight: FontWeight.w500
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ) : const SizedBox.expand(),
            ),

        ],
      ))),
    );
  }

  Widget sortingDropdown(){
    return MyCustomDropDown<DropdownItemModel>(
      itemList: inventoryMaterialViewModel.sortingItems,
      hintText: translation.sort_by,
      hintFontSize: 13.5,
      enableBorder: false,
      padding: App.appSpacer.edgeInsets.symmetric(x: 'xs',y: 's'),
      validateOnChange: true,
      headerBuilder: (context, selectedItem, enabled) {
        return Text(selectedItem.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(textStyle: const TextStyle(color: kAppBlack,fontWeight: FontWeight.w400,fontSize: 14.0)),
        );
      },
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(item.title,
          style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.6),fontWeight: FontWeight.w400,fontSize: 14.0)),
        );
      },
      onChange: (item) {
        log('changing value to: $item');
        if(item != null){
          inventoryMaterialViewModel.sortListByProperty(item);
        }
      },
    );
  }

  Widget get _emptyView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/ic_blank_list.png'),
          const SizedBox(
            height: 10,
          ),
           CustomTextField(
              textAlign: TextAlign.center,
              text: translation.no_inventory_found,
              fontSize: 18.0,
              fontColor: Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ],
      ),
    );
  }

  Widget clientViewTile(
      int index, BuildContext context, InventoryMaterial inventoryMaterial) {
    return GestureDetector(
      onTap: () => {
        // Get.toNamed(RouteName.inventoryUnitListScreen, arguments: [
        //   {
        //     "materialId":inventoryMaterial.materialId.toString(),
        //     "materialName":inventoryMaterial.materialName.toString(),
        //     "entityName": inventoryMaterialViewModel.entityName.value,
        //     "entityId":inventoryMaterialViewModel.entityId.value,
        //     "entityType":inventoryMaterialViewModel.entityType.value,
        //     ///Need to work on
        //     // "clientId":inventoryMaterialViewModel.clientId.value,
        //   }
        // ])

        Get.toNamed(RouteName.inventoryTransactionsListScreen, arguments: [
          {
            "materialId":inventoryMaterial.materialId.toString(),
            "unitId":inventoryMaterial.unitId.toString(),
            "categoryId":inventoryMaterial.categoryId.toString(),
            "unitName":inventoryMaterial.unitName.toString(),
            "entityName": inventoryMaterialViewModel.entityName.value,
            "entityId":inventoryMaterialViewModel.entityId.value,
            "entityType":inventoryMaterialViewModel.entityType.value,
          }
        ])
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
            Utils.deviceWidth(context) * 0.03,
            0,
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03),
        padding: EdgeInsets.fromLTRB(
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: index % 2 == 0
              ? const Color(0xffEFF8FF)
              : const Color(0xffFFFFFF),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.material,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xffAEAEAE),
                      ),
                      App.appSpacer.vHxxxs,
                      CustomTextField(
                        textAlign: TextAlign.left,
                        isMultyline: true,
                        line: 3,
                        text: Utils.textCapitalizationString(inventoryMaterial.materialName.toString()),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff1a1a1a),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: App.appSpacer.edgeInsets.x.xs,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.category,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xffAEAEAE),
                        ),
                        App.appSpacer.vHxxxs,
                        CustomTextField(
                          textAlign: TextAlign.left,
                          isMultyline: true,
                          line: 3,
                          text: Utils.textCapitalizationString(
                              inventoryMaterial.categoryName.toString()),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff1a1a1a),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.quantity,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xffAEAEAE),
                      ),
                      App.appSpacer.vHxxxs,
                      CustomTextField(
                        textAlign: TextAlign.left,
                        isMultyline: true,
                        line: 3,
                        text: Utils.textCapitalizationString(
                            inventoryMaterial.totalQuantity.toString()),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff1a1a1a),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
          ],
        ),
      ),
    );
  }

  toggleDone(bool bool) {}
}
