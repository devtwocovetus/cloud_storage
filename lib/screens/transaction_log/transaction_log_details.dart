import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_in_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_list_out_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_out_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_tr_in_model.dart';
import 'package:cold_storage_flutter/models/transaction_log/transaction_log_detail_tr_out_model.dart';
import 'package:cold_storage_flutter/view_models/controller/transaction_log/transaction_log_in_out_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/services/app_services.dart';

class TransactionLogDetails extends StatefulWidget {
  const TransactionLogDetails({super.key});

  @override
  State<TransactionLogDetails> createState() => _TransactionInOutState();
}

class _TransactionInOutState extends State<TransactionLogDetails> {
  final transactionLogInOutViewModel = Get.put(TransactionLogInOutViewModel());
  final _formReturn = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

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
                          height: 15,
                          width: 10,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )),
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
                          onPressed: () {},
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
      body: Obx(() => SafeArea(
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
                  child: Obx(() => Column(
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
                                      text: transactionLogInOutViewModel
                                          .transactionId.value,
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
                                      text: Utils.dateFormateNew(
                                          transactionLogInOutViewModel
                                              .transactionDate.value),
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
                                      text: transactionLogInOutViewModel
                                                  .transactionType ==
                                              'TRANSFERIN'
                                          ? 'T-IN'
                                          : transactionLogInOutViewModel
                                                      .transactionType ==
                                                  'TRANSFEROUT'
                                              ? 'T-OUT'
                                              : transactionLogInOutViewModel
                                                          .transactionType ==
                                                      'OUT'
                                                  ? 'OUT'
                                                  : 'IN',
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
                                    CustomTextField(
                                      textAlign: TextAlign.left,
                                      text: transactionLogInOutViewModel
                                                  .transactionType ==
                                              'TRANSFERIN'
                                          ? 'Dispatcher'
                                          : transactionLogInOutViewModel
                                                      .transactionType ==
                                                  'TRANSFEROUT'
                                              ? 'Receiver'
                                              : transactionLogInOutViewModel
                                                          .transactionType ==
                                                      'OUT'
                                                  ? 'Customer'
                                                  : 'Vendor',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontColor: Color(0xff808080),
                                    ),
                                    App.appSpacer.vHxxxs,
                                    CustomTextField(
                                      textAlign: TextAlign.center,
                                      text: transactionLogInOutViewModel.transactionType ==
                                              'TRANSFERIN'
                                          ? Utils.textCapitalizationString(
                                              transactionLogInOutViewModel.senderAccount
                                                  .toString())
                                          : transactionLogInOutViewModel.transactionType ==
                                                  'TRANSFEROUT'
                                              ? Utils.textCapitalizationString(
                                                  transactionLogInOutViewModel
                                                      .senderAccount
                                                      .toString())
                                              : transactionLogInOutViewModel
                                                          .transactionType ==
                                                      'OUT'
                                                  ? Utils.textCapitalizationString(
                                                      transactionLogInOutViewModel
                                                          .customerClientName
                                                          .toString())
                                                  : Utils.textCapitalizationString(
                                                      transactionLogInOutViewModel
                                                          .vendorClientName
                                                          .toString()),
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
                        ],
                      ))),
              // App.appSpacer.vHs,
              // Obx(() =>
              if (transactionLogInOutViewModel.transactionType.value ==
                  'IN') ...[
                Expanded(
                    child: transactionLogInOutViewModel
                            .transactionLogList!.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            itemCount: transactionLogInOutViewModel
                                .transactionLogList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return datailTileIn(
                                  index,
                                  context,
                                  transactionLogInOutViewModel
                                      .transactionLogList![index]);
                            })
                        : Container()),
              ] else if (transactionLogInOutViewModel.transactionType.value ==
                  'OUT') ...[
                Expanded(
                    child: transactionLogInOutViewModel
                            .transactionLogListOut!.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            itemCount: transactionLogInOutViewModel
                                .transactionLogListOut!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return datailTileOut(
                                  index,
                                  context,
                                  transactionLogInOutViewModel
                                      .transactionLogListOut![index]);
                            })
                        : Container()),
              ] else if (transactionLogInOutViewModel.transactionType.value ==
                  'TRANSFEROUT') ...[
                Expanded(
                    child: transactionLogInOutViewModel
                            .transactionLogListTrOut!.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            itemCount: transactionLogInOutViewModel
                                .transactionLogListTrOut!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return datailTileTrnsferOut(
                                  index,
                                  context,
                                  transactionLogInOutViewModel
                                      .transactionLogListTrOut![index]);
                            })
                        : Container()),
              ] else if (transactionLogInOutViewModel.transactionType.value ==
                  'TRANSFERIN') ...[
                Expanded(
                    child: transactionLogInOutViewModel
                            .transactionLogListTrIn!.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            itemCount: transactionLogInOutViewModel
                                .transactionLogListTrIn!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return datailTileTransferIn(
                                  index,
                                  context,
                                  transactionLogInOutViewModel
                                      .transactionLogListTrIn![index]);
                            })
                        : Container()),
              ]
            ],
          ))),
    );
  }

  Widget datailTileIn(int index, BuildContext context,
      TransactionDetailItemIn transactionDetailItemIn) {
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
                          text: Utils.textCapitalizationString(
                              transactionDetailItemIn.materialName.toString()),
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
                          text:
                              '(${Utils.textCapitalizationString(transactionDetailItemIn.categoryName.toString())})',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    text: transactionDetailItemIn.totalReceived.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Damage',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  CustomTextField(
                    textAlign: TextAlign.center,
                    text: transactionDetailItemIn.breakageQuantity.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
              ),
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
                    text:
                        transactionDetailItemIn.totalRemainingCount.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
              ),
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
                    text: transactionDetailItemIn.totalOut.toString(),
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
              fontColor: Color(0xffD4D4D4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 13,
                          width: 8,
                          'assets/images/ad_plus.png',
                          fit: BoxFit.cover,
                        ),
                        CustomTextField(
                          textAlign: TextAlign.center,
                          text: transactionDetailItemIn.adjustPlus.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff1a1a1a),
                        ),
                        const CustomTextField(
                          textAlign: TextAlign.center,
                          text: '/',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff1a1a1a),
                        ),
                        Image.asset(
                          height: 13,
                          width: 8,
                          'assets/images/ad_min.png',
                          fit: BoxFit.cover,
                        ),
                        CustomTextField(
                          textAlign: TextAlign.center,
                          text: transactionDetailItemIn.adjustMinus.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff1a1a1a),
                        ),
                      ],
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
                      text: transactionDetailItemIn.returnAfterMaterialIn
                          .toString(),
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
                      text: 'Transfer',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    App.appSpacer.vHxxxs,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 13,
                          width: 8,
                          'assets/images/tr_up_red.png',
                          fit: BoxFit.cover,
                        ),
                        CustomTextField(
                          textAlign: TextAlign.center,
                          text: transactionDetailItemIn.tRANSFEROUT.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff1a1a1a),
                        ),
                      ],
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
                      text: transactionDetailItemIn.intransit.toString(),
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

  Widget datailTileTransferIn(
      int index, BuildContext context, ItemTrIn transactionDetailItemIn) {
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
                          text: Utils.textCapitalizationString(
                              transactionDetailItemIn.materialName.toString()),
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
                          text:
                              '(${Utils.textCapitalizationString(transactionDetailItemIn.categoryName.toString())})',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Transfer In',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  Row(
                    children: [
                      Image.asset(
                        height: 13,
                        width: 8,
                        'assets/images/tr_down_red.png',
                        fit: BoxFit.cover,
                      ),
                      CustomTextField(
                        textAlign: TextAlign.center,
                        text: transactionDetailItemIn.tRANSFERIN.toString(),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff1a1a1a),
                      ),
                    ],
                  )
                ],
              ),
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
                    text:
                        transactionDetailItemIn.totalRemainingCount.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
              ),
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
                    text: transactionDetailItemIn.totalOut.toString(),
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
              fontColor: Color(0xffD4D4D4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 13,
                          width: 8,
                          'assets/images/ad_plus.png',
                          fit: BoxFit.cover,
                        ),
                        CustomTextField(
                          textAlign: TextAlign.center,
                          text: transactionDetailItemIn.adjustPlus.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff1a1a1a),
                        ),
                        const CustomTextField(
                          textAlign: TextAlign.center,
                          text: '/',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff1a1a1a),
                        ),
                        Image.asset(
                          height: 13,
                          width: 8,
                          'assets/images/ad_min.png',
                          fit: BoxFit.cover,
                        ),
                        CustomTextField(
                          textAlign: TextAlign.center,
                          text: transactionDetailItemIn.adjustMinus.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontColor: const Color(0xff1a1a1a),
                        ),
                      ],
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
                      text: transactionDetailItemIn.intransit.toString(),
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
                      text: 'Status',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontColor: Color(0xff808080),
                    ),
                    App.appSpacer.vHxxxs,
                    CustomTextField(
                      textAlign: TextAlign.center,
                      text: transactionDetailItemIn.status.toString(),
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

  Widget datailTileOut(
      int index, BuildContext context, ItemOut transactionDetailItem) {
    print('<><><>####.....call78');
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
                          text: Utils.textCapitalizationString(
                              transactionDetailItem.materialName.toString()),
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
                          text:
                              '(${Utils.textCapitalizationString(transactionDetailItem.categoryName.toString())})',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
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
                    text: Utils.textCapitalizationString(
                        transactionDetailItem.totalOut.toString()),
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
                    text:
                        transactionDetailItem.returnAfterMaterialOut.toString(),
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
              fontColor: Color(0xffD4D4D4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: /*Obx(() =>*/
                    Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      dialogReturn(context, transactionDetailItem);
                    },
                    child: Column(
                      children: [
                        const CustomTextField(
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

  Widget datailTileTrnsferOut(
      int index, BuildContext context, ItemTrOut transactionDetailItem) {
    print('<><><>####.....call78');
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
                          text: Utils.textCapitalizationString(
                              transactionDetailItem.materialName.toString()),
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
                          text:
                              '(${Utils.textCapitalizationString(transactionDetailItem.categoryName.toString())})',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Transfer OUT',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  Row(
                    children: [
                      Image.asset(
                        height: 13,
                        width: 8,
                        'assets/images/tr_up_red.png',
                        fit: BoxFit.cover,
                      ),
                      CustomTextField(
                        textAlign: TextAlign.center,
                        text: Utils.textCapitalizationString(
                            transactionDetailItem.totalOut.toString()),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff1a1a1a),
                      ),
                    ],
                  )
                ],
              ),
              App.appSpacer.vWxs,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Status',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xff808080),
                  ),
                  App.appSpacer.vHxxxs,
                  CustomTextField(
                    textAlign: TextAlign.center,
                    text: transactionDetailItem.status.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  )
                ],
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
           App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
             App.appSpacer.vHxxxs,
              App.appSpacer.vHxxxs,
               App.appSpacer.vHxxxs,
         
          // App.appSpacer.vHxxxs,
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  dialogReturn(
      BuildContext context, ItemOut transactionDetailItem) {
    var remaing = int.parse(transactionDetailItem.totalOut.toString()) -
        int.parse(transactionDetailItem.returnAfterMaterialOut.toString());
    transactionLogInOutViewModel.availableQuantityController.value.text =
        remaing.toString();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(15),
            backgroundColor: const Color(0xffffffff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: Form(
                    key: _formReturn,
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Available quantity',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                          App.appSpacer.vHxxs,
                          CustomTextFormField(
                            readOnly: true,
                            width: App.appQuery.responsiveWidth(90),
                            height: 25,
                            borderRadius: BorderRadius.circular(10.0),
                            hint: 'Quantity',
                            controller: transactionLogInOutViewModel
                                .availableQuantityController.value,
                            focusNode: transactionLogInOutViewModel
                                .availableQuantityFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                          ),
                          App.appSpacer.vHs,
                          const CustomTextField(
                              required: true,
                              textAlign: TextAlign.left,
                              text: 'Return Quantity',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                          App.appSpacer.vHxxs,
                          CustomTextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9.]")),
                            ],
                            width: App.appQuery.responsiveWidth(90),
                            height: 25,
                            borderRadius: BorderRadius.circular(10.0),
                            hint: 'Return Quantity',
                            controller: transactionLogInOutViewModel
                                .quantityReturnController.value,
                            focusNode: transactionLogInOutViewModel
                                .quantityReturnFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter quantity';
                              } else if (int.parse(value) >
                                  int.parse(transactionLogInOutViewModel
                                      .availableQuantityController
                                      .value
                                      .text)) {
                                return 'Not have enough quantity available';
                              }
                              return null;
                            },
                          ),
                          App.appSpacer.vHs,
                          const CustomTextField(
                              required: true,
                              textAlign: TextAlign.left,
                              text: 'Date of Return',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                          App.appSpacer.vHxxs,
                          CustomTextFormField(
                            onTab: () async {
                              await _selectDate(
                                  context,
                                  transactionLogInOutViewModel
                                      .dateReturnController.value);
                            },
                            suffixIcon: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                              child: Image.asset(
                                'assets/images/ic_calender.png',
                              ),
                            ),
                            width: App.appQuery.responsiveWidth(90),
                            height: 25,
                            borderRadius: BorderRadius.circular(10.0),
                            hint: 'Date of Return',
                            controller: transactionLogInOutViewModel
                                .dateReturnController.value,
                            focusNode: transactionLogInOutViewModel
                                .dateReturnFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.none,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Select date of return';
                              }
                              return null;
                            },
                          ),
                          App.appSpacer.vHs,
                          const CustomTextField(
                              required: true,
                              textAlign: TextAlign.left,
                              text: 'Reason Of Return',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                          App.appSpacer.vHxxs,
                          CustomTextFormField(
                            width: App.appQuery.responsiveWidth(90),
                            height: 25,
                            minLines: 2,
                            maxLines: 4,
                            borderRadius: BorderRadius.circular(10.0),
                            hint: 'Information',
                            controller: transactionLogInOutViewModel
                                .reasonReturnController.value,
                            focusNode: transactionLogInOutViewModel
                                .reasonReturnFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.text,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter reason for return';
                              }
                              return null;
                            },
                          ),
                          App.appSpacer.vHs,
                          const CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Comments/Notes',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                          App.appSpacer.vHxxs,
                          CustomTextFormField(
                              width: App.appQuery.responsiveWidth(90),
                              height: 25,
                              minLines: 2,
                              maxLines: 4,
                              borderRadius: BorderRadius.circular(10.0),
                              hint: 'Information',
                              controller: transactionLogInOutViewModel
                                  .commentsNotesReturnController.value,
                              focusNode: transactionLogInOutViewModel
                                  .commentsNotesReturnFocusNode.value,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.text),
                          App.appSpacer.vHs,
                          App.appSpacer.vHs,
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                App.appQuery.responsiveWidth(5),
                                0,
                                App.appQuery.responsiveWidth(5),
                                0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyCustomButton(
                                  textColor: const Color(0xffFFFFFF),
                                  backgroundColor: const Color(0xff005AFF),
                                  width: App.appQuery
                                      .responsiveWidth(30) /*312.0*/,
                                  height: 45,
                                  borderRadius: BorderRadius.circular(10.0),
                                  onPressed: () async {
                                    if (_formReturn.currentState!.validate()) {
                                      await transactionLogInOutViewModel
                                          .transactionReturn(
                                              context,
                                              transactionDetailItem.id
                                                  .toString(),
                                              _formReturn);
                                    }
                                  },
                                  text: 'Confirm',
                                ),
                                MyCustomButton(
                                  textColor: const Color(0xff000000),
                                  backgroundColor: const Color(0xffD9D9D9),
                                  width: App.appQuery
                                      .responsiveWidth(30) /*312.0*/,
                                  height: 45,
                                  borderRadius: BorderRadius.circular(10.0),
                                  onPressed: () {
                                    _formReturn.currentState!.reset();
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancel',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        });
  }
}
