import 'package:cold_storage_flutter/models/inventory/inventory_transactions_detail_list_model.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_units_list_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/screens/client/widget/dashed_line_vertical_painter.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/inventory/inventory_transactions_details_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/inventory/inventory_units_view_model.dart';

class InventoryTransactionsDetailScreen extends StatefulWidget {
  const InventoryTransactionsDetailScreen({super.key});

  @override
  State<InventoryTransactionsDetailScreen> createState() =>
      _InventoryTransactionsDetailScreenState();
}

class _InventoryTransactionsDetailScreenState
    extends State<InventoryTransactionsDetailScreen> {
  final _formAdjusted = GlobalKey<FormState>();
  final _formReturn = GlobalKey<FormState>();
  final inventoryModel = Get.put(InventoryTransactionsDetailsViewModel());
  final emailController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    double fullWidth = Utils.deviceWidth(context) * 0.9;
    return Scaffold(
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
                padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03,
                    0, Utils.deviceWidth(context) * 0.03, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        height: 20,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Transaction Detail',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffEFF8FF),
            ),
            child: Obx(() => Padding(
                  padding: EdgeInsets.fromLTRB(
                      Utils.deviceWidth(context) * 0.04,
                      Utils.deviceWidth(context) * 0.02,
                      Utils.deviceWidth(context) * 0.04,
                      Utils.deviceWidth(context) * 0.02),
                  child: Row(
                    children: [
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Do you want to perform action?',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff7E7E7E)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          inventoryModel.isAction.value =
                              !inventoryModel.isAction.value;
                        },
                        child: inventoryModel.isAction.value
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
                )),
          ),
          App.appSpacer.vHs,
          Container(
              margin: EdgeInsets.fromLTRB(
                  Utils.deviceWidth(context) * 0.03,
                  0,
                  Utils.deviceWidth(context) * 0.03,
                  Utils.deviceWidth(context) * 0.03),
              padding: EdgeInsets.fromLTRB(
                  Utils.deviceWidth(context) * 0.03,
                  Utils.deviceWidth(context) * 0.03,
                  Utils.deviceWidth(context) * 0.03,
                  0),
              child: Obx(
                () => Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Utils.deviceWidth(context) * 0.35,
                          child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Transaction ID',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: Color(0xffAEAEAE),
                          ),
                        ),
                        SizedBox(
                          width: Utils.deviceWidth(context) * 0.38,
                          child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Transaction Date',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: Color(0xffAEAEAE),
                          ),
                        ),
                        SizedBox(
                          width: Utils.deviceWidth(context) * 0.14,
                          child: const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Type',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: Color(0xffAEAEAE),
                          ),
                        ),
                      ],
                    ),
                    App.appSpacer.vHxxxs,
                    Row(
                      children: [
                        SizedBox(
                          width: Utils.deviceWidth(context) * 0.35,
                          child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: Utils.textCapitalizationString(inventoryModel
                                .transactionResId.value
                                .toString()),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: const Color(0xff1a1a1a),
                          ),
                        ),
                        SizedBox(
                          width: Utils.deviceWidth(context) * 0.40,
                          child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: Utils.dateFormate(inventoryModel
                                .transactionDate.value
                                .toString()),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: const Color(0xff1a1a1a),
                          ),
                        ),
                        SizedBox(
                          width: Utils.deviceWidth(context) * 0.12,
                          child: CustomTextField(
                            textAlign: TextAlign.left,
                            text: inventoryModel.transactionType.value
                                .toUpperCase(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: const Color(0xff1a1a1a),
                          ),
                        ),
                      ],
                    ),
                    App.appSpacer.vHs,
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: Utils.deviceWidth(context) * 0.40,
                              child: const CustomTextField(
                                textAlign: TextAlign.left,
                                text: 'Client',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xffAEAEAE),
                              ),
                            ),
                            SizedBox(
                              width: Utils.deviceWidth(context) * 0.40,
                              child: CustomTextField(
                                textAlign: TextAlign.left,
                                text: Utils.textCapitalizationString(
                                    inventoryModel.clientName.toString()),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontColor: const Color(0xff1a1a1a),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: Utils.deviceWidth(context) * 0.28),
                        SizedBox(
                          width: Utils.deviceWidth(context) * 0.20,
                          child: MyCustomButton(
                            width: 50,
                            height: 40.0,
                            borderRadius: BorderRadius.circular(10.0),
                            backgroundColor: inventoryModel.isAction.value
                                ? const Color(0xff005AFF)
                                : const Color(0xffB3CEFF),
                            onPressed: () => {},
                            text: 'Update',
                          ),
                        ),
                      ],
                    ),
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                    App.appSpacer.vHxxxs,
                  ],
                ),
              )),
          App.appSpacer.vHs,
          Obx(
            () => Expanded(
                child: inventoryModel.transactionDetailsList!.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:
                            inventoryModel.transactionDetailsList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return clientViewTile(index, context,
                              inventoryModel.transactionDetailsList![index]);
                        })
                    : Container()),
          )
        ],
      )),
    );
  }

  Widget clientViewTile(
      int index, BuildContext context, TransactionDetail transactionDetail) {
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
                child: Row(
                  children: [
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            transactionDetail.materialName.toString()),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff1A1A1A)),
                    const SizedBox(
                      width: 3,
                    ),
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text:
                            '(${Utils.textCapitalizationString(transactionDetail.categoryName.toString())})',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff808080)),
                  ],
                ),
              ),
              Image.asset(
                height: 25,
                width: 25,
                'assets/images/ic_gallary.png',
                fit: BoxFit.cover,
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
                width: Utils.deviceWidth(context) * 0.40,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Unit',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.25,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Received',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.22,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Remaining',
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
                width: Utils.deviceWidth(context) * 0.40,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      transactionDetail.unitName.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.25,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      transactionDetail.totalReceived.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.22,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      transactionDetail.totalRemainingCount.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
            ],
          ),
          App.appSpacer.vHs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.40,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Bin',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.25,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Expiry Date',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.22,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Type',
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
                width: Utils.deviceWidth(context) * 0.40,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: transactionDetail.binName.toString() == 'null' ? '' :  Utils.textCapitalizationString(
                          transactionDetail.binName.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.25,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.dateFormate(
                      transactionDetail.expiryDate.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.22,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      transactionDetail.quantityTypeName.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
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
                  child: Obx(
                () => GestureDetector(
                  onTap: () {
                    if (inventoryModel.isAction.value) {
                      dialogReturn(context, transactionDetail);
                    }
                  },
                  child: CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Return',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor: inventoryModel.isAction.value
                        ? const Color(0xff005AFF)
                        : const Color(0xffB3CEFF),
                  ),
                ),
              )),
              CustomPaint(
                  size: const Size(1, 40),
                  painter: DashedLineVerticalPainter()),
              Expanded(
                child: Obx(() => GestureDetector(
                      onTap: () {
                        if (inventoryModel.isAction.value) {
                          dialogAdjustment(context, transactionDetail);
                        }
                      },
                      child: CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Adjust',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        fontColor: inventoryModel.isAction.value
                            ? const Color(0xff005AFF)
                            : const Color(0xffB3CEFF),
                      ),
                    )),
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
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

  dialogAdjustment(BuildContext context, TransactionDetail transactionDetail) {
    inventoryModel.availableQuantityController.value.text =
        transactionDetail.totalRemainingCount.toString();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(15),
            backgroundColor: const Color(0xffffffff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: Form(
                    key: _formAdjusted,
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomTextField(
                                  textAlign: TextAlign.left,
                                  text: 'Type Of Adjustment',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Color(0xff7E7E7E)),
                              const Spacer(),
                              const CustomTextField(
                                  text: 'Remove',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  fontColor: Color(0xff000000)),
                              const SizedBox(
                                width: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  inventoryModel.isTypeOfAdjustment.value =
                                      !inventoryModel.isTypeOfAdjustment.value;
                                },
                                child: inventoryModel.isTypeOfAdjustment.value
                                    ? Image.asset(
                                        'assets/images/ic_switchB_on.png',
                                        width: 34,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/ic_switchB_off.png',
                                        width: 34,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const CustomTextField(
                                  text: 'Add',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  fontColor: Color(0xff000000))
                            ],
                          ),
                          App.appSpacer.vHs,
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
                            controller: inventoryModel
                                .availableQuantityController.value,
                            focusNode:
                                inventoryModel.availableQuantityFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                          ),
                          App.appSpacer.vHs,
                          const CustomTextField(
                              required: true,
                              textAlign: TextAlign.left,
                              text: 'Quantity Adjusted',
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
                            hint: 'Quantity Adjusted',
                            controller:
                                inventoryModel.quantityAdjustedController.value,
                            focusNode:
                                inventoryModel.quantityAdjustedFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Quantity';
                              } else if (!inventoryModel
                                      .isTypeOfAdjustment.value &&
                                  int.parse(value) >
                                      int.parse(inventoryModel
                                          .availableQuantityController
                                          .value
                                          .text)) {
                                return 'Not have enough Quantity available';
                              }
                              return null;
                            },
                          ),
                          App.appSpacer.vHs,
                          const CustomTextField(
                              required: true,
                              textAlign: TextAlign.left,
                              text: 'Date of Adjusted',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff1A1A1A)),
                          App.appSpacer.vHxxs,
                          CustomTextFormField(
                            onTab: () async {
                              await _selectDate(context,
                                  inventoryModel.dateAdjustedController.value);
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
                            hint: 'Date of Adjusted',
                            controller:
                                inventoryModel.dateAdjustedController.value,
                            focusNode:
                                inventoryModel.dateAdjustedFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.none,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Select date of adjusted';
                              }
                              return null;
                            },
                          ),
                          App.appSpacer.vHs,
                          const CustomTextField(
                              textAlign: TextAlign.left,
                              text: 'Reason for Adjustment',
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
                            controller:
                                inventoryModel.reasonAdjustmentController.value,
                            focusNode:
                                inventoryModel.reasonAdjustmentFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.text,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter reason for adjustment';
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
                              controller:
                                  inventoryModel.commentsNotesController.value,
                              focusNode:
                                  inventoryModel.commentsNotesFocusNode.value,
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
                              children: [
                                MyCustomButton(
                                  textColor: const Color(0xffFFFFFF),
                                  backgroundColor: const Color(0xff005AFF),
                                  width: App.appQuery
                                      .responsiveWidth(30) /*312.0*/,
                                  height: 45,
                                  borderRadius: BorderRadius.circular(10.0),
                                  onPressed: () async {
                                    if (_formAdjusted.currentState!
                                        .validate()) {
                                      await inventoryModel.transactionAdjust(
                                          context,
                                          transactionDetail.id.toString());
                                      // await controller.addFarmhouse()
                                      //await controller.addFarmHouse2()
                                    }
                                  },
                                  text: 'Confirm',
                                ),
                                const Spacer(),
                                MyCustomButton(
                                  textColor: const Color(0xff000000),
                                  backgroundColor: const Color(0xffD9D9D9),
                                  width: App.appQuery
                                      .responsiveWidth(30) /*312.0*/,
                                  height: 45,
                                  borderRadius: BorderRadius.circular(10.0),
                                  onPressed: () {
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

  dialogReturn(BuildContext context, TransactionDetail transactionDetail) {
    inventoryModel.availableQuantityController.value.text =
        transactionDetail.totalRemainingCount.toString();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(15),
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
                            controller: inventoryModel
                                .availableQuantityController.value,
                            focusNode:
                                inventoryModel.availableQuantityFocusNode.value,
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
                            controller:
                                inventoryModel.quantityReturnController.value,
                            focusNode:
                                inventoryModel.quantityReturnFocusNode.value,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Quantity';
                              } else if (int.parse(value) >
                                  int.parse(inventoryModel
                                      .availableQuantityController
                                      .value
                                      .text)) {
                                return 'Not have enough Quantity available';
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
                              await _selectDate(context,
                                  inventoryModel.dateReturnController.value);
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
                            controller:
                                inventoryModel.dateReturnController.value,
                            focusNode: inventoryModel.dateReturnFocusNode.value,
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
                            controller:
                                inventoryModel.reasonReturnController.value,
                            focusNode:
                                inventoryModel.reasonReturnFocusNode.value,
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
                              controller: inventoryModel
                                  .commentsNotesReturnController.value,
                              focusNode: inventoryModel
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
                                      await inventoryModel.transactionReturn(
                                          context,
                                          transactionDetail.id.toString());
                                    }
                                  },
                                  text: 'Confirm',
                                ),
                                const Spacer(),
                                MyCustomButton(
                                  textColor: const Color(0xff000000),
                                  backgroundColor: const Color(0xffD9D9D9),
                                  width: App.appQuery
                                      .responsiveWidth(30) /*312.0*/,
                                  height: 45,
                                  borderRadius: BorderRadius.circular(10.0),
                                  onPressed: () {
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
