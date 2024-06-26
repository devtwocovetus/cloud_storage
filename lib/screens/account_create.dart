import 'package:cold_storage_flutter/view_models/controller/account/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reusable_components/reusable_components.dart';

class AccountCreate extends StatefulWidget {
  const AccountCreate({super.key});

  @override
  State<AccountCreate> createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  final ImagePicker picker = ImagePicker();
  late final XFile? image;
  final accountViewModel = Get.put(AccountViewModel());
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool checkRememberMe = false;
  bool _obscured = true;
  bool isChecked = false;
  bool isCheckedBilling = false;
  List<String> unitItems = ['Imperial', 'Matrix'];
  List<String> languageItems = ['English', 'Spanish'];


  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx((){return Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Image.asset(
                'assets/images/ic_logo_coldstorage.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50.0,
              ),
              const CustomTextField(
                  text: 'Create Account!',
                  fontSize: 24.0,
                  fontColor: Color(0xFF000000),
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 50.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Account Name',
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
                  hint: 'Account Name',
                  controller: emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 25.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Email Address',
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
                  hint: 'Email Address',
                  controller: emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 25.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Contact Number',
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
                  hint: 'Contact Number',
                  controller: emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 25.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Address',
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
                  height: 57.0,
                  minLines: 2,
                  maxLines: 4,
                  borderRadius: BorderRadius.circular(8.0),
                  hint: 'Address',
                  controller: emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Row(
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Different Billing Address ?',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCheckedBilling = !isCheckedBilling;
                        });
                      },
                      child: isCheckedBilling
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
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              isCheckedBilling
                  ? Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                            child: CustomTextField(
                                textAlign: TextAlign.left,
                                text: 'Billing Address',
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
                            height: 57.0,
                            minLines: 2,
                            maxLines: 4,
                            borderRadius: BorderRadius.circular(8.0),
                            hint: 'Address',
                            controller: emailController,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 25.0,
                        ),
                      ],
                    )
                  : Container(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Default Language',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A)),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: SizedBox(
                  width: 345.0,
                  height: 40.0,
                  child: CustomDropdown(
                    selectHint: 'Select default language',
                    selectedTimezone: "English",
                    onItemSelected: (item) => print(item),
                    allItems: languageItems,
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Time Zone',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A)),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: SizedBox(
                  width: 345.0,
                  height: 40.0,
                  child: CustomDropdown(
                    selectHint: 'Select Timezone',
                    selectedTimezone: null,
                    onItemSelected: (item) => print(item),
                    allItems: languageItems,
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Select Unit',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A)),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: SizedBox(
                  width: 345.0,
                  height: 40.0,
                  child: CustomDropdown(
                      selectHint: 'Select Unit',
                      selectedTimezone: null,
                      onItemSelected: (item) => print(item),
                      allItems: accountViewModel.unit.toList(),
                    )
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Logo',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A)),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Container(
                width: 345.0,
                height: 40.0,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.4), width: 1),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextField(
                          text: 'Upload Logo',
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      MyCustomButton(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        width: 87.0,
                        height: 38.0,
                        borderRadius: BorderRadius.circular(8.0),
                        onPressed: () async => {
                          image = await picker.pickImage(
                              source: ImageSource.gallery)
                        },
                        text: 'Upload',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                  child: CustomTextField(
                      textAlign: TextAlign.left,
                      text: 'Description',
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
                  height: 57.0,
                  minLines: 2,
                  maxLines: 4,
                  borderRadius: BorderRadius.circular(8.0),
                  hint: 'Description',
                  controller: emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 30.0,
              ),
              MyCustomButton(
                width: 312.0,
                height: 48.0,
                borderRadius: BorderRadius.circular(10.0),
                onPressed: () => print('CustomButton clicked!'),
                text: 'Continue',
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          );}),
        ),
      ),
    );
  }

  Widget buildCard(Size size) {
    return Container(
      alignment: Alignment.center,
      width: size.width * 0.9,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo & text
          logo(size.height / 10, size.height / 10),
          SizedBox(
            height: size.height * 0.03,
          ),
          richText(),
          SizedBox(
            height: size.height * 0.05,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: CustomTextField(
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
            width: 312.0,
            height: 67.0,
            child: IntlPhoneField(
              showCountryFlag: true,
              autofocus: false,
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
                border:
                    buildOutlineInputBorder(Colors.black.withOpacity(0.4), 1),
                focusedBorder:
                    buildOutlineInputBorder(const Color(0xff005AFF), 1),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
          ),

          //email & password textField
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Enter Your Email',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
              width: 312.0,
              height: 48.0,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'example@gmail.com',
              controller: emailController,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(
            height: 24,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Enter Your Password',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            width: 312.0,
            height: 48.0,
            obscure: _obscured,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Enter Your Password',
            controller: passController,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: _toggleObscured,
                  child: Icon(
                    _obscured
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size: 24,
                  ),
                )),
          ),

          const SizedBox(
            height: 24,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Re-Enter Your Password',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            width: 312.0,
            height: 48.0,
            obscure: _obscured,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Enter Your Password',
            controller: passController,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: _toggleObscured,
                  child: Icon(
                    _obscured
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size: 24,
                  ),
                )),
          ),

          SizedBox(
            height: size.height * 0.04,
          ),
          //sign in button
          signInButton(size),
        ],
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.04,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        const Row(
          children: [
            CustomTextField(
                text: 'Already Joined us?',
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                fontColor: Color(0xff0D0E0E)),
            SizedBox(
              width: 3.0,
            ),
            CustomTextField(
                text: 'Login',
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                fontColor: Color(0xff0E64D1)),
          ],
        )
      ],
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/ic_logo_coldstorage.png',
      fit: BoxFit.cover,
    );
  }

  Widget richText() {
    return const CustomTextField(
        text: 'Hi, Welcome To Storage! 👋',
        fontSize: 24.0,
        fontColor: Color(0xFF000000),
        fontWeight: FontWeight.w700);
  }

  Widget emailTextField(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: size.height / 12,
        child: TextField(
          controller: emailController,
          style: GoogleFonts.inter(
            fontSize: 18.0,
            color: const Color(0xFF151624),
          ),
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          cursorColor: const Color(0xFF151624),
          decoration: InputDecoration(
            hintText: 'Enter your email',
            hintStyle: GoogleFonts.inter(
              fontSize: 16.0,
              color: const Color(0xFF151624).withOpacity(0.5),
            ),
            filled: true,
            fillColor: emailController.text.isEmpty
                ? const Color.fromRGBO(248, 247, 251, 1)
                : Colors.transparent,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: emailController.text.isEmpty
                      ? Colors.transparent
                      : const Color.fromRGBO(44, 185, 176, 1),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(44, 185, 176, 1),
                )),
            prefixIcon: Icon(
              Icons.mail_outline_rounded,
              color: emailController.text.isEmpty
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : const Color.fromRGBO(44, 185, 176, 1),
              size: 16,
            ),
            suffix: Container(
              alignment: Alignment.center,
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: const Color.fromRGBO(44, 185, 176, 1),
              ),
              child: emailController.text.isEmpty
                  ? const Center()
                  : const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 13,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: size.height / 12,
        child: TextField(
          controller: passController,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: const Color(0xFF151624),
          ),
          cursorColor: const Color(0xFF151624),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: GoogleFonts.inter(
              fontSize: 16.0,
              color: const Color(0xFF151624).withOpacity(0.5),
            ),
            filled: true,
            fillColor: passController.text.isEmpty
                ? const Color.fromRGBO(248, 247, 251, 1)
                : Colors.transparent,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: passController.text.isEmpty
                      ? Colors.transparent
                      : const Color.fromRGBO(44, 185, 176, 1),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(44, 185, 176, 1),
                )),
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: passController.text.isEmpty
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : const Color.fromRGBO(44, 185, 176, 1),
              size: 16,
            ),
            suffix: Container(
              alignment: Alignment.center,
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: const Color.fromRGBO(44, 185, 176, 1),
              ),
              child: passController.text.isEmpty
                  ? const Center()
                  : const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 13,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signInButton(Size size) {
    return MyCustomButton(
      width: 312.0,
      height: 48.0,
      borderRadius: BorderRadius.circular(10.0),
      onPressed: () => print('CustomButton clicked!'),
      text: 'Sign Up',
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
