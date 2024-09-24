import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/category/categoryadd_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../view_models/controller/category/Category_add_on_update_view_model.dart';

class CategoryAddOnUpdate extends StatefulWidget {
  const CategoryAddOnUpdate({super.key});

  @override
  State<CategoryAddOnUpdate> createState() => _CategoryAddOnUpdateState();
}

class _CategoryAddOnUpdateState extends State<CategoryAddOnUpdate> {
  final _categoryAddOnUpdateViewModel = Get.put(CategoryAddOnUpdateViewModel());

  final _formkey = GlobalKey<FormState>();

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
                        text: 'Create Category',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
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
      body: SafeArea(
        child: Obx(() {
          return Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.03,
                    ),
                    TextFormFieldLabel(
                        containerbackgroundColor: const Color(0xFFEFF8FF),
                        backgroundColor: const Color(0xFFEFF8FF),
                        padding: Utils.deviceWidth(context) * 0.04,
                        lebelText: 'Category Name',
                        lebelFontColor: const Color(0xff1A1A1A),
                        borderRadius: BorderRadius.circular(8.0),
                        hint: 'ex. Fruit',
                        controller: _categoryAddOnUpdateViewModel.nameController.value,
                        focusNode: _categoryAddOnUpdateViewModel.nameFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        validating: (value) {
                          if (value!.isEmpty) {
                            return 'Enter category name';
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
                        backgroundColor: const Color(0xFFEFF8FF),
                        padding: Utils.deviceWidth(context) * 0.04,
                        lebelText: 'Description',
                        lebelFontColor: const Color(0xff1A1A1A),
                        minLines: 2,
                        maxLines: 4,
                        borderRadius: BorderRadius.circular(8.0),
                        hint: 'Brief description of the material',
                        controller:
                        _categoryAddOnUpdateViewModel.descriptionController.value,
                        focusNode:
                        _categoryAddOnUpdateViewModel.descriptionFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        validating: (value) {
                          // if (value!.isEmpty) {
                          //   return 'Enter description';
                          // }
                          return null;
                        },
                        keyboardType: TextInputType.text
                    ),
                  ],
                ),
                // SizedBox(height: Utils.deviceHeight(context) * 0.40,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: MyCustomButton(
                    width: App.appQuery.responsiveWidth(85) /*312.0*/,
                    height: 48.0,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Utils.isCheck = true,
                      if (_formkey.currentState!.validate()) {_categoryAddOnUpdateViewModel.addCategory (context)}
                    },
                    text: 'Create Category',
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
