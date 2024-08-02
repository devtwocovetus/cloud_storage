
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material_in/quantity_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

class PurchaseFinancialDetails extends StatelessWidget {
  PurchaseFinancialDetails({super.key});
  DateTime selectedDate = DateTime.now();
  final quantityViewModel = Get.put(QuantityViewModel());
  final _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Visibility(visible: !showFab, child: _addButtonWidget(context)),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Purchase and Financial Details',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_close_dialog.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                App.appSpacer.vHxs,
                 _purchaseDateWidget(context),
                  App.appSpacer.vHs,
                _purchasePriceWidget,
                App.appSpacer.vHs,
                _vendorNameWidget,
                App.appSpacer.vHs,
                _vendorContactNumberWidget,
                App.appSpacer.vHs,
                _vendorEmailWidget,
                App.appSpacer.vHs,
                _invoiceNumberWidget,
                App.appSpacer.vHs,
                _warrantyDetailsWidget,
                App.appSpacer.vHs,
                App.appSpacer.vHxxs,
                App.appSpacer.vHxs,
                App.appSpacer.vHxs,
                App.appSpacer.vHs,
                App.appSpacer.vHs,
                App.appSpacer.vHxs,
                App.appSpacer.vHxs,
                App.appSpacer.vHs,
                App.appSpacer.vHs,
                App.appSpacer.vHxs,
                App.appSpacer.vHxs,
                App.appSpacer.vHs,
                App.appSpacer.vHs,
              ],
            ),
          ),
        ),
      ),
    );
  }







  Widget _purchaseDateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Purchase Date',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              readOnly: true,
              onTab: () async {
                await _selectDate(context);
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
              hint: 'Purchase Date',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }


     Widget get _purchasePriceWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Purchase Price',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Purchase Price',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

    Widget get _vendorNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Vendor Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Vendor Name',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

     Widget get _vendorContactNumberWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Vendor Contact Number',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Vendor Contact Number',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

      Widget get _vendorEmailWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Vendor Email',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Vendor Email',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

    Widget get _invoiceNumberWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Invoice Number',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Invoice Number',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

     Widget get _warrantyDetailsWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Warranty Details',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Warranty Details',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      quantityViewModel.expirationController.value.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }




  Widget _addButtonWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async =>
            {Utils.isCheck = true, if (_formKey.currentState!.validate()) {
              quantityViewModel.addQuantiytToList(context)
            }},
        text: 'Submit',
      ),
    );
  }
}
