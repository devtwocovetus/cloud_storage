import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user/createuser_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable_components/reusable_components.dart';

import '../res/components/dropdown/my_custom_drop_down.dart';
import '../res/components/image_view/network_image_view.dart';
import '../view_models/services/app_services.dart';

class UserCreate extends StatefulWidget {
  const UserCreate({super.key});

  @override
  State<UserCreate> createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final createUserViewModel = Get.put(CreateuserViewModel());

  final _formkey = GlobalKey<FormState>();

  Future<void> imageBase64Convert() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      createUserViewModel.imageBase64.value = '';
      createUserViewModel.imageFilePath.value = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      createUserViewModel.imageBase64.value = base64Image;
      createUserViewModel.imageFilePath.value = image!.path.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
                      elevation: 20,
                      width: App.appQuery.responsiveWidth(70),
                      height: Utils.deviceHeight(context) * 0.06,
                      padding: Utils.deviceWidth(context) * 0.04,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: () async => {
                        Utils.isCheck = true,
                        if (_formkey.currentState!.validate())
                          {await createUserViewModel.createUser()}
                      },
                      text: 'Add User',
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
                        height: 20,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Add User !',
                      fontSize: 18.0,
                      fontColor: Color(0xFF000000),
                      fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(()=> IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                              url: createUserViewModel.logoUrl.value
                          )
                      )),
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
                    child: const CustomTextField(
                      required: true,
                      textAlign: TextAlign.left,
                      text: 'Phone Number',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A),
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
                      lebelText: 'Email',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'abc@gmail.com',
                      controller: createUserViewModel.emailController.value,
                      focusNode: createUserViewModel.emailFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                         if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter valid email address';
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
                      lebelText: 'Full Name',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Full Name',
                      controller: createUserViewModel.userNameController.value,
                      focusNode: createUserViewModel.userNameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter full name';
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
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Select User Role',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
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

              hintText: 'Select Your Role',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "   Select your role";
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
