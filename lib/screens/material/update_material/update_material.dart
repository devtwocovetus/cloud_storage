import 'package:cold_storage_flutter/models/material/measurement_units_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../models/material/material_categorie_model.dart';
import '../../../models/material/measurement_unit_mou.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/dropdown/my_custom_drop_down.dart';
import '../../../res/components/image_view/network_image_view.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../../view_models/controller/material_in/update/update_material_view_model.dart';
import '../../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../../view_models/services/app_services.dart';
import '../../category/category_add.dart';
import '../../category/category_add_on_update.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class UpdateMaterialScreen extends StatefulWidget {
  const UpdateMaterialScreen({super.key});

  @override
  State<UpdateMaterialScreen> createState() => _UpdateMaterialScreenState();
}

class _UpdateMaterialScreenState extends State<UpdateMaterialScreen> {
  final updateMaterialViewModel = Get.put(UpdateMaterialViewModel());
  late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

  final _updateMaterialFormKey = GlobalKey<FormState>();

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
            height: 45.h,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () async => {
              Utils.isCheck = true,
              if (_updateMaterialFormKey.currentState!.validate())
                {updateMaterialViewModel.updateMaterial()}
            },
            text: translation.update_material,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Container(
              height: 60.h,
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
                        height: 15.h,
                        width: 10.h,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.update_material,
                        fontSize: 18.0.sp,
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
                            height: 20.h,
                            width: 20.h,
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
                              height: 20.h,
                              width: 20.h,
                              url: UserPreference.profileLogo.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(child: SingleChildScrollView(
        child: Obx(
          () {
            return Form(
                key: _updateMaterialFormKey,
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
                        controller:
                            updateMaterialViewModel.nameController.value,
                        focusNode: updateMaterialViewModel.nameFocusNode.value,
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
                            updateMaterialViewModel.descriptionController.value,
                        focusNode:
                            updateMaterialViewModel.descriptionFocusNode.value,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.text),
                    SizedBox(
                      height: Utils.deviceHeight(context) * 0.02,
                    ),
                    _uOmWidget,
                    if (updateMaterialViewModel.materialUOM.value ==
                        'Other') ...[
                      TextFormFieldLabel(
                          isRequired: false,
                          padding: App.appSpacer.sm,
                          lebelText: '',
                          lebelFontColor: const Color(0xff1A1A1A),
                          borderRadius: BorderRadius.circular(8.0),
                          hint: translation.unit_name,
                          controller:
                              updateMaterialViewModel.unitNameController.value,
                          focusNode:
                              updateMaterialViewModel.unitNameFocusNode.value,
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
                ));
          },
        ),
      )),
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
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 8.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            initialValue: updateMaterialViewModel.materialUOM.value,
            itemList: updateMaterialViewModel.mouList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            hintText: translation.select_uom,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "   ${translation.select_material_uom}";
              }
              return null;
            },
            onChange: (item) {
              // log('changing value to: $item');
              updateMaterialViewModel.materialUOM.value = item ?? '';
            },
            validateOnChange: true,
          ),
        ],
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
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    const CategoryAddOnUpdate(),
                  );
                },
                child: Container(
                    width: 25.0.h,
                    height: 25.0.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage('assets/images/ic_add_blue.png')),
                    )),
              )
            ],
          ),
          App.appSpacer.vHxs,
          Obx(
            () => MyCustomDropDown<MaterialCategorie>(
              hintFontSize: 14.0.sp,
              initialValue: updateMaterialViewModel.materialCategory,
              itemList: updateMaterialViewModel.categoryList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem.name!),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),
                );
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item.name!),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),
                );
              },
              hintText: translation.select_category,
              validator: (value) {
                if (value == null) {
                  return "   ${translation.select_a_category}";
                }
                return null;
              },
              onChange: (item) {
                // log('changing value to: $item');
                updateMaterialViewModel.materialCategory = item;
              },
              validateOnChange: true,
            ),
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
