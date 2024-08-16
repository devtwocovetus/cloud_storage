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
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: controller.isData.value
          ? MyCustomButton(
              width: App.appQuery.responsiveWidth(70) /*312.0*/,
              height: 45,
              borderRadius: BorderRadius.circular(10.0),
              onPressed: () async {
                Get.offAndToNamed(RouteName.addNewClientScreen);
              },
              text: 'None of the above',
              fontSize: 15,
            )
          : const SizedBox.shrink(),
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
                  : _emptyView,
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
                backgroundColor:
                    search.requestSent == 0 ? kAppPrimary : search.requestSent == 1 ? kAppGreyC : kAppPrimary,
                borderRadius: BorderRadius.circular(8.0),
                onPressed: () async {
                  if (search.requestSent == 0) {
                    controller.sendRequestClient(search.id.toString());
                  }
                },
                text: search.requestSent == 0 ? 'Send Request' : search.requestSent == 1 ? 'Request Sent' : 'Incoming Request',
                fontSize: 12,
                textColor: search.requestSent == 0 ? kAppWhite : kAppBlack,
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
}
