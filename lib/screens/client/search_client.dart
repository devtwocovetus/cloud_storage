import 'package:cold_storage_flutter/models/client/client_search_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/search_field/custom_search_field.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/services/app_services.dart';
import '../../i10n/strings.g.dart' as i18n;

class SearchClient extends StatelessWidget {
  SearchClient({super.key});

  final controller = Get.put(ClientSearchViewModel());
   late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    return Scaffold(
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
                     Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.add_vendor_customer,
                          fontSize: 18.0.h,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
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
      body: SafeArea(
          child: Obx(() =>Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(height: 12.h,),
          //  Padding(
          //   padding: App.appSpacer.edgeInsets.x.smm,
          //   child: const CustomTextField(
          //       textAlign: TextAlign.left,
          //       text: 'Client Name',
          //       fontSize: 14.0,
          //       fontWeight: FontWeight.w500,
          //       fontColor: Color(0xff1A1A1A)),
          // ),
          // App.appSpacer.vHxxs,
          CustomSearchField(
            searchHint: translation.search_by_account_name,
            searchController: controller.searchController.value,
            onChanged: (value) async {
              if (value.isEmpty) {
                controller.getClientList('');
              } else if (value.isNotEmpty) {
                controller.getClientList(value);
              }
            },
            onSubmit: (value) async {
              if (value.isEmpty) {
                controller.getClientList('');
              } else if (value.isNotEmpty) {
                controller.getClientList(value);
              }
            },
            onCrossTapped: () {
              controller.getClientList('');
              controller.searchController.value.clear();
            },
          ),
          SizedBox(height: 4.h,),
          Expanded(
              child: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () async {
                controller.refreshController.refreshCompleted();
              },
              onLoading: () async {
                controller.refreshController.loadComplete();
              },
              child: controller.clientList!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.clientList!.length,
                      itemBuilder: (context, index) {
                        return clientViewTile(
                            index, controller.clientList![index], context);
                      },
                    )
                  : controller.isSearch.value
                      ? _emptyView
                      : Container(),
            ),
          ),
          SizedBox(height: 60.h,),
        ],
      ))),
    );
  }

  Widget get _emptyView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: CustomTextField(
                textAlign: TextAlign.left,
                text: translation.no_account_found,
                line: 2,
                isMultyline: true,
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                fontColor: Color(0xff1A1A1A)),
           ),
          App.appSpacer.vHs,
          MyCustomButton(
            width: App.appQuery.responsiveWidth(55) /*312.0*/,
            height: 45.h,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () async {
              Get.offAndToNamed(RouteName.addNewClientScreen);
            },
            text: translation.create,
            fontSize: 15.sp,
          )
        ],
      ),
    );
  }

  void showDialogAddClient(BuildContext context,
      {required String title,
      required String proceedBtnText,
      required String cancelBtnText,
      required final VoidCallback selectHandler}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              translation.send_request,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0xffFF0000),
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              )),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translation.you_want_to_add_them_as,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  )),
                ),
                SizedBox(
                  height: Utils.deviceHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (controller.isVendor.value == 0) {
                                  controller.isVendor.value = 1;
                                } else {
                                  controller.isVendor.value = 0;
                                }
                              },
                              child: Obx(
                                () => controller.isVendor.value == 1
                                    ? Image.asset(
                                        'assets/images/ic_setting_check_on.png',
                                        width: 20.h,
                                        height: 20.h,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/ic_setting_check_off.png',
                                        width: 20.h,
                                        height: 20.h,
                                        fit: BoxFit.cover,
                                      ),
                              )),
                          SizedBox(
                            width: 10.h,
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.left,
                              translation.vendor,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color:  Color(0xff1A1A1A),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0.sp,
                                  )
                              ),
                            ),
                          ),
                          //  Expanded(
                          //    child: CustomTextField(
                          //       textAlign: TextAlign.left,
                          //       text: translation.vendor,
                          //       fontSize: 14.0.sp,
                          //       fontWeight: FontWeight.w600,
                          //       fontColor: Color(0xff1A1A1A)),
                          //  ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (controller.isCustomer.value == 0) {
                                  controller.isCustomer.value = 1;
                                } else {
                                  controller.isCustomer.value = 0;
                                }
                              },
                              child: Obx(
                                () => controller.isCustomer.value == 1
                                    ? Image.asset(
                                        'assets/images/ic_setting_check_on.png',
                                        width: 20.h,
                                        height: 20.h,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/ic_setting_check_off.png',
                                        width: 20.h,
                                        height: 20.h,
                                        fit: BoxFit.cover,
                                      ),
                              )),

                          // Expanded(child: Text("datadatadatadatadatadatadatadatadatadata",overflow: TextOverflow.ellipsis,)),
                          SizedBox(
                            width: 10.h,
                          ),
                           Expanded(
                             child: Text(
                               textAlign: TextAlign.left,
                               translation.customer,
                               style: GoogleFonts.poppins(
                                   textStyle: TextStyle(
                                     color:  Color(0xff1A1A1A),
                                     fontWeight: FontWeight.w600,
                                     fontSize: 14.0.sp,
                                   )
                                 ),
                             ),
                           ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyCustomButton(
                    textColor: const Color(0xffFFFFFF),
                    backgroundColor: const Color(0xff005AFF),
                    width: App.appQuery.responsiveWidth(25) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: selectHandler,
                    text: translation.proceed,
                  ),
                  MyCustomButton(
                    textColor: const Color(0xff000000),
                    backgroundColor: const Color(0xffD9D9D9),
                    width: App.appQuery.responsiveWidth(25) /*312.0*/,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: translation.cancel,
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget clientViewTile(int index, Search search, BuildContext context) {
    return Container(
      margin: App.appSpacer.edgeInsets.all.s,
      padding: App.appSpacer.edgeInsets.all.s,
      decoration: BoxDecoration(
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
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text:
                        Utils.textCapitalizationString(search.name.toString()),
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A)),
              ),
              MyCustomButton(
                // width: App.appQuery.responsiveWidth(30) /*312.0*/,
                height: 32.h,
                backgroundColor: getTextBgColor(search),
                borderRadius: BorderRadius.circular(8.0),
                onPressed: () async {
                  if (isActive(search)) {
                    showDialogAddClient(context,
                        title: translation.send_request,
                        proceedBtnText: translation.proceed_button_text,
                        cancelBtnText: translation.cancel_button_text,
                        selectHandler: () {
                      Navigator.pop(context);
                      controller.sendRequestClient(search.id.toString());
                    });
                  }
                },
                text: getTextDetails(search),
                fontSize: 12.sp,
                textColor: getTextColor(search),
              ),
            ],
          ),
          SizedBox(height: 2.h,),
          const Divider(
            color: kAppGreyC,
          ),
          SizedBox(height: 2.h,),
          CustomTextField(
              textAlign: TextAlign.left,
              text: translation.location,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w400,
              fontColor: kAppGreyB),
          App.appSpacer.vHxxxs,
          CustomTextField(
              textAlign: TextAlign.left,
              text:
                  '${Utils.textCapitalizationString(search.street1.toString())}, ${Utils.textCapitalizationString(search.city.toString())}, ${Utils.textCapitalizationString(search.state.toString())}, ${Utils.textCapitalizationString(search.country.toString())}',
              fontSize: 15.0.sp,
              fontWeight: FontWeight.w400,
              fontColor: const Color(0xff1A1A1A)),
          App.appSpacer.vHs,
        ],
      ),
    );
  }

  void _onClick(String value) {
    //do something
  }

  String getTextDetails(Search search) {
    String str = translation.send_request;
    if (search.requestSent == 0 &&
        search.requestIncoming == 0 &&
        search.incomingRequestAccepted == 0 &&
        search.outgoingRequestAccepted == 0) {
      str = translation.send_request;
    } else if (search.incomingRequestAccepted != 0 ||
        search.outgoingRequestAccepted != 0) {
      str = translation.connected;
    } else if (search.requestSent == 0 && search.requestIncoming == 1) {
      str = translation.incoming_request;
    } else if (search.requestSent == 1) {
      str = translation.request_sent;
    }
    return str;
  }

  Color getTextColor(Search search) {
    Color color = const Color(0xffe3e3e3);
    if (search.requestSent == 0 &&
        search.requestIncoming == 0 &&
        search.incomingRequestAccepted == 0 &&
        search.outgoingRequestAccepted == 0) {
      color = kAppWhite;
    } else if (search.incomingRequestAccepted != 0 ||
        search.outgoingRequestAccepted != 0) {
      color = kAppBlack;
    } else if (search.requestSent == 0 && search.requestIncoming == 1) {
      color = kAppWhite;
    } else if (search.requestSent == 1) {
      color = kAppBlack;
    }
    return color;
  }

  Color getTextBgColor(Search search) {
    Color color = const Color(0xffe3e3e3);
    if (search.requestSent == 0 &&
        search.requestIncoming == 0 &&
        search.incomingRequestAccepted == 0 &&
        search.outgoingRequestAccepted == 0) {
      color = kAppPrimary;
    } else if (search.incomingRequestAccepted != 0 ||
        search.outgoingRequestAccepted != 0) {
      color = kAppGreyC;
    } else if (search.requestSent == 0 && search.requestIncoming == 1) {
      color = kAppPrimary;
    } else if (search.requestSent == 1) {
      color = kAppGreyC;
    }
    return color;
  }

  bool isActive(Search search) {
    bool isActive = false;
    if (search.requestSent == 0 &&
        search.requestIncoming == 0 &&
        search.incomingRequestAccepted == 0 &&
        search.outgoingRequestAccepted == 0) {
      isActive = true;
    } else if (search.incomingRequestAccepted != 0 ||
        search.outgoingRequestAccepted != 0) {
      isActive = false;
    } else if (search.requestSent == 0 && search.requestIncoming == 1) {
      isActive = false;
    } else if (search.requestSent == 1) {
      isActive = false;
    }
    return isActive;
  }
}
