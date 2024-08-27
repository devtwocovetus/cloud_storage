import 'package:cold_storage_flutter/models/transfer/material_transfer_detail_model.dart';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/transfer_detail_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

class TransferIncomingMaterial extends StatelessWidget {
  TransferIncomingMaterial({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(TransferDetailViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: bottomGestureButtons(context),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Incoming Material',
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
                              height: 20,
                              width: 20,
                              url: controller.logoUrl.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: App.appSpacer.edgeInsets.y.smm,
              child: Obx(
                () => Form(
                  key: _coldStorageFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      clientViewTile(context),
                      App.appSpacer.vHs,
                      _entityNameWidget,
                      App.appSpacer.vHs,
                      _clientNameWidget,
                      App.appSpacer.vHs,
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.incomingList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return materialTile(index, context,
                                controller.incomingList![index]);
                          }),
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      App.appSpacer.vHxxl,
                      // _addButtonWidget
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget get _entityNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Entity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            initialValue: controller.entityName.value,
            enabled: controller.isConfirm.value ? false : true,
            itemList: controller.entityList,
            hintText: 'Select Entity',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            validator: (value) {
              if (value == null) {
                return "   Select a entity";
              }
              return null;
            },
            onChange: (item) {
              controller.entityName.value = item.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget get _clientNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Select Client',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            itemList: controller.clientList,
            hintText: 'Select Client',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            onChange: (item) {
              controller.mStrClient.value = item!.toString();
            },
            validator: (value) {
              if (value == null || value == 'Select Client') {
                return "   Select a client";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get _addButtonWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          // if (_coldStorageFormKey.currentState!.validate())
          //   {
          //     if (controller.entityQuantityList.isNotEmpty)
          //       {controller.isConfirm.value = true}
          //     else
          //       {
          //         Utils.isCheck = true,
          //         Utils.snackBar('Error', 'Please add quantity')
          //       }
          //   }
        },
        text: 'Confirm',
      ),
    );
  }

  Widget bottomGestureButtons(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyCustomButton(
              textColor: kAppBlack,
              backgroundColor: kAppGrey,
              width: App.appQuery.responsiveWidth(35) /*312.0*/,
              height: 45,
              borderRadius: BorderRadius.circular(10.0),
              onPressed: () => {controller.requestReject()},
              text: 'Reject',
            ),
            MyCustomButton(
              backgroundColor: controller.listStatus.contains(false)
                  ? kAppPrimary.withOpacity(0.5)
                  : kAppPrimary,
              width: App.appQuery.responsiveWidth(35) /*312.0*/,
              height: 45,
              borderRadius: BorderRadius.circular(10.0),
              onPressed: () => {
                if (!controller.listStatus.contains(false))
                  {controller.transferAccept()}
              },
              text: 'Accept',
            )
          ],
        ));
  }

  Widget materialTile(int indexList, BuildContext context,
      IncomingMaterials incomingMaterials) {
    return GestureDetector(
      onTap: () {
        if (_coldStorageFormKey.currentState!.validate()) {
          int index =
              controller.clientList.indexOf(controller.mStrClient.value.trim());
          int indexEntity =
              controller.entityList.indexOf(controller.entityName.value.trim());
          Get.toNamed(RouteName.transferMaterialScreen, arguments: [
            {
              "entityName": Utils.textCapitalizationString(
                  controller.entityName.toString()),
              "entityId": controller.entityListId[indexEntity].toString(),
              "clientName": Utils.textCapitalizationString(
                  controller.mStrClient.toString()),
              "clientId": controller.clientListId[index].toString(),
              "supplierName": Utils.textCapitalizationString(
                  controller.supplierName.value.toString()),
              "receiverName": Utils.textCapitalizationString(
                  controller.receiverAccountName.toString()),
              "materialName": Utils.textCapitalizationString(
                  incomingMaterials.materialName.toString()),
              "receiverId": controller.receiverAccountId.toString(),
              "categoryId": incomingMaterials.categoryId.toString(),
              "categoryName": Utils.textCapitalizationString(
                  incomingMaterials.categoryName.toString()),
              "materialId": incomingMaterials.materialId.toString(),
              "unitId": incomingMaterials.unitId.toString(),
              "unitName": Utils.textCapitalizationString(
                  incomingMaterials.unitName.toString()),
              "transactionDetailId": incomingMaterials.id.toString(),
              "quantity": incomingMaterials.quantity.toString(),
              "index": indexList.toString(),
              "uom":
                  '${incomingMaterials.quantity} (${Utils.textCapitalizationString(incomingMaterials.mouName.toString())}, ${Utils.textCapitalizationString(incomingMaterials.mouType.toString())})',
            }
          ]);
        }
      },
      child: Container(
        margin: App.appSpacer.edgeInsets.x.sm,
        padding: EdgeInsets.fromLTRB(
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            Utils.deviceWidth(context) * 0.03,
            0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: indexList % 2 == 0
              ? const Color(0xffEFF8FF)
              : const Color(0xffFFFFFF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.36,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Material',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff808080),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            incomingMaterials.materialName.toString()),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.195,
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
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            incomingMaterials.unitName.toString()),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.195,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Quantity',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff808080),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: incomingMaterials.quantity.toString(),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.10,
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.listStatus[indexList] == false) ...[
                            Image.asset(
                              'assets/images/ic_list_nonconfirm.png',
                              width: 20,
                              height: 20,
                            ),
                          ] else ...[
                            Image.asset(
                              'assets/images/ic_list_confirm.png',
                              width: 20,
                              height: 20,
                            ),
                          ]
                        ],
                      )),
                ),
              ],
            ),
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
            App.appSpacer.vHxxxs,
          ],
        ),
      ),
    );
  }

  Widget clientViewTile(BuildContext context) {
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
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Supplier',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Client',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Quantity',
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
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      controller.supplierName.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      controller.clientName.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      controller.quantityCount.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
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
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Receipt Date',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Driver Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
              ),
            ],
          ),
          App.appSpacer.vHxxxs,
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: controller.receiptDate.toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.36,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: Utils.textCapitalizationString(
                      controller.driverName.toString()),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.15,
              ),
            ],
          ),
          App.appSpacer.vHs,
          const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Note',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: Color(0xff808080),
          ),
          App.appSpacer.vHxxxs,
          const CustomTextField(
            line: 4,
            isMultyline: true,
            textAlign: TextAlign.left,
            text:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontColor: Color(0xff1A1A1A),
          ),
          App.appSpacer.vHs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
          App.appSpacer.vHxxxs,
        ],
      ),
    );
  }
}
