import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_models/services/app_services.dart';

class TransactionInOut extends StatefulWidget {
  const TransactionInOut({super.key});

  @override
  State<TransactionInOut> createState() => _TransactionInOutState();
}

class _TransactionInOutState extends State<TransactionInOut> {

  bool isTrIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Get.back();
                        },
                        icon: Image.asset(
                          height: 20,
                          width: 10,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )
                    ),
                    const Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Transaction',
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // Get.until((route) =>
                            // Get.currentRoute == RouteName.homeScreenView);
                          },
                          icon: const SVGAssetImage(
                            height: 20,
                            width: 20,
                            url: 'assets/images/default/ic_home.svg',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
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
                      child: /*Obx(()=> */IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                              url: 'inventoryClientViewModel.logoUrl.value'
                          )
                      ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  Utils.deviceWidth(context) * 0.03,
                  0,
                  Utils.deviceWidth(context) * 0.03,
                  Utils.deviceWidth(context) * 0.01),
              padding: EdgeInsets.fromLTRB(
                  Utils.deviceWidth(context) * 0.03,
                  Utils.deviceWidth(context) * 0.03,
                  Utils.deviceWidth(context) * 0.03,
                  0),
              child: /*Obx(() =>*/
                  Column(
                children: [
                  App.appSpacer.vHxs,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Transaction ID',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: Color(0xff808080),
                            ),
                            App.appSpacer.vHxxxs,
                            CustomTextField(
                              textAlign: TextAlign.center,
                              // text: Utils.textCapitalizationString(
                              //     transactionDetail.unitName.toString()),
                              text: '102304045666',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: const Color(0xff1a1a1a),
                            )
                          ],
                        ),
                      ),
                      App.appSpacer.vWxxs,
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Transaction Date',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: Color(0xff808080),
                            ),
                            App.appSpacer.vHxxxs,
                            CustomTextField(
                              textAlign: TextAlign.center,
                              // text: Utils.textCapitalizationString(
                              //     transactionDetail.unitName.toString()),
                              text: '06/14/2024',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: const Color(0xff1a1a1a),
                            )
                          ],
                        ),
                      ),
                      App.appSpacer.vWxxs,
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Type',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: Color(0xff808080),
                            ),
                            App.appSpacer.vHxxxs,
                            CustomTextField(
                              textAlign: TextAlign.center,
                              // text: Utils.textCapitalizationString(
                              //     transactionDetail.unitName.toString()),
                              text: isTrIn ? 'IN' : 'OUT',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: const Color(0xff1a1a1a),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  App.appSpacer.vHs,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Client',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: Color(0xff808080),
                            ),
                            App.appSpacer.vHxxxs,
                            CustomTextField(
                              textAlign: TextAlign.center,
                              // text: Utils.textCapitalizationString(
                              //     transactionDetail.unitName.toString()),
                              text: 'Acme Group',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: const Color(0xff1a1a1a),
                            )
                          ],
                        ),
                      ),
                      if(!isTrIn)...[
                        App.appSpacer.vWxxs,
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomTextField(
                                textAlign: TextAlign.left,
                                text: 'Vendor',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xff808080),
                              ),
                              App.appSpacer.vHxxxs,
                              CustomTextField(
                                textAlign: TextAlign.center,
                                // text: Utils.textCapitalizationString(
                                //     transactionDetail.unitName.toString()),
                                text: 'zyx',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: const Color(0xff1a1a1a),
                              )
                            ],
                          ),
                        ),
                        App.appSpacer.vWxxs,
                        Expanded(
                          flex: 1,
                          child: SizedBox()
                        )
                      ],
                    ],
                  ),
                  App.appSpacer.vHxs,
                ],
              )
              // )
            ),
            // App.appSpacer.vHs,
            // Obx(() =>
    Expanded(
                  child: /*inventoryModel.transactionDetailsList!.isNotEmpty ?*/
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      // itemCount: inventoryModel.transactionDetailsList!.length,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {

                        return isTrIn ? materialTransactionINTile(index, context,
                             /*inventoryModel.transactionDetailsList![index]*/)
                        : materialTransactionOutTile(index, context,
                          /*inventoryModel.transactionDetailsList![index]*/);

                      })
                      // : Container()
                  ),
            // )
          ],
        )
      ),
    );
  }

  Widget materialTransactionINTile(
      int index, BuildContext context, /*TransactionDetail transactionDetail*/) {
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
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          // text: Utils.textCapitalizationString(
                          //     transactionDetail.materialName.toString()),
                          text: 'Apple',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          // text:
                          // '(${Utils.textCapitalizationString(transactionDetail.categoryName.toString())})',
                          text: '(Fruit)',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                textAlign: TextAlign.left,
                // text: Utils.textCapitalizationString(
                //     transactionDetail.materialName.toString()),
                text: 'AULC 4022 Green',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                fontColor: const Color(0xff1A1A1A)
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Divider(
            color: kAppGreyC,
          ),
          App.appSpacer.vHxxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Received',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  CustomTextField(
                    textAlign: TextAlign.center,
                    // text: Utils.textCapitalizationString(
                    //     transactionDetail.unitName.toString()),
                    text: '10',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
              ),
              App.appSpacer.vWxs,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Remaining',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  CustomTextField(
                    textAlign: TextAlign.center,
                    // text: Utils.textCapitalizationString(
                    //     transactionDetail.unitName.toString()),
                    text: '5',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
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
              fontColor: Color(0xffD4D4D4)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTextField(
                      textAlign: TextAlign.center,
                      text: 'Out',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    App.appSpacer.vHxxxs,
                    CustomTextField(
                      textAlign: TextAlign.center,
                      // text: Utils.textCapitalizationString(
                      //     transactionDetail.unitName.toString()),
                      text: '10',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1a1a1a),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTextField(
                      textAlign: TextAlign.center,
                      text: 'Adjust',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    App.appSpacer.vHxxxs,
                    CustomTextField(
                      textAlign: TextAlign.center,
                      // text: Utils.textCapitalizationString(
                      //     transactionDetail.unitName.toString()),
                      text: '5',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1a1a1a),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTextField(
                      textAlign: TextAlign.center,
                      text: 'Return',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    App.appSpacer.vHxxxs,
                    CustomTextField(
                      textAlign: TextAlign.center,
                      // text: Utils.textCapitalizationString(
                      //     transactionDetail.unitName.toString()),
                      text: '10',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1a1a1a),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTextField(
                      textAlign: TextAlign.center,
                      text: 'IN Transit',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    App.appSpacer.vHxxxs,
                    CustomTextField(
                      textAlign: TextAlign.center,
                      // text: Utils.textCapitalizationString(
                      //     transactionDetail.unitName.toString()),
                      text: '5',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: const Color(0xff1a1a1a),
                    )
                  ],
                ),
              ),
            ],
          ),
          App.appSpacer.vHxs,
          // App.appSpacer.vHxxxs,
        ],
      ),
    );
  }

  Widget materialTransactionOutTile(
      int index, BuildContext context, /*TransactionDetail transactionDetail*/){
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
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          // text: Utils.textCapitalizationString(
                          //     transactionDetail.materialName.toString()),
                          text: 'Apple',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          // text:
                          // '(${Utils.textCapitalizationString(transactionDetail.categoryName.toString())})',
                          text: '(Fruit)',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                  textAlign: TextAlign.left,
                  // text: Utils.textCapitalizationString(
                  //     transactionDetail.materialName.toString()),
                  text: 'AULC 4022 Green',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontColor: const Color(0xff1A1A1A)
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          const Divider(
            color: kAppGreyC,
          ),
          App.appSpacer.vHxxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Out',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  CustomTextField(
                    textAlign: TextAlign.center,
                    // text: Utils.textCapitalizationString(
                    //     transactionDetail.unitName.toString()),
                    text: '10',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
              ),
              App.appSpacer.vWxs,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Return',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  CustomTextField(
                    textAlign: TextAlign.center,
                    // text: Utils.textCapitalizationString(
                    //     transactionDetail.unitName.toString()),
                    text: '5',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
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
              fontColor: Color(0xffD4D4D4)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: /*Obx(() =>*/
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                        onTap: () {
                          // if (inventoryModel.isAction.value) {
                          //   dialogReturn(context, transactionDetail);
                          // }
                        },
                        child: Column(
                          children: [
                            CustomTextField(
                              textAlign: TextAlign.center,
                              text: 'Return',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              fontColor: kAppPrimary,
                            ),
                            App.appSpacer.vHxs,
                          ],
                        ),
                        ),
                      ),
                  // )
                  ),
            ],
          ),
          // App.appSpacer.vHxxxs,
        ],
      ),
    );
}

}
