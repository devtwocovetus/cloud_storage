import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/account/account_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user/createuser_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reusable_components/reusable_components.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  createUserViewModel.logoUrl.value.isNotEmpty
                      ? const SizedBox(
                          height: 22.0,
                        )
                      : Container(),
                  createUserViewModel.logoUrl.value.isEmpty
                      ? Container()
                      : Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                    createUserViewModel.logoUrl.value)),
                          )),
                  const SizedBox(
                    height: 30.0,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                    child: Row(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Add User !',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const CustomTextField(
                                text: 'Active',
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xff000000)),
                            const SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                createUserViewModel.isActive.value =
                                    !createUserViewModel.isActive.value;
                              },
                              child: createUserViewModel.isActive.value
                                  ? Image.asset(
                                      'assets/images/ic_switch_on.png',
                                      width: 34,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/ic_switch_off.png',
                                      width: 34,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const CustomTextField(
                                text: 'Inactive',
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xff000000))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Enter Yor Mobile Number',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  SizedBox(
                    width: 350.0,
                    height: 67.0,
                    child: IntlPhoneField(
                      showCountryFlag: true,
                      autofocus: false,
                      autovalidateMode: AutovalidateMode.disabled,
                      validating: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          Utils.snackBar('Phone', 'Enter valid phone number');
                          return '';
                        }
                        return null;
                      },
                      dropdownTextStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: buildOutlineInputBorder(
                            Colors.black.withOpacity(0.4), 1),
                        focusedBorder:
                            buildOutlineInputBorder(const Color(0xff005AFF), 1),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        createUserViewModel.contactNumber.value =
                            phone.completeNumber;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Enter your Email',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'abc@gmail.com',
                      controller: createUserViewModel.emailController.value,
                      focusNode: createUserViewModel.emailFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Email', 'Enter Email');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Enter your User Name',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'abc',
                      controller: createUserViewModel.userNameController.value,
                      focusNode: createUserViewModel.userNameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Account Name', 'Enter Account Name');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Select User Role',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                    child: SizedBox(
                      width: 370.0,
                      height: 80.0,
                      child: CustomDropdown(
                        height: 60,
                        selectHint: 'Select Your Role',
                        selectedTimezone: null,
                        onItemSelected: (item) =>
                            createUserViewModel.userRoleType.value = item,
                        allItems: createUserViewModel.userRoleList.toList(),
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            Utils.snackBar('User Role', 'Select your role');
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  MyCustomButton(
                    width: 312.0,
                    height: 48.0,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Utils.isCheck = true,
                      if (_formkey.currentState!.validate())
                        {createUserViewModel.createUser()}
                    },
                    text: 'Add User',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            );
          }),
        ),
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
