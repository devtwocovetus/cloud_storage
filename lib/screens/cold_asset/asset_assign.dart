import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/category/categoryadd_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_assign_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/asset_category_add_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

class AssetAssign extends StatefulWidget {
  const AssetAssign(
      {super.key,
      required this.assetId,
      required this.locationId,
      required this.locationType,
      required this.locationName});
  final String assetId;
  final String locationId;
  final String locationType;
  final String locationName;

  @override
  State<AssetAssign> createState() => _AssetAssignState();
}

class _AssetAssignState extends State<AssetAssign> {
  final assetAssignViewModel = Get.put(AssetAssignViewModel());
  DateTime selectedDate = DateTime.now();
  final _formkey = GlobalKey<FormState>();

  Future<void> _selectDate(
      BuildContext context, TextEditingController textEditingController) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      textEditingController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FF),
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: const Color(0xFFEFF8FF),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'New Assign',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_close_dialog.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: MyCustomButton(
          width: App.appQuery.responsiveWidth(85) /*312.0*/,
          height: 48.0,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Utils.isCheck = true,
            if (_formkey.currentState!.validate())
              {
                assetAssignViewModel.submitAddAssign(
                    context,
                    widget.assetId,
                    widget.locationId,
                    widget.locationType)
              }
          },
          text: 'Confirm ',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Utils.deviceWidth(context) * 0.04,
                            0,
                            Utils.deviceWidth(context) * 0.04,
                            0),
                        child: const CustomTextField(
                            required: true,
                            textAlign: TextAlign.left,
                            text: 'Location',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                      ),
                      App.appSpacer.vHxs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Utils.deviceWidth(context) * 0.04,
                            0,
                            Utils.deviceWidth(context) * 0.04,
                            0),
                        child: MyCustomDropDown<String>(
                          itemList:
                              assetAssignViewModel.assetLocationList.toList(),
                          headerBuilder: (context, selectedItem, enabled) {
                            return Text(selectedItem);
                          },
                          listItemBuilder:
                              (context, item, isSelected, onItemSelect) {
                            return Text(item);
                          },
                          hintText: 'Select Location',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "   Select location";
                            } else if (value.toLowerCase() ==
                                widget.locationName) {
                              return "   You can't be assign to same location";
                            }
                            return null;
                          },
                          onChange: (item) {
                            assetAssignViewModel.assetLocation.value =
                                item.toString();
                          },
                          validateOnChange: true,
                        ),
                      ),
                        SizedBox(
                          height: Utils.deviceHeight(context) * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              Utils.deviceWidth(context) * 0.04,
                              0,
                              Utils.deviceWidth(context) * 0.04,
                              0),
                          child: const CustomTextField(
                              required: true,
                              textAlign: TextAlign.left,
                              text: 'Assigned To',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                        ),
                        App.appSpacer.vHxs,
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              Utils.deviceWidth(context) * 0.04,
                              0,
                              Utils.deviceWidth(context) * 0.04,
                              0),
                          child: MyCustomDropDown<String>(
                            itemList:
                                assetAssignViewModel.assetUserList.toList(),
                            headerBuilder: (context, selectedItem, enabled) {
                              return Text(
                                  Utils.textCapitalizationString(selectedItem));
                            },
                            listItemBuilder:
                                (context, item, isSelected, onItemSelect) {
                              return Text(Utils.textCapitalizationString(item));
                            },
                            hintText: 'Select user',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "   Select user";
                              }
                              return null;
                            },
                            onChange: (item) {
                              // log('changing value to: $item');
                              assetAssignViewModel.assetUser.value = item ?? '';
                            },
                            validateOnChange: true,
                          ),
                        ),

                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Utils.deviceWidth(context) * 0.04,
                            0,
                            Utils.deviceWidth(context) * 0.04,
                            0),
                        child: const CustomTextField(
                            required: true,
                            textAlign: TextAlign.left,
                            text: 'End Date',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                      ),
                      App.appSpacer.vHxxs,
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Utils.deviceWidth(context) * 0.04,
                            0,
                            Utils.deviceWidth(context) * 0.04,
                            0),
                        child: CustomTextFormField(
                          onTab: () async {
                            await _selectDate(context,
                                assetAssignViewModel.endDateController.value);
                          },
                          suffixIcon: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                            child: Image.asset(
                              'assets/images/ic_calender.png',
                            ),
                          ),
                          height: 25,
                          borderRadius: BorderRadius.circular(10.0),
                          hint: 'End Date',
                          controller:
                              assetAssignViewModel.endDateController.value,
                          focusNode:
                              assetAssignViewModel.endDateFocusNode.value,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.none,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Enter end date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.02,
                      ),
                      TextFormFieldLabel(
                          containerbackgroundColor: const Color(0xFFEFF8FF),
                          backgroundColor: const Color(0xFFFFFFFF),
                          padding: Utils.deviceWidth(context) * 0.04,
                          lebelText: 'Usage',
                          lebelFontColor: const Color(0xff1A1A1A),
                          minLines: 2,
                          maxLines: 4,
                          borderRadius: BorderRadius.circular(8.0),
                          hint: 'Brief usage',
                          controller:
                              assetAssignViewModel.usageController.value,
                          focusNode: assetAssignViewModel.usageFocusNode.value,
                          textCapitalization: TextCapitalization.none,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Enter usage';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text),
                      SizedBox(
                        height: Utils.deviceHeight(context) * 0.02,
                      ),
                      TextFormFieldLabel(
                          isRequired: false,
                          containerbackgroundColor: const Color(0xFFEFF8FF),
                          backgroundColor: const Color(0xFFFFFFFF),
                          padding: Utils.deviceWidth(context) * 0.04,
                          lebelText: 'Note',
                          lebelFontColor: const Color(0xff1A1A1A),
                          minLines: 2,
                          maxLines: 4,
                          borderRadius: BorderRadius.circular(8.0),
                          hint: 'Note',
                          controller: assetAssignViewModel.noteController.value,
                          focusNode: assetAssignViewModel.noteFocusNode.value,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.text),
                    ],
                  ),
                  // SizedBox(height: Utils.deviceHeight(context) * 0.40,),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
