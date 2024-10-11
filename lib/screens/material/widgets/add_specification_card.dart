import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../res/components/image_view/svg_asset_image.dart';
import '../../../res/variables/var_string.dart';
import '../../../view_models/controller/material/material_view_model.dart';
import '../../../view_models/services/app_services.dart';

class AddSpecificationCard extends StatelessWidget {
  AddSpecificationCard({
    super.key,
    required this.width,
  });

  final double width;
  final MaterialViewModel controller = Get.put(MaterialViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        decoration: BoxDecoration(
            color: kBinCardBackground, borderRadius: BorderRadius.circular(15)),
        child: /*Obx(() =>*/
            Column(
          children: [
            SizedBox(height: 8.h,),
            _pageHeadingWidget,
            SizedBox(height: 16.h,),
            Row(
              children: [
                Expanded(child: _unitLengthWidget),
                Expanded(child: _unitWidthWidget)
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              children: [
                Expanded(child: _unitHeightWidget),
                Expanded(child: _unitDiameterWidget)
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              children: [
                Expanded(child: _unitWeightWidget),
                Expanded(child: _unitColorWidget)
              ],
            ),
            SizedBox(height: 12.h,),
          ],
        )
        // ),
        );
  }

  Widget get _pageHeadingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SVGAssetImage(
                width: width * 0.25,
                url: horizontalLine,
              ),
              CustomTextField(
                  textAlign: TextAlign.center,
                  text: 'Specification',
                  fontSize: 16.0.sp,
                  fontColor: kAppBlackB,
                  fontWeight: FontWeight.w500),
              SVGAssetImage(
                width: width * 0.25,
                url: horizontalLine,
              ),
            ],
          ),
          CustomTextField(
              textAlign: TextAlign.center,
              text: 'Add Imperial Unit',
              fontSize: 10.0.sp,
              fontColor: kAppGreyB,
              fontWeight: FontWeight.w500),
        ],
      ),
    );
  }

  Widget get _unitLengthWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: 'Length',
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Length',
              controller: controller.unitLengthC.value,
              focusNode: controller.unitLengthCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _unitWidthWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: 'Width',
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Width',
              controller: controller.unitWidthC.value,
              focusNode: controller.unitWidthCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _unitHeightWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: 'Height',
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Height',
              controller: controller.unitHeightC.value,
              focusNode: controller.unitHeightCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _unitDiameterWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: 'Diameter',
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Diameter',
              controller: controller.unitDiameterC.value,
              focusNode: controller.unitDiameterCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _unitWeightWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: 'Weight',
              fontSize: 14.0.h,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Weight',
              controller: controller.unitWeightC.value,
              focusNode: controller.unitWeightCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _unitColorWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              textAlign: TextAlign.left,
              text: 'Color',
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Color',
              controller: controller.unitColorC.value,
              focusNode: controller.unitColorCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }
}
