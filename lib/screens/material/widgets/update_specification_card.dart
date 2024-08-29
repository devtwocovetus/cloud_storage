import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../res/components/image_view/svg_asset_image.dart';
import '../../../res/variables/var_string.dart';
import '../../../view_models/controller/material_in/update/update_material_quantity_view_model.dart';
import '../../../view_models/services/app_services.dart';

class UpdateSpecificationCard extends StatelessWidget {
  UpdateSpecificationCard({
    super.key,
    required this.width,
  });

  final double width;
  final UpdateMaterialQuantityViewModel controller = Get.put(UpdateMaterialQuantityViewModel());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        decoration: BoxDecoration(
            color: kBinCardBackground, borderRadius: BorderRadius.circular(15)),
        child: /*Obx(() =>*/
        Column(
          children: [
            App.appSpacer.vHxs,
            _pageHeadingWidget,
            App.appSpacer.vHsm,
            Row(
              children: [
                Expanded(child: _unitLengthWidget),
                Expanded(child: _unitWidthWidget)
              ],
            ),
            App.appSpacer.vHs,
            Row(
              children: [
                Expanded(child: _unitHeightWidget),
                Expanded(child: _unitDiameterWidget)
              ],
            ),
            App.appSpacer.vHs,
            Row(
              children: [
                Expanded(child: _unitWeightWidget),
                Expanded(child: _unitColorWidget)
              ],
            ),
            App.appSpacer.vHs,
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
              const CustomTextField(
                  textAlign: TextAlign.center,
                  text: 'Specification',
                  fontSize: 16.0,
                  fontColor: kAppBlackB,
                  fontWeight: FontWeight.w500),
              SVGAssetImage(
                width: width * 0.25,
                url: horizontalLine,
              ),
            ],
          ),
          const CustomTextField(
              textAlign: TextAlign.center,
              text: 'Add Imperial Unit',
              fontSize: 10.0,
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Length',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Length',
              controller: controller.unitLengthC,
              focusNode: FocusNode(),
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Width',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Width',
              controller: controller.unitWidthC,
              focusNode: FocusNode(),
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Height',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Height',
              controller: controller.unitHeightC,
              focusNode: FocusNode(),
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Diameter',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Diameter',
              controller: controller.unitDiameterC,
              focusNode: FocusNode(),
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Weight',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Weight',
              controller: controller.unitWeightC,
              focusNode: FocusNode(),
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Color',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Color',
              controller: controller.unitColorC,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }
}
