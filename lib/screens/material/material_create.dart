import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/screens/category/category_add.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/creatematerial_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class MaterialCreate extends StatefulWidget {
  const MaterialCreate({super.key});

  @override
  State<MaterialCreate> createState() => _MaterialCreateState();
}

class _MaterialCreateState extends State<MaterialCreate> {
  final creatematerialViewModel = Get.put(CreatematerialViewModel());

  final _formkey = GlobalKey<FormState>();
  late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }


  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: MyCustomButton(
            width: App.appQuery.responsiveWidth(70) /*312.0*/,
            height: 45,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () async => {
              Utils.isCheck = true,
              if (_formkey.currentState!.validate())
                {creatematerialViewModel.createMaterial()}
            },
            text: translation.create_new_material,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.create_material,
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.notificationList)!.then((value) {});
                          },
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Obx(
                      () => IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20,
                              width: 20,
                              url: UserPreference.profileLogo.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.03,
                  ),
                  TextFormFieldLabel(
                      padding: App.appSpacer.sm,
                      lebelText: translation.material_name,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.material_name,
                      controller: creatematerialViewModel.nameController.value,
                      focusNode: creatematerialViewModel.nameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_material_name;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  _managerNameWidget,
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    isRequired: false,
                      padding: App.appSpacer.sm,
                      lebelText: translation.description,
                      lebelFontColor: const Color(0xff1A1A1A),
                      minLines: 2,
                      maxLines: 4,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.description,
                      controller:
                          creatematerialViewModel.descriptionController.value,
                      focusNode:
                          creatematerialViewModel.descriptionFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      // validating: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Enter description';
                      //   }
                      //   return null;
                      // },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  _uOmWidget,
                  if (creatematerialViewModel.materialUOM.value == 'Other') ...[
                    TextFormFieldLabel(
                        isRequired: false,
                        padding: App.appSpacer.sm,
                        lebelText: '',
                        lebelFontColor: const Color(0xff1A1A1A),
                        borderRadius: BorderRadius.circular(8.0),
                        hint: translation.unit_name,
                        controller:
                            creatematerialViewModel.unitNameController.value,
                        focusNode: creatematerialViewModel.unitNameFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        validating: (value) {
                          if (value!.isEmpty) {
                            return translation.enter_unit_name;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text),
                  ],
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.10,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget get _managerNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CustomTextField(
                  required: true,
                  textAlign: TextAlign.left,
                  text: translation.category,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
              if (Utils.decodedMap['add_material_category'] == true) ...[
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      const CategoryAdd(),
                    );
                  },
                  child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage('assets/images/ic_add_blue.png')),
                      )),
                )
              ]
            ],
          ),
          App.appSpacer.vHxs,
          Obx(
            () => MyCustomDropDown<String>(
              itemList: creatematerialViewModel.categoryList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem));
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item));
              },
              hintText: translation.select_category,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "   ${translation.select_a_category}";
                }
                return null;
              },
              onChange: (item) {
                // log('changing value to: $item');
                creatematerialViewModel.materialCategory.value = item ?? '';
              },
              validateOnChange: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _uOmWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.uom,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            itemList: creatematerialViewModel.mouList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            hintText: translation.select_uom,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "   ${translation.select_uom}";
              }
              return null;
            },
            onChange: (item) {
              // log('changing value to: $item');
              creatematerialViewModel.materialUOM.value = item ?? '';
            },
            validateOnChange: true,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
