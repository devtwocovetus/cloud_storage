import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/category/categoryadd_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../i10n/strings.g.dart' as i18n;

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({super.key});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final categoryaddViewModel = Get.put(CategoryaddViewModel());

  final _formkey = GlobalKey<FormState>();
  late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
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
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.create_category,
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
                        lebelText: translation.category_name,
                        lebelFontColor: const Color(0xff1A1A1A),
                        borderRadius: BorderRadius.circular(8.0),
                        hint: translation.category_name,
                        controller: categoryaddViewModel.nameController.value,
                        focusNode: categoryaddViewModel.nameFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        validating: (value) {
                          if (value!.isEmpty) {
                            return translation.enter_category_name;
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
                        lebelText: translation.description,
                        lebelFontColor: const Color(0xff1A1A1A),
                        minLines: 2,
                        maxLines: 4,
                        borderRadius: BorderRadius.circular(8.0),
                        hint: translation.brief_description_of_material,
                        controller:
                        categoryaddViewModel.descriptionController.value,
                        focusNode:
                        categoryaddViewModel.descriptionFocusNode.value,
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
                      if (_formkey.currentState!.validate()) {categoryaddViewModel.addCategory (context)}
                    },
                    text: translation.create_category_button,
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
