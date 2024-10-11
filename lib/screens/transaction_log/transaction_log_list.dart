import 'dart:developer';

import 'package:cold_storage_flutter/models/transaction_log/transaction_log_list_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transaction_log/transaction_log_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/dropdown/model/dropdown_item_model.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;


class TransactionLogList extends StatefulWidget {
  const TransactionLogList({super.key});

  @override
  State<TransactionLogList> createState() =>
      _TransactionLogListState();
}

class _TransactionLogListState extends State<TransactionLogList> {
  final transactionLogListViewModel = Get.put(TransactionLogListViewModel());
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
    double fullWidth = Utils.deviceWidth(context) * 0.9;
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
                          height: 15.h,
                          width: 10.h,
                          'assets/images/ic_back_btn.png',
                          fit: BoxFit.cover,
                        )
                    ),
                      Expanded(
                       child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.transaction,
                          fontSize: 18.0.sp,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                     ),
                    SizedBox(
                      width: 5.h,
                    ),
                    // Padding(
                    //   padding: App.appSpacer.edgeInsets.top.none,
                    //   child: IconButton(
                    //       padding: EdgeInsets.zero,
                    //       onPressed: () {
                    //         Get.until((route) =>
                    //         Get.currentRoute == RouteName.homeScreenView);
                    //       },
                    //       icon: const SVGAssetImage(
                    //         height: 20,
                    //         width: 20,
                    //         url: 'assets/images/default/ic_home.svg',
                    //         fit: BoxFit.cover,
                    //       )),
                    // ),
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
          child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
                Utils.deviceWidth(context) * 0.03, 0),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: CustomSearchField(
                      margin: App.appSpacer.edgeInsets.x.none,
                      searchController: transactionLogListViewModel.searchController.value,
                      prefixIconVisible: true,
                      filled: true,
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          transactionLogListViewModel.searchFilter('');
                        } else if (value.isNotEmpty) {
                          transactionLogListViewModel.searchFilter(value);
                        }
                      },
                      onSubmit: (value) async {
                        if (value.isEmpty) {
                          transactionLogListViewModel.searchFilter('');
                        } else if (value.isNotEmpty) {
                          transactionLogListViewModel.searchFilter(value);
                        }
                      },
                      onCrossTapped: () {
                        transactionLogListViewModel.searchFilter('');
                        transactionLogListViewModel.searchController.value.clear();
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
          App.appSpacer.vHs,
          Expanded(
              child: !transactionLogListViewModel.isLoading.value ? transactionLogListViewModel.transactionLogList!.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: transactionLogListViewModel.transactionLogList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return clientViewTile(index, context,
                            transactionLogListViewModel.transactionLogList![index]);
                      })
                  :_emptyView
                  : const SizedBox.expand(),
            ),
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
          Image.asset('assets/images/ic_blank_list.png'),
          SizedBox(
            height: 10.h,
          ),
           CustomTextField(
              textAlign: TextAlign.center,
              text: translation.no_transaction_found,
              fontSize: 18.0.sp,
              fontColor: Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ],
      ),
    );
  }

  Widget sortingDropdown(){
    return MyCustomDropDown<DropdownItemModel>(
      itemList: transactionLogListViewModel.sortingItems,
      hintText: translation.sort_by,
      hintFontSize: 13.5.sp,
      enableBorder: false,
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
          transactionLogListViewModel.sortListByProperty(item);
        }
      },
    );
  }

  Widget clientViewTile(
      int index, BuildContext context, TransactionLogItem transactionLogItem) {
    return GestureDetector(
     onTap: () => {
          Get.toNamed(RouteName.transactionInOut, arguments: [
            {
              "transactionId":transactionLogItem.id.toString(),
              "transactionDate":transactionLogItem.transactionDate.toString(),
              "transactionType":transactionLogItem.transactionType.toString(),
              "vendorClientName":transactionLogItem.vendorClientName.toString(),
              "senderAccount":transactionLogItem.senderAccount.toString(),
              "customerClientName":transactionLogItem.customerClientName.toString(),
              "from":'Normal',
              
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
                  width: Utils.deviceWidth(context) * 0.40,
                  child:  CustomTextField(
                    textAlign: TextAlign.left,
                    text: transactionLogItem.transactionType == 'TRANSFERIN' ? translation.dispatcher : transactionLogItem.transactionType == 'TRANSFEROUT' ? translation.receiver : transactionLogItem.transactionType == 'OUT' ? translation.customer : translation.vendor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.28,
                  child:  CustomTextField(
                    textAlign: TextAlign.left,
                    text: translation.date,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.19,
                  child:  CustomTextField(
                    textAlign: TextAlign.center,
                    text: translation.type,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.40,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                   text: transactionLogItem.transactionType == 'TRANSFERIN' ? Utils.textCapitalizationString(transactionLogItem.senderAccount.toString()) : transactionLogItem.transactionType == 'TRANSFEROUT' ?  Utils.textCapitalizationString(transactionLogItem.senderAccount.toString()) : transactionLogItem.transactionType == 'OUT' ? Utils.textCapitalizationString(transactionLogItem.customerClientName.toString()) : Utils.textCapitalizationString(transactionLogItem.vendorClientName.toString()),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.28,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    text: Utils.dateFormateNew(
                        transactionLogItem.transactionDate.toString()),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.19,
                  child: CustomTextField(
                    textAlign: TextAlign.center,
                   text: transactionLogItem.transactionType == 'TRANSFERIN' ? translation.transfer_in : transactionLogItem.transactionType == 'TRANSFEROUT' ? translation.transfer_out : transactionLogItem.transactionType == 'OUT' ? translation.out : translation.in_text,
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
