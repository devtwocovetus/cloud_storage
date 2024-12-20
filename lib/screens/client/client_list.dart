import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/services/app_services.dart';
import '../../i10n/strings.g.dart' as i18n;

class ClientList extends StatelessWidget {
  ClientList({super.key});

  final clientListViewModel = Get.put(ClientListViewModel());
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
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
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (clientListViewModel.comeFrom.value == 'Normal') {
                            Get.back();
                          } else {
                            Get.offAllNamed(RouteName.homeScreenView,
                                arguments: []);
                          }
                        },
                        icon: Image.asset(
                          height: 15.h,
                          width: 10.h,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )),
                    CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.v_c_list,
                        fontSize: 18.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.until((route) =>
                                Get.currentRoute == RouteName.homeScreenView);
                          },
                          icon: SVGAssetImage(
                            height: 20.h,
                            width: 20.h,
                            url: 'assets/images/default/ic_home.svg',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.toNamed(RouteName.notificationList)!
                                .then((value) {});
                          },
                          icon: Image.asset(
                            height: 20.h,
                            width: 20.h,
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
                                height: 20.h,
                                width: 20.h,
                                fit: BoxFit.cover,
                                url: UserPreference.profileLogo.value)),
                      ),
                    ),
                    SizedBox(height: 4.h,)
                  ],
                ),
              ),
            ),
          )),
      body: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h,),
              Padding(
                padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03,
                    0, Utils.deviceWidth(context) * 0.03, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        margin: App.appSpacer.edgeInsets.x.none,
                        searchController:
                            clientListViewModel.searchController.value,
                        prefixIconVisible: true,
                        filled: true,
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            clientListViewModel.searchFilter('');
                          } else if (value.isNotEmpty) {
                            clientListViewModel.searchFilter(value);
                          }
                        },
                        onSubmit: (value) async {
                          if (value.isEmpty) {
                            clientListViewModel.searchFilter('');
                          } else if (value.isNotEmpty) {
                            clientListViewModel.searchFilter(value);
                          }
                        },
                        onCrossTapped: () {
                          clientListViewModel.searchFilter('');
                          clientListViewModel.searchController.value.clear();
                        },
                      ),
                    ),
                    if(Utils.decodedMap['add_client'] == true)...[
                      SizedBox(width: 12.h,),
                      GestureDetector(
                        onTap: () {
                          //Get.toNamed(RouteName.addNewClientScreen);
                          Get.toNamed(RouteName.searchClientScreen);
                        },
                        child: Image.asset(
                            width: 30.h,
                            height: 30.h,
                            'assets/images/ic_add_new.png'),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 12.h,),
              Expanded(
                child: !clientListViewModel.isLoading.value
                    ? clientListViewModel.clientList!.isNotEmpty
                        ? ListView.builder(
                            padding: App.appSpacer.edgeInsets.all.xs,
                            shrinkWrap: true,
                            itemCount: clientListViewModel.clientList?.length,
                            itemBuilder: (context, index) {
                              return clientViewTile(index, context,
                                  clientListViewModel.clientList![index]);
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/ic_empty_folder.png'),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomTextField(
                                          textAlign: TextAlign.center,
                                          text: translation.create_new_vendor,
                                          fontSize: 18.0.sp,
                                          fontColor: const Color(0xFF000000),
                                          fontWeight: FontWeight.w500
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                                if(Utils.decodedMap['add_client'] == true)...[
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: MyCustomButton(
                                      height: Utils.deviceHeight(context) * 0.06,
                                      padding: Utils.deviceWidth(context) * 0.10,
                                      borderRadius: BorderRadius.circular(10.0),
                                      onPressed: () => {
                                        Get.toNamed(RouteName.searchClientScreen)
                                      },
                                      text: translation.create,
                                    ),
                                  ),
                                ],
                                const Spacer(),
                              ],
                            ),
                          )
                    : const SizedBox.expand(),
              ),
            ],
          )),
    );
  }

  Widget clientViewTile(int index, BuildContext context, Client client) {
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
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text:
                        Utils.textCapitalizationString(client.name.toString()),
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A)),
              ),
              const Spacer(),
              if (client.requestIncoming == false &&
                  client.requestSent == false &&
                  client.incomingRequestAccepted == false &&
                  client.outgoingRequestAccepted == false &&
                  client.incomingRequestRejected == false &&
                  client.outgoingRequestRejected == false)
                ...[]
              else ...[
                //incoming
                if (client.requestIncoming == true ||
                    client.incomingRequestAccepted == true ||
                    client.incomingRequestRejected == true) ...[
                  if (client.requestIncoming == true) ...[
                    //#request incoming but not accept
                    MyCustomButton(
                      width: App.appQuery.responsiveWidth(32) /*312.0*/,
                      height: 32.h,
                      backgroundColor: kAppPrimary,
                      borderRadius: BorderRadius.circular(8.0),
                      onPressed: () async {
                        Get.toNamed(RouteName.clientDetailsScreen, arguments: [
                          {
                            "clientId": client.id.toString(),
                            "clientIsRequest":
                                client.requestIncoming.toString(),
                            "clientIsManual": client.manualCreation.toString(),
                            "requestSent": client.requestSent.toString(),
                            "outgoingRequestAccepted":
                                client.outgoingRequestAccepted.toString(),
                            "incomingRequestAccepted":
                                client.incomingRequestAccepted.toString(),
                            "requestIncoming":
                                client.requestIncoming.toString(),
                            "from": 'Normal',
                          }
                        ]);
                      },
                      text: translation.incoming_request,
                      fontSize: 12.sp,
                      textColor: kAppWhite,
                    ),
                  ] else if (client.incomingRequestAccepted == true) ...[
                    //#request incoming & accepted
                  ] else ...[
                    //#request incoming & rejected
                    MyCustomButton(
                      width: App.appQuery.responsiveWidth(32) /*312.0*/,
                      height: 32.h,
                      backgroundColor: kAppGreyC,
                      borderRadius: BorderRadius.circular(8.0),
                      onPressed: () async {},
                      text: translation.request_rejected,
                      fontSize: 12.sp,
                      textColor: kAppBlack,
                    ),
                  ]
                ] else ...[
                  if (client.requestSent == true) ...[
                    //#request sent but not accept
                    MyCustomButton(
                      width: App.appQuery.responsiveWidth(32) /*312.0*/,
                      height: 32.h,
                      backgroundColor: kAppGreyC,
                      borderRadius: BorderRadius.circular(8.0),
                      onPressed: () async {},
                      text: translation.request_sent,
                      fontSize: 12.sp,
                      textColor: kAppBlack,
                    ),
                  ] else if (client.outgoingRequestAccepted == true) ...[
                    //#request sent & accepted
                  ] else ...[
                    //#request sent & rejected
                    MyCustomButton(
                      width: App.appQuery.responsiveWidth(32) /*312.0*/,
                      height: 32.h,
                      backgroundColor: kAppGreyC,
                      borderRadius: BorderRadius.circular(8.0),
                      onPressed: () async {},
                      text: translation.request_rejected,
                      fontSize: 12.sp,
                      textColor: kAppBlack,
                    ),
                  ]
                ]
              ],
              SizedBox(
                width: 10.h,
              ),
              Image.asset(
                height: 22.h,
                width: 22.h,
                client.manualCreation! == '1'
                    ? 'assets/images/ic_manual_client.png'
                    : 'assets/images/ic_other_client.png',
              )
            ],
          ),
          SizedBox(height: 2.h,),
          const Divider(
            color: kAppGreyC,
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.location,
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: kAppGreyB),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              Expanded(
                flex: 7,
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        '${client.street1}, ${client.city}, ${client.state}, ${client.country}'),
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: kAppBlack),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          CustomTextField(
              textAlign: TextAlign.left,
              text:
                  '.................................................................................................................................................................................................................................................',
              fontSize: 13.0.sp,
              fontWeight: FontWeight.w400,
              fontColor: Color(0xffD4D4D4)),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (getRequetBtnStatus(client)) {
                      Get.toNamed(RouteName.transferNotificationListScreen,
                          arguments: [
                            {"clientId": client.id.toString()}
                          ]);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.request,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: getColorRequet(client)),
                      if (getRequetBtnStatus(client)) ...[
                        SizedBox(
                          width: 5.h,
                        ),
                        Image.asset(
                          height: 22.h,
                          width: 22.h,
                          'assets/images/ic_is_request.png',
                        )
                      ]
                    ],
                  ),
                ),
              ),
              CustomPaint(
                  size: Size(1.h, 40.h),
                  painter: DashedLineVerticalPainter()),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (getInventryBtnStatus(client)) {
                      Get.toNamed(RouteName.clientInventoryMaterialListScreen,
                          arguments: [
                            {
                              "accountId": client.id.toString(),
                              "accountName": client.name.toString(),
                              "isManual": client.manualCreation.toString(),
                            }
                          ]);
                    }
                  },
                  child: CustomTextField(
                      textAlign: TextAlign.center,
                      text: translation.inventory,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: getColorInventry(client)),
                ),
              ),
              CustomPaint(
                  size: Size(1.h, 40.h),
                  painter: DashedLineVerticalPainter()),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (getDetailsBtnStatus(client)) {
                      if (client.manualCreation.toString() == '1') {
                        Get.toNamed(RouteName.updateManualClient, arguments: [
                          {"clientId": client.id.toString()}
                        ]);
                      } else {
                        Get.toNamed(RouteName.clientDetailsScreen, arguments: [
                          {
                            "clientId": client.id.toString(),
                            "clientIsRequest":
                                client.requestIncoming.toString(),
                            "clientIsManual": client.manualCreation.toString(),
                            "requestSent": client.requestSent.toString(),
                            "outgoingRequestAccepted":
                                client.outgoingRequestAccepted.toString(),
                            "incomingRequestAccepted":
                                client.incomingRequestAccepted.toString(),
                            "requestIncoming":
                                client.requestIncoming.toString(),
                            "from": 'Normal',
                          }
                        ]);
                      }
                    }
                  },
                  child: CustomTextField(
                      textAlign: TextAlign.center,
                      text: translation.details,
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: getColorDetails(client)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool getRequetBtnStatus(Client client) {
    bool status = false;
    if (client.hasRequest! == true) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  bool getInventryBtnStatus(Client client) {
    bool status = false;
    if (client.hasInventory == true) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  bool getDetailsBtnStatus(Client client) {
    bool status = false;
    if (client.manualCreation! == '1') {
      status = true;
    } else {
      if (client.requestIncoming == true ||
          client.incomingRequestAccepted == true ||
          client.outgoingRequestAccepted == true) {
        status = true;
      } else {
        status = false;
      }
    }
    return status;
  }

  Color getColorRequet(Client client) {
    Color color = const Color(0xffe3e3e3);
    if (client.hasRequest == true) {
      color = const Color(0xff005AFF);
    } else {
      color = const Color(0xffe3e3e3);
    }
    return color;
  }

  Color getColorInventry(Client client) {
    Color color = const Color(0xffe3e3e3);
    if (client.hasInventory == true) {
      color = const Color(0xff005AFF);
    } else {
      color = const Color(0xffe3e3e3);
    }
    return color;
  }

  Color getColorDetails(Client client) {
    Color color = const Color(0xffe3e3e3);
    if (client.manualCreation! == '1') {
      color = const Color(0xff005AFF);
    } else {
      if (client.requestIncoming == true ||
          client.incomingRequestAccepted == true ||
          client.outgoingRequestAccepted == true) {
        color = const Color(0xff005AFF);
      } else {
        color = const Color(0xffe3e3e3);
      }
    }
    return color;
  }
}
