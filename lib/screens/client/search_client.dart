import 'package:cold_storage_flutter/models/client/client_search_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/search_field/custom_search_field.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../view_models/services/app_services.dart';

class SearchClient extends StatelessWidget {
  SearchClient({super.key});

  final controller = Get.put(ClientSearchViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:  const Size.fromHeight(60),
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
                    const Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Add New Client',
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 25,
                              width: 25,
                              url: controller.logoUrl.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          App.appSpacer.vHs,
          Padding(
            padding: App.appSpacer.edgeInsets.x.smm,
            child: const CustomTextField(
                textAlign: TextAlign.left,
                text: 'Client Name',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontColor: Color(0xff1A1A1A)),
          ),
          App.appSpacer.vHxxs,
          CustomSearchField(
            searchHint: 'Search client',
            searchController: controller.searchController.value,
            onChanged: (value) async {
              if (value.isEmpty) {
                controller.getClientList('');
              } else if (value.length > 2) {
                controller.getClientList(value);
              }
            },
            onSubmit: (value) async {
              if (value.isEmpty) {
                controller.getClientList('');
              } else if (value.length > 2) {
                controller.getClientList(value);
              }
            },
          ),
          App.appSpacer.vHxxs,
          Expanded(
              child: Obx(
            () => SmartRefresher(
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
                            index, controller.clientList![index]);
                      },
                    )
                  : controller.isSearch.value
                      ? _emptyView
                      : Container(),
            ),
          )),
          App.appSpacer.vHxxsl,
        ],
      )),
    );
  }

  Widget get _emptyView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'No Client Found with this name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHs,
          MyCustomButton(
            width: App.appQuery.responsiveWidth(55) /*312.0*/,
            height: 45,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () async {
              Get.offAndToNamed(RouteName.addNewClientScreen);
            },
            text: 'Create Client',
            fontSize: 15,
          )
        ],
      ),
    );
  }

  Widget clientViewTile(int index, Search search) {
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
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A)),
              ),
              MyCustomButton(
                width: App.appQuery.responsiveWidth(28) /*312.0*/,
                height: 32,
                backgroundColor: getTextBgColor(search),
                borderRadius: BorderRadius.circular(8.0),
                onPressed: () async {
                  if (isActive(search)) {
                    controller.sendRequestClient(search.id.toString());
                  }
                },
                text: getTextDetails(search),
                fontSize: 12,
                textColor:getTextColor(search),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Divider(
            color: kAppGreyC,
          ),
          App.appSpacer.vHxxxs,
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Location',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              fontColor: kAppGreyB),
          App.appSpacer.vHxxxs,
          CustomTextField(
              textAlign: TextAlign.left,
              text:
                  '${Utils.textCapitalizationString(search.street1.toString())}, ${Utils.textCapitalizationString(search.city.toString())}, ${Utils.textCapitalizationString(search.state.toString())}, ${Utils.textCapitalizationString(search.country.toString())}',
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              fontColor: const Color(0xff1A1A1A)),
          App.appSpacer.vHs,
        ],
      ),
    );
  }

  String getTextDetails(Search search) {
    String str = 'Send Request';
    if (search.requestSent == 0 &&
        search.requestIncoming == 0 &&
        search.incomingRequestAccepted == 0 &&
        search.outgoingRequestAccepted == 0) {
      str = 'Send Request';
    } else if (search.incomingRequestAccepted != 0 ||
        search.outgoingRequestAccepted != 0) {
      str = 'Conected';
    } else if (search.requestSent == 0 && search.requestIncoming == 1) {
      str = 'Incoming Request';
    } else if (search.requestSent == 1) {
      str = 'Request Sent';
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
      color = kAppBlack;
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
      color = kAppGreyC;
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
