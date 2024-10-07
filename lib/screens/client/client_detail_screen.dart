import 'package:cold_storage_flutter/models/client/client_details_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_detail_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../i10n/strings.g.dart' as i18n;

class ClientDetailScreen extends StatefulWidget {
  const ClientDetailScreen({super.key});

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen> {
  final controller = Get.put(ClientDetailViewModel());
  late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: controller.clientIsManual.value == '1'
          ? _addButtonWidget
          : controller.clientIsRequest.value == 'true'
              ? bottomGestureButtons(context)
              : controller.requestSent.value == 'true' ||
                      controller.outgoingRequestAccepted.value == 'true' ||
                      controller.incomingRequestAccepted.value == 'true' ||
                      controller.requestIncoming.value == 'true'
                  ? bottomGestureUpdate(context)
                  : const SizedBox.shrink(),
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
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (controller.comeFrom.value == 'Normal') {
                            Get.back();
                          } else {
                            Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
                          }
                        },
                        icon: Image.asset(
                          height: 15,
                          width: 10,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )),
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.v_and_c_detail,
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.toNamed(RouteName.notificationList)!
                                .then((value) {});
                          },
                          icon: Image.asset(
                            height: 20,
                            width: 20,
                            'assets/images/ic_notification_bell.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(
                        () => IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                              Get.toNamed(RouteName.profileDashbordSetting)!
                                  .then((value) {});
                            },
                            icon: AppCachedImage(
                                roundShape: true,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                                url: UserPreference.profileLogo.value)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _accountNameWidget,
                  App.appSpacer.vHs,
                  _selectRoleWidget,
                  App.appSpacer.vHs,
                  _locationNameWidget,
                  App.appSpacer.vHs,
                  _addressNameWidget,
                  App.appSpacer.vHs,
                  _phoneNumberWidget,
                  App.appSpacer.vHs,
                  _emailAddressWidget,
                  App.appSpacer.vHs,
                  if (controller.clientEntityList!.isNotEmpty) ...[
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.clientEntityList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return clientViewTile(
                              context, controller.clientEntityList![index]);
                        })
                  ] else ...[
                    Container()
                  ],
                  if (controller.clientIsManual.value == '1') ...[
                    App.appSpacer.vHs,
                    _pocWidget,
                  ],
                  App.appSpacer.vHs,
                  App.appSpacer.vHs,
                  App.appSpacer.vHs,
                  App.appSpacer.vHs,
                  App.appSpacer.vHs,
                  App.appSpacer.vHs,
                  App.appSpacer.vHs,
                  App.appSpacer.vHs,
                ],
              ),
            )),
      ),
    );
  }

  Widget get _pocWidget {
    return Container(
      padding: App.appSpacer.edgeInsets.x.sm,
      decoration: BoxDecoration(
        color: kBinCardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          App.appSpacer.vHs,
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                  textAlign: TextAlign.left,
                  text: '..............................',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
              Spacer(),
              CustomTextField(
                  textAlign: TextAlign.center,
                  text: translation.point_of_contact,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
              Spacer(),
              CustomTextField(
                  textAlign: TextAlign.right,
                  text: '..............................',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A))
            ],
          ),
          App.appSpacer.vHs,
          Row(
            children: [
               CustomTextField(
                textAlign: TextAlign.left,
                text: translation.name_of_person,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: Color(0xff808080),
              ),
              const Spacer(),
              CustomTextField(
                textAlign: TextAlign.right,
                text: controller.pocPersonName.value.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: const Color(0xff1A1A1A),
              ),
            ],
          ),
          App.appSpacer.vHs,
          Row(
            children: [
               CustomTextField(
                textAlign: TextAlign.left,
                text: translation.phone_number,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: Color(0xff808080),
              ),
              const Spacer(),
              CustomTextField(
                textAlign: TextAlign.right,
                text: controller.pocPersonContactNumber.value.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: const Color(0xff1A1A1A),
              ),
            ],
          ),
          App.appSpacer.vHs,
          Row(
            children: [
               CustomTextField(
                textAlign: TextAlign.left,
                text: translation.email_address,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: Color(0xff808080),
              ),
              const Spacer(),
              CustomTextField(
                textAlign: TextAlign.right,
                text: controller.pocPersonEmail.value.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: const Color(0xff1A1A1A),
              ),
            ],
          ),
          App.appSpacer.vHs,
        ],
      ),
    );
  }

  Widget get _accountNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.account,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.account_name,
              readOnly: true,
              controller: controller.accoutNameController.value,
              focusNode: controller.accountNameFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _selectRoleWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Select Role',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (controller.requestSent.value == 'true' ||
                            controller.outgoingRequestAccepted.value ==
                                'true' ||
                            controller.incomingRequestAccepted.value ==
                                'true') {
                          if (controller.isVendor.value == 0) {
                            controller.isVendor.value = 1;
                          } else {
                            controller.isVendor.value = 0;
                          }
                        }
                      },
                      child: Obx(
                        () => controller.isVendor.value == 1
                            ? Image.asset(
                                'assets/images/ic_setting_check_on.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/ic_setting_check_off.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                   CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.vendor,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff1A1A1A)),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (controller.requestSent.value == 'true' ||
                            controller.outgoingRequestAccepted.value ==
                                'true' ||
                            controller.incomingRequestAccepted.value ==
                                'true') {
                          if (controller.isCustomer.value == 0) {
                            controller.isCustomer.value = 1;
                          } else {
                            controller.isCustomer.value = 0;
                          }
                        }
                      },
                      child: Obx(
                        () => controller.isCustomer.value == 1
                            ? Image.asset(
                                'assets/images/ic_setting_check_on.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/ic_setting_check_off.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                   CustomTextField(
                      textAlign: TextAlign.left,
                      text: translation.customer,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff1A1A1A)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _locationNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.location,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.location,
              readOnly: true,
              controller: controller.locationController.value,
              focusNode: controller.locationFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _emailAddressWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.email_address,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.email_address,
              readOnly: true,
              controller: controller.emailController.value,
              focusNode: controller.emailFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _phoneNumberWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.phone_number,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.phone_number,
              readOnly: true,
              controller: controller.phoneController.value,
              focusNode: controller.phoneFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _addressNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.address,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 2,
              maxLines: 4,
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.address,
              readOnly: true,
              controller: controller.addressController.value,
              focusNode: controller.addressFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget clientViewTile(
      BuildContext context, ClientEntityList clientEntityList) {
    return Container(
      margin: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
          Utils.deviceWidth(context) * 0.03, Utils.deviceWidth(context) * 0.03),
      padding: EdgeInsets.fromLTRB(
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
        border: Border.all(
          color: kBorder,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: kAppWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            clientEntityList.name.toString()),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff1A1A1A)),
                    const Spacer(),
                    clientEntityList.entityType == 1
                        ? Container(
                            width: 95,
                            height: 28,
                            decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                  right: BorderSide(
                                      color: Color(0xFF1F9254), width: 1),
                                ),
                                color: Color(0xFFEBF9F1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child:  Align(
                              alignment: Alignment.center,
                              child: CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: translation.cold_storage,
                                  fontSize: 12.0,
                                  fontColor: Color(0xFF1F9254),
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        : Container(
                            width: 95,
                            height: 28,
                            decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  top: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  bottom: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                  right: BorderSide(
                                      color: Color(0xFF1F3f92), width: 1),
                                ),
                                color: Color(0xFFD7E9FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11))),
                            child:  Align(
                              alignment: Alignment.center,
                              child: CustomTextField(
                                  textAlign: TextAlign.center,
                                  text: translation.farmhouse,
                                  fontSize: 12.0,
                                  fontColor: Color(0xFF1F3f92),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Divider(
            color: kAppGreyC,
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.405,
                child:  CustomTextField(
                  textAlign: TextAlign.left,
                  text: translation.manager,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.325,
                child:  CustomTextField(
                  textAlign: TextAlign.left,
                  text: translation.phone_number,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.405,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      clientEntityList.managerName.toString()),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.325,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      clientEntityList.managerContactNumber.toString()),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
            ],
          ),
          App.appSpacer.vHs,
           CustomTextField(
            textAlign: TextAlign.left,
            text: translation.email_address,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: Color(0xff808080),
          ),
          App.appSpacer.vHxxxs,
          CustomTextField(
            textAlign: TextAlign.left,
            text: clientEntityList.managerEmail.toString(),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontColor: const Color(0xff1a1a1a),
          ),
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
        ],
      ),
    );
  }

  Widget get _addButtonWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(60) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {},
        text: translation.edit_client,
      ),
    );
  }

  Widget bottomGestureButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {controller.requestDeclined()},
          text: translation.decline,
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {controller.requestAccept()},
          text: translation.accept,
        )
      ],
    );
  }

  Widget bottomGestureUpdate(BuildContext context) {
    return MyCustomButton(
      width: App.appQuery.responsiveWidth(35) /*312.0*/,
      height: 45,
      borderRadius: BorderRadius.circular(10.0),
      onPressed: () => {controller.submitAccountForm()},
      text: 'Update',
    );
  }
}
