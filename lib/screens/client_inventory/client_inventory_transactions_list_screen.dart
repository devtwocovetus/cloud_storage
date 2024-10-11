import 'dart:developer';

import 'package:cold_storage_flutter/models/client/client_inventory_transactions_list.dart';
import 'package:cold_storage_flutter/res/components/dropdown/model/dropdown_item_model.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/client_inventory/client_inventory_transactions_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../i10n/strings.g.dart' as i18n;

class ClientInventoryTransactionsListScreen extends StatefulWidget {
  const ClientInventoryTransactionsListScreen({super.key});

  @override
  State<ClientInventoryTransactionsListScreen> createState() =>
      _ClientInventoryTransactionsListScreenState();
}

class _ClientInventoryTransactionsListScreenState
    extends State<ClientInventoryTransactionsListScreen> {
  final inventoryTransactionsViewModel = Get.put(ClientInventoryTransactionsViewModel());
  final emailController = TextEditingController();

    late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Container(
              height: 60.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Image.asset(
                          height: 15.h,
                          width: 10.h,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )
                    ),
                    Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                                       text:Utils.textCapitalizationString(inventoryTransactionsViewModel.accountName.value),
                          fontSize: 18.0.sp,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 5,),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Get.toNamed(RouteName.notificationList)!.then((value) {});
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
                      child: Obx(()=> IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20.h,
                              width: 20.h,
                              fit: BoxFit.cover,
                              url: UserPreference.profileLogo.value
                          )
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
                Utils.deviceWidth(context) * 0.03, 0),
            child:  Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: '${translation.transaction} (${Utils.textCapitalizationString(inventoryTransactionsViewModel.unitName.value)})',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h,),
          Padding(
            padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
                Utils.deviceWidth(context) * 0.03, 0),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: CustomSearchField(
                      margin: App.appSpacer.edgeInsets.x.none,
                      searchController: TextEditingController(),
                      prefixIconVisible: true,
                      filled: true,
                      enable: false,
                      onCrossTapped: () {

                      },
                    )
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    decoration: const BoxDecoration(
                        color: Color(0xFFEFF8FF),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: sortingDropdown(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h,),
          Obx(
            () => Expanded(
              child: !inventoryTransactionsViewModel.isLoading.value ? inventoryTransactionsViewModel.transactionList!.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          inventoryTransactionsViewModel.transactionList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return clientViewTile(index, context,
                            inventoryTransactionsViewModel.transactionList![index]);
                      })
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
                              'assets/images/ic_blank_list.png'),
                          SizedBox(
                            height: 10.h,
                          ),
                           CustomTextField(
                              textAlign: TextAlign.center,
                              text: translation.no_transaction_found,
                              fontSize: 18.0.sp,
                              fontColor: Color(0xFF000000),
                              fontWeight: FontWeight.w500
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ): const SizedBox.expand(),
            ),
          )
        ],
      )),
    );
  }

  Widget sortingDropdown(){
    return MyCustomDropDown<DropdownItemModel>(
      itemList: inventoryTransactionsViewModel.sortingItems,
      hintText: translation.sort_by,
      enableBorder: false,
      hintFontSize: 13.5.sp,
      padding: App.appSpacer.edgeInsets.symmetric(x: 'xs',y: 's'),
      validateOnChange: true,
      headerBuilder: (context, selectedItem, enabled) {
        return Text(selectedItem.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack,fontWeight: FontWeight.w400,fontSize: 14.0.sp)),
        );
      },
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(item.title,
          style: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.6),fontWeight: FontWeight.w400,fontSize: 14.0.sp)),
        );
      },
      onChange: (item) {
        log('changing value to: $item');
        if(item != null){
          inventoryTransactionsViewModel.sortListByProperty(item);
        }
      },
    );
  }

  Widget clientViewTile(
      int index, BuildContext context, ClientTransaction transaction) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(RouteName.clientInventoryTransactionsDetailScreen, arguments: [
          {
            "transactionId":transaction.transactionMasterId.toString(),
            "accountId": inventoryTransactionsViewModel.accountId.value,
            "accountName":inventoryTransactionsViewModel.accountName.value,
            "isManual":inventoryTransactionsViewModel.isManual.value,
          }
        ])
      },
      child: Container(
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: index % 2 == 0
              ? const Color(0xffEFF8FF)
              : const Color(0xffFFFFFF),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.35,
                  child:  CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.transaction_date,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child:  CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.received,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.27,
                  child:  CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.remaining,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h,),
            Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.35,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.dateFormate(
                        transaction.transactionDate.toString()),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        transaction.receivedQuantity.toString()),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.27,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.textCapitalizationString(
                        transaction.totalRemainingCount.toString()),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
          ],
        ),
      ),
    );
  }

  toggleDone(bool bool) {}
}
