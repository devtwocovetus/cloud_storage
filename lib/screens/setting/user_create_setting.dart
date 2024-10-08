import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/view_models/setting/createusersetting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable_components/reusable_components.dart';
import '../material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class UserCreateSetting extends StatefulWidget {
  const UserCreateSetting({super.key});

  @override
  State<UserCreateSetting> createState() => _UserCreateSettingState();
}

class _UserCreateSettingState extends State<UserCreateSetting> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final createUserViewModel = Get.put(CreateusersettingViewModel());

  final _formkey = GlobalKey<FormState>();
  late i18n.Translations translation;

  Future<void> imageBase64Convert() async {
    DialogUtils.showMediaDialog(context, cameraBtnFunction: () async {
      Get.back(closeOverlays: true);
      image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        createUserViewModel.imageBase64.value = '';
        createUserViewModel.imageFilePath.value = '';
      } else {
        final bytes = File(image!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
        createUserViewModel.imageBase64.value = base64Image;
        createUserViewModel.imageFilePath.value = image!.name;
        print('<><><>##### ${image!.name}');
      }
    }, libraryBtnFunction: () async {
      Get.back(closeOverlays: true);
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        createUserViewModel.imageBase64.value = '';
        createUserViewModel.imageFilePath.value = '';
      } else {
        final bytes = File(image!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
        createUserViewModel.imageBase64.value = base64Image;
        createUserViewModel.imageFilePath.value = image!.name;
        print('<><><>##### ${image!.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
                      width: App.appQuery.responsiveWidth(70),
                      height: Utils.deviceHeight(context) * 0.06,
                      padding: Utils.deviceWidth(context) * 0.04,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: () async => {
                        Utils.isCheck = true,
                        if (_formkey.currentState!.validate())
                          {await createUserViewModel.createUser()}
                      },
                      text: translation.add_user,
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
                      textAlign: TextAlign.left,
                      text: translation.add_user,
                      fontSize: 18.0,
                      fontColor: const Color(0xFF000000),
                      fontWeight: FontWeight.w500),
                    const Spacer(),
                    // Padding(
                    //   padding: App.appSpacer.edgeInsets.top.none,
                    //   child: Obx(()=> IconButton(
                    //       padding: EdgeInsets.zero,
                    //       onPressed: () {
                    //         // _sliderDrawerKey.currentState!.toggle();
                    //         Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                    //       },
                    //       icon: AppCachedImage(
                    //           roundShape: true,
                    //           height: 20,
                    //           width: 20,
                    //           fit: BoxFit.cover,
                    //           url: UserPreference.profileLogo.value
                    //       )
                    //   )),
                    // ),
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
                  const SizedBox(
                    height: 22.0,
                  ),
                  Center(
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            imageBase64Convert();
                          },
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: createUserViewModel
                                          .imageFilePath.value.isEmpty
                                      ? const AssetImage(
                                          'assets/images/ic_user_defualt.png')
                                      : FileImage(File(createUserViewModel
                                          .imageFilePath.value))),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/images/ic_edit_blue.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const CustomTextField(
                  //         text: 'Inactive',
                  //         fontSize: 13.0,
                  //         fontWeight: FontWeight.w400,
                  //         fontColor: Color(0xff000000)),
                  //     const SizedBox(
                  //       width: 5.0,
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         createUserViewModel.isActive.value =
                  //             !createUserViewModel.isActive.value;
                  //       },
                  //       child: createUserViewModel.isActive.value
                  //           ? Image.asset(
                  //               'assets/images/ic_switch_on.png',
                  //               width: 34,
                  //               height: 20,
                  //               fit: BoxFit.cover,
                  //             )
                  //           : Image.asset(
                  //               'assets/images/ic_switch_off.png',
                  //               width: 34,
                  //               height: 20,
                  //               fit: BoxFit.cover,
                  //             ),
                  //     ),
                  //     const SizedBox(
                  //       width: 5.0,
                  //     ),
                  //     const CustomTextField(
                  //         text: 'Active',
                  //         fontSize: 13.0,
                  //         fontWeight: FontWeight.w400,
                  //         fontColor: Color(0xff000000))
                  //   ],
                  // ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: CustomTextField(
                      required: true,
                      textAlign: TextAlign.left,
                      text: translation.phone_number,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontColor: const Color(0xff1A1A1A),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  PhoneWidget(
                    countryCode: createUserViewModel.countryCode,
                    textEditingController:
                        createUserViewModel.phoneNumberController,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.email,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.email_placeholder,
                      controller: createUserViewModel.emailController.value,
                      focusNode: createUserViewModel.emailFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                         if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return translation.valid_email_error;
                      }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny( RegExp(r'\s')),
                    ],),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.first_name,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.first_name,
                      controller: createUserViewModel.userFirstNameController.value,
                      focusNode: createUserViewModel.userFisrtNameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.first_name_error;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                   TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.last_name,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.last_name,
                      controller: createUserViewModel.userLastNameController.value,
                      focusNode: createUserViewModel.userLastNameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.last_name_error;
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
                  const SizedBox(
                    height: 25.0,
                  ),

                  const SizedBox(
                    height: 60.0,
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
          CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.user_role,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          Obx(
            () => MyCustomDropDown<String>(
              itemList: createUserViewModel.userRoleList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },

              hintText: translation.select_your_role,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translation.select_your_role_error;
                }
                return null;
              },
              onChange: (item) {
                // log('changing value to: $item');
                createUserViewModel.userRoleType.value = item ?? '';
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
