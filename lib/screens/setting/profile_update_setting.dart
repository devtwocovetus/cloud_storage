import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:cold_storage_flutter/view_models/setting/profile_update_setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class ProfileUpdateSetting extends StatefulWidget {
  const ProfileUpdateSetting({super.key});

  @override
  State<ProfileUpdateSetting> createState() => _SignUpState();
}

class _SignUpState extends State<ProfileUpdateSetting> {
  final ProfileUpdateSettingViewModel _profileUpdateViewModel = Get.put(ProfileUpdateSettingViewModel());
  final _formkey = GlobalKey<FormState>();
  late i18n.Translations translation;

  bool checkRememberMe = false;
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> imageBase64Convert(BuildContext context) async {
    DialogUtils.showMediaDialog(context, cameraBtnFunction: () async {
      Get.back(canPop: true);
      image = await picker.pickImage(source: ImageSource.camera,imageQuality: 20);
      if (image == null) {
      } else {
        final bytes = File(image!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
        _profileUpdateViewModel.imageBase64.value = base64Image;
        _profileUpdateViewModel.imageFilePath.value = image!.path.toString();
        _profileUpdateViewModel.imageUrl.value = '';
      }
    }, libraryBtnFunction: () async {
      Get.back(canPop: true);
      image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 20);
      if (image == null) {
      } else {
        final bytes = File(image!.path).readAsBytesSync();
        String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
        _profileUpdateViewModel.imageBase64.value = base64Image;
        _profileUpdateViewModel.imageFilePath.value = image!.path.toString();
        _profileUpdateViewModel.imageUrl.value = '';
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
                    onPressed: () => {
                      Utils.isCheck = true,
                      if (_formkey.currentState!.validate())
                        {
                          // _profileUpdateViewModel.signUpApi()
                          _profileUpdateViewModel.submitProfileForm()
                        }
                    },
                    text: translation.update,
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
                        text: translation.update_profile,
                        fontSize: 18.0,
                        fontColor: const Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                   
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Obx(() =>  SingleChildScrollView(
          child: Form(
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
                          imageBase64Convert(context);
                        },
                        child: Container(
                          width: 90.0,
                          height: 90.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: _profileUpdateViewModel.imageUrl.value.isNotEmpty
                                    ? NetworkImage(_profileUpdateViewModel.imageUrl.value)
                                    : _profileUpdateViewModel.imageFilePath.value.isNotEmpty
                                    ? FileImage(File(_profileUpdateViewModel.imageFilePath.value))
                                    : const AssetImage('assets/images/ic_user_defualt.png')
                            ),
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
                  height: 22.0,
                ),
                TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.first_name_label,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: translation.first_name_hint,
                    controller: _profileUpdateViewModel.firstNameController.value,
                    focusNode: _profileUpdateViewModel.firstNameFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return translation.enter_first_name;
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                  padding: Utils.deviceWidth(context) * 0.04,
                  lebelText: translation.last_name_label,
                  lebelFontColor: const Color(0xff1A1A1A),
                  borderRadius: BorderRadius.circular(10.0),
                  hint: translation.last_name_hint,
                  controller: _profileUpdateViewModel.lastNameController.value,
                  focusNode: _profileUpdateViewModel.lastNameFocusNode.value,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return translation.enter_last_name;
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text,
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
                  child: CustomTextField(
                    required: true,
                    textAlign: TextAlign.left,
                    text: translation.phone,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A),
                  ),
                ),
                SizedBox(
                  height: Utils.deviceWidth(context) * 0.02,
                ),
                PhoneWidget(
                  countryCode: _profileUpdateViewModel.countryCode,
                  textEditingController: _profileUpdateViewModel.phoneNumberController,
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                TextFormFieldLabel(
                    backgroundColor: kBinCardBackground,
                    readOnly: true,
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.enter_your_email,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(10.0),
                    hint: translation.example_email,
                    controller: _profileUpdateViewModel.emailController.value,
                    focusNode: _profileUpdateViewModel.emailFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return translation.enter_valid_email;
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny( RegExp(r'\s')),
                  ],),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                _defaultWidgetWidget,
                
                // MyCustomButton(
                //   height: Utils.deviceHeight(context) * 0.06,
                //   padding: Utils.deviceWidth(context) * 0.04,
                //   borderRadius: BorderRadius.circular(10.0),
                //   onPressed: () => {
                //     Utils.isCheck = true,
                //     if (_formkey.currentState!.validate())
                //       {_profileUpdateViewModel.signUpApi()}
                //   },
                //   text: 'Sign Up',
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
            
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget get _defaultWidgetWidget {
    return Padding(
      padding: EdgeInsets.only(left: Utils.deviceWidth(context) * 0.04, right: Utils.deviceWidth(context) * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.default_language,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            initialValue: _profileUpdateViewModel.defaultLanguage.value != 'en' ? 'Spanish' : 'English',
            itemList: _profileUpdateViewModel.languageItems,
            hintText: translation.selectDefault_language,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translation.error_select_default_language;
              }
              return null;
            },
            onChange: (item) {
              // log('changing value to: $item');
              _profileUpdateViewModel.defaultLanguage.value = item ?? '';
              // controller.managerNameC = item ?? '';
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

  toggleDone(bool bool) {}
}
