import 'package:cold_storage_flutter/models/client/client_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/client_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/drawer/custom_app_drawer.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../view_models/services/app_services.dart';

class ClientList extends StatelessWidget {
  ClientList({super.key});

  final clientListViewModel = Get.put(ClientListViewModel());
  final _clientDrawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
          key: _clientDrawerKey,
          appBar: SliderAppBar(
            appBarHeight: 90,
            appBarPadding: App.appSpacer.edgeInsets.top.md,
            appBarColor: Colors.white,
            drawerIcon: Padding(
              padding: App.appSpacer.edgeInsets.top.sm,
              child: IconButton(
                  onPressed: () {
                    _clientDrawerKey.currentState!.toggle();
                  },
                  icon: Image.asset(
                    height: 20,
                    width: 20,
                    'assets/images/ic_sidemenu_icon.png',
                    fit: BoxFit.cover,
                  )),
            ),
            isTitleCenter: false,
            title: Padding(
              padding: App.appSpacer.edgeInsets.top.sm,
              child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Client List',
                  fontSize: 18.0,
                  fontColor: Color(0xFF000000),
                  fontWeight: FontWeight.w500),
            ),
            trailing: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: App.appSpacer.edgeInsets.top.sm,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: () {
                       Get.until((route) =>
                            Get.currentRoute == RouteName.homeScreenView);
                      },
                      icon: const SVGAssetImage(
                        height: 20,
                        width: 20,
                        url: 'assets/images/default/ic_home.svg',
                        fit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: App.appSpacer.edgeInsets.top.sm,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // _sliderDrawerKey.currentState!.toggle();
                      },
                      icon: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_notification_bell.png',
                        fit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: App.appSpacer.edgeInsets.top.sm,
                  child: Obx(()=>
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon:  AppCachedImage(
                              roundShape: true,
                              height: 25,
                              width: 25,
                              url: clientListViewModel.logoUrl.value)),
                  )
                ),
              ],
            ),
          ),
          slider: const CustomAppDrawer(
            screenCode: 3,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              App.appSpacer.vHs,
              Padding(
                padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03,
                    0, Utils.deviceWidth(context) * 0.03, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Utils.deviceWidth(context) * 0.85,
                      child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: Image.asset(
                                'assets/images/ic_search_field.png'),
                            hintText: "Search Here. . .",
                            filled: true,
                            fillColor: const Color(0xffEFF8FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          )),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.addNewClientScreen);
                      },
                      child: Image.asset(
                          width: 30,
                          height: 30,
                          'assets/images/ic_add_new.png'),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Obx(
                () => clientListViewModel.clientList!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: clientListViewModel.clientList?.length,
                        itemBuilder: (context, index) {
                          return clientViewTile(index, context,
                              clientListViewModel.clientList![index]);
                        },
                      )
                    : _emptyView,
              )),
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
               Get.toNamed(RouteName.addNewClientScreen);
            },
            text: 'Create Client',
            fontSize: 15,
          )
        ],
      ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(client.name.toString()),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A)),
              ),
              Image.asset(
                height: 20,
                width: 20,
                client.manualCreation!
                    ? 'assets/images/ic_manual_client.png'
                    : 'assets/images/ic_other_client.png',
                fit: BoxFit.cover,
              )
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
                    text: Utils.textCapitalizationString('${client.street1}, ${client.city}, ${client.state}, ${client.country}'),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    fontColor: kAppBlack),
              ),
           
            ],
          ),
          App.appSpacer.vHxxxs,
          const CustomTextField(
              textAlign: TextAlign.left,
              text:
                  '.................................................................................................................................................................................................................................................',
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              fontColor: Color(0xffD4D4D4)),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Request',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor:getColorRequet(client)),
              ),
              CustomPaint(
                  size: const Size(1, 40),
                  painter: DashedLineVerticalPainter()),
               Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Inventory',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor: getColorInventry(client)),
              ),
              CustomPaint(
                  size: const Size(1, 40),
                  painter: DashedLineVerticalPainter()),
               Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Details',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor: getColorDetails(client)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color getColorRequet(Client client) {
    Color color = const Color(0xffe3e3e3);
    if (client.manualCreation!) {
      color = const Color(0xffe3e3e3);
    } else {
      if (client.incomingRequestAccepted!) {
        color = const Color(0xffe3e3e3);
      }
      color = const Color(0xffe3e3e3);
    }

    return color;
  }

  Color getColorInventry(Client client) {
    Color color = const Color(0xffe3e3e3);
    if (client.manualCreation!) {
      color = const Color(0xff005AFF);
    } else {
      if (client.requestIncoming!) {
        if (client.incomingRequestAccepted! == false &&
            client.incomingRequestRejected! == false) {
          color = const Color(0xffe3e3e3);
        } else if (client.incomingRequestAccepted!) {
          color = const Color(0xff005AFF);
        } else if (client.incomingRequestRejected!) {
          color = const Color(0xffe3e3e3);
        }
      } else if (client.requestSent!) {
        if (client.outgoingRequestAccepted!) {
          color = const Color(0xff005AFF);
        } else if (client.outgoingRequestRejected!) {
          color = const Color(0xffe3e3e3);
        }
      }
    }
    return color;
  }

  Color getColorDetails(Client client) {
    Color color = const Color(0xffe3e3e3);
    if (client.manualCreation!) {
      color = const Color(0xff005AFF);
    } else {
      if (client.requestIncoming!) {
        if (client.incomingRequestAccepted! == false &&
            client.incomingRequestRejected! == false) {
          color = const Color(0xffe3e3e3);
        } else if (client.incomingRequestAccepted!) {
          color = const Color(0xff005AFF);
        } else if (client.incomingRequestRejected!) {
          color = const Color(0xffe3e3e3);
        }
      } else if (client.requestSent!) {
        if (client.outgoingRequestAccepted!) {
          color = const Color(0xff005AFF);
        } else if (client.outgoingRequestRejected!) {
          color = const Color(0xffe3e3e3);
        }
      }
    }
    return color;
  }
}
