import 'package:cold_storage_flutter/res/components/text_field/range_text_field.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/widgets/bin_creation_form.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/colors/app_color.dart';
import '../../utils/utils.dart';

class CreateWarehouse extends StatelessWidget {
  const CreateWarehouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: App.appSpacer.edgeInsets.y.smm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              App.appSpacer.vHxs,
              _pageHeadingWidget,
              App.appSpacer.vHs,
              _storageNameWidget,
              App.appSpacer.vHs,
              _emailWidget,
              App.appSpacer.vHs,
              _addressWidget,
              App.appSpacer.vHs,
              _phoneWidget,
              App.appSpacer.vHs,
              ///Profile Picture

              App.appSpacer.vHs,
              _capacityWidget,
              App.appSpacer.vHs,
              _temperatureRangeWidget,
              App.appSpacer.vHs,
              _humidityRangeWidget,
              App.appSpacer.vHs,
              BinCreationForm(
                width: App.appQuery.width,
                createdBinCount: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _pageHeadingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: const CustomTextField(
          textAlign: TextAlign.left,
          text: 'Add Cold Storage/Warehouse',
          fontSize: 20.0,
          fontColor: kAppBlack,
          fontWeight: FontWeight.w500
      ),
    );
  }

  Widget get _storageNameWidget{
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Storage Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Storage Name',
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Storage', 'Enter storage name');
                  return '';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _emailWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Email',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Email Address',
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Email', 'Enter email address');
                  return '';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _addressWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Address',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(90),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Address',
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Address', 'Enter address');
                  return '';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _phoneWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Phone',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Phone Number',
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Phone', 'Enter phone number');
                  return '';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.phone
          ),
        ],
      ),
    );
  }

  Widget get _capacityWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Capacity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Storage Capacity',
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Capacity', 'Enter storage capacity');
                  return '';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
        ],
      ),
    );
  }

  Widget get _temperatureRangeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Temperature Range (\u00B0C)',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Max Temp',
                buttonText: 'Max',
                controller: TextEditingController(),
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Temp',
                buttonText: 'Min',
                controller: TextEditingController(),
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _humidityRangeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Humidity Range (%)',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Max Humidity',
                buttonText: 'Max',
                controller: TextEditingController(),
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Humidity',
                buttonText: 'Min',
                controller: TextEditingController(),
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


