import 'package:cold_storage_flutter/models/transaction_log/transaction_log_list_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transaction_log/transaction_log_list_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/components/search_field/custom_search_field.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';


class TransactionLogList extends StatefulWidget {
  const TransactionLogList({super.key});

  @override
  State<TransactionLogList> createState() =>
      _TransactionLogListState();
}

class _TransactionLogListState extends State<TransactionLogList> {
  final transactionLogListViewModel = Get.put(TransactionLogListViewModel());
  final emailController = TextEditingController();

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
                      child: Obx(()=> IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20,
                              width: 20,
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
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: CustomSearchField(
                      margin: App.appSpacer.edgeInsets.x.none,
                      searchController: TextEditingController(),
                      prefixIconVisible: true,
                      filled: true,
                    )
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    decoration: const BoxDecoration(
                        color: Color(0xFFEFF8FF),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: const SizedBox(),
                        hint: const CustomTextField(
                          text: 'Sort By',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff828282),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          App.appSpacer.vHs,
          Obx(
            () => Expanded(
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
          )
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
          Image.asset('assets/images/ic_blank_list.png'),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(
              textAlign: TextAlign.center,
              text: 'No Transaction Found',
              fontSize: 18.0,
              fontColor: Color(0xFF000000),
              fontWeight: FontWeight.w500),
        ],
      ),
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
                    text: transactionLogItem.transactionType == 'TRANSFERIN' ? 'Dispatcher' : transactionLogItem.transactionType == 'TRANSFEROUT' ? 'Receiver' : transactionLogItem.transactionType == 'OUT' ? 'Customer' : 'Vendor',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.28,
                  child: const CustomTextField(
                    textAlign: TextAlign.left,
                    text: 'Date',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: Color(0xffAEAEAE),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.19,
                  child: const CustomTextField(
                    textAlign: TextAlign.center,
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
                  width: Utils.deviceWidth(context) * 0.40,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                   text: transactionLogItem.transactionType == 'TRANSFERIN' ? Utils.textCapitalizationString(transactionLogItem.senderAccount.toString()) : transactionLogItem.transactionType == 'TRANSFEROUT' ?  Utils.textCapitalizationString(transactionLogItem.senderAccount.toString()) : transactionLogItem.transactionType == 'OUT' ? Utils.textCapitalizationString(transactionLogItem.customerClientName.toString()) : Utils.textCapitalizationString(transactionLogItem.vendorClientName.toString()),
                    fontSize: 14,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.19,
                  child: CustomTextField(
                    textAlign: TextAlign.center,
                   text: transactionLogItem.transactionType == 'TRANSFERIN' ? 'T-IN' : transactionLogItem.transactionType == 'TRANSFEROUT' ? 'T-OUT' : transactionLogItem.transactionType == 'OUT' ? 'OUT' : 'IN',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: const Color(0xff1a1a1a),
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
      ),
    );
  }

  toggleDone(bool bool) {}
}
