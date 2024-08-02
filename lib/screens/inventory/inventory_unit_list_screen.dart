
import 'package:cold_storage_flutter/models/inventory/inventory_units_list_model.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_client_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/inventory/inventory_units_view_model.dart';

class InventoryUnitListScreen extends StatefulWidget {
  const InventoryUnitListScreen({super.key});

  @override
  State<InventoryUnitListScreen> createState() =>
      _InventoryUnitListScreenState();
}

class _InventoryUnitListScreenState
    extends State<InventoryUnitListScreen> {
    final inventoryUnitsViewModel = Get.put(InventoryUnitsViewModel());
  final emailController = TextEditingController();

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
                padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03,
                    0, Utils.deviceWidth(context) * 0.03, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        height: 20,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomTextField(
                        textAlign: TextAlign.center,
                        text: Utils.textCapitalizationString(inventoryUnitsViewModel.entityName.value),
                        fontSize: 18.0,
                        fontColor: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
                Utils.deviceWidth(context) * 0.03, 0),
            child: Row(
              children: [
                CustomTextField(
                  text:
                      'Inventory (${Utils.textCapitalizationString(inventoryUnitsViewModel.materialName.value)})',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: const Color(0xff000000),
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
                SizedBox(
                  width: 195,
                  height: 37,
                  child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon:
                            Image.asset('assets/images/ic_search_field.png'),
                        hintText: "Search Here. . .",
                        filled: true,
                        fillColor: const Color(0xffEFF8FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      )),
                ),
                const Spacer(),
                Container(
                  width: 133,
                  height: 37,
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
              ],
            ),
          ),
          App.appSpacer.vHs,
          Obx(
            () => Expanded(
              child: inventoryUnitsViewModel.unitList!.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          inventoryUnitsViewModel.unitList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return clientViewTile(index, context,
                            inventoryUnitsViewModel.unitList![index]);
                      })
                  : Container()
            ),
          )
        ],
      )),
    );
  }

  Widget clientViewTile(
      int index, BuildContext context, InventoryUnit inventoryUnit) {
    return GestureDetector(
     onTap: () => {
        Get.toNamed(RouteName.inventoryTransactionsListScreen, arguments: [
          {
            "materialId":inventoryUnit.materialId.toString(),
            "unitId":inventoryUnit.unitId.toString(),
            "categoryId":inventoryUnit.categoryId.toString(),
            "unitName":inventoryUnit.unitName.toString(),
            "entityName": inventoryUnitsViewModel.entityName.value,
            "entityId":inventoryUnitsViewModel.entityId.value,
            "entityType":inventoryUnitsViewModel.entityType.value
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
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.35,
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Unit Name',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Type',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.27,
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Quantity',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
              ],
            ),
            App.appSpacer.vHxxxs,
            Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.35,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        inventoryUnit.unitName.toString()),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        inventoryUnit.mouType.toString()),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.27,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        inventoryUnit.totalQuantity.toString()),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
              ],
            ),
             App.appSpacer.vHs,
            Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.35,
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Category',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.40,
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'UOM',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                
              ],
            ),
            App.appSpacer.vHxxxs,
            Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.35,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        inventoryUnit.categoryName.toString()),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.40,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        inventoryUnit.mouName.toString()),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
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
