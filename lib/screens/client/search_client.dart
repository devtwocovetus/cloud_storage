import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/search_field/custom_search_field.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/drawer/custom_app_drawer.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../view_models/services/app_services.dart';

class SearchClient extends StatelessWidget {
  SearchClient({super.key});

  final ClientViewModel controller = Get.put(ClientViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: controller.isData.value ? MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async {

        },
        text: 'None of the above',
        fontSize: 15,
      ) : const SizedBox.shrink(),
      body: SliderDrawer(
          key: controller.materialOutDrawerKey,
          appBar: SliderAppBar(
            appBarHeight: 100,
            appBarPadding: App.appSpacer.edgeInsets.top.md,
            appBarColor: Colors.white,
            drawerIcon: Padding(
              padding: App.appSpacer.edgeInsets.top.sm,
              child: IconButton(
                onPressed: () {
                  controller.materialOutDrawerKey.currentState!.toggle();
                },
                icon: Image.asset(
                  height: 20,
                  width: 20,
                  'assets/images/ic_sidemenu_icon.png',
                  fit: BoxFit.cover,
                )
              ),
            ),
            isTitleCenter: false,
            title: Padding(
              padding: App.appSpacer.edgeInsets.top.sm,
              child: const CustomTextField(
                textAlign: TextAlign.left,
                text: 'Add New Client',
                fontSize: 20.0,
                fontColor: Color(0xFF000000),
                fontWeight: FontWeight.w500),
            ),
            trailing: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: App.appSpacer.edgeInsets.top.sm,
                  child: IconButton(
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: const SVGAssetImage(
                      height: 20,
                      width: 20,
                      url: 'assets/images/default/ic_home.svg',
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Padding(
                  padding: App.appSpacer.edgeInsets.top.sm,
                  child: IconButton(
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Padding(
                  padding: App.appSpacer.edgeInsets.top.sm,
                  child: /*Obx(()=>*/
                  IconButton(
                    onPressed: () {
                      // _sliderDrawerKey.currentState!.toggle();
                    },
                    icon: const AppCachedImage(
                        roundShape: true,
                        height: 30,
                        width: 30,
                        url: 'controller.logoUrl.value'
                    )
                  ),
                  // )
                ),
                App.appSpacer.vWxxs
              ],
            ),
          ),
          slider: const CustomAppDrawer(screenCode: 3,),
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
                searchController: controller.searchController,
                onChanged: (value) async{
                  // this.search = value.toLowerCase();
                  // if(search.length<=0){
                  controller.refreshController.requestRefresh();
                  // }
                },
                onSubmit: (value) async{
                  // this.search = value.toLowerCase();
                  // if(search.length<=0){
                  controller.refreshController.requestRefresh();
                  // }else{
                  //   refreshController.requestRefresh();
                  // }
                },
              ),
              App.appSpacer.vHxxs,
              Expanded(
                child: Obx(()=>
                  SmartRefresher(
                    controller: controller.refreshController,
                    // header: ClassicHeader(),
                    onRefresh: () async{
                      // final result = await getSinkData(isRefresh: true);
                      // if(result.isNotEmpty){
                      controller.refreshController.refreshCompleted();
                      // }else{
                      //   refreshController.refreshFailed();
                      // }
                    },
                    onLoading: () async{
                      // final result = await getSinkData();
                      // if(result.isNotEmpty){
                      controller.refreshController.loadComplete();
                      // } else {
                      //   refreshController.loadFailed();
                      // }
                    },
                    child: controller.isData.value ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.count.value,
                      itemBuilder: (context, index) {
                        return clientViewTile(index);
                      },
                    ) : _emptyView,
                  ),
                )
              ),
              App.appSpacer.vHxxsl,
            ],
          )
      ),
    );
  }

  Widget get _emptyView{
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
            fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHs,
          MyCustomButton(
            width: App.appQuery.responsiveWidth(55) /*312.0*/,
            height: 45,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () async {

            },
            text: 'Create Client',
            fontSize: 15,
          )
        ],
      ),
    );
  }

  Widget clientViewTile(int index) {
    RxBool enable = true.obs;
    return Container(
      margin: App.appSpacer.edgeInsets.all.s,
      padding: App.appSpacer.edgeInsets.all.xs,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10
          ),
        ],
        border: Border.all(color: kBorder,),
        borderRadius: BorderRadius.circular(20.0),
        color: kAppWhite,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Acme Group',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)
                ),
              ),
              Obx(()=>
                MyCustomButton(
                  width: App.appQuery.responsiveWidth(28) /*312.0*/,
                  height: 32,
                  backgroundColor: enable.value ? kAppPrimary : kAppGreyC,
                  borderRadius: BorderRadius.circular(8.0),
                  onPressed: () async {
                    enable.value = !enable.value;
                  },
                  text: enable.value ? 'Send Request' : 'Request Sent',
                  fontSize: 12,
                  textColor: enable.value ? kAppWhite : kAppBlack,
                ),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Divider(
            color: kAppGreyC,
          ),
          App.appSpacer.vHxxxs,
          const Row(
            children: [
              Expanded(
                flex: 7,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Location',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontColor: kAppGreyB
                ),
              ),
              Expanded(
                flex: 5,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Manager',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontColor: kAppGreyB
                ),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Row(
            children: [
              Expanded(
                flex: 7,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Dallas, Texas, USA',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontColor: kAppBlack
                ),
              ),
              Expanded(
                flex: 5,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'John Doe',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  fontColor: kAppBlack
                ),
              ),
            ],
          ),
          App.appSpacer.vHs,
        ],
      ),
    );
  }

}