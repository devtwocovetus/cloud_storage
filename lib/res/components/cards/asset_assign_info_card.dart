import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user/userlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../view_models/services/app_services.dart';
import '../../colors/app_color.dart';

class AssetAssignInfoCardView extends StatelessWidget {
  AssetAssignInfoCardView({super.key,
    required this.cardWidth,
    required this.cardHeight,
  });

  final double cardWidth;
  final double cardHeight;

  final UserlistViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: Card(
          margin: App.appSpacer.edgeInsets.symmetric(x: 'xxs',y: 'xs'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
                style: BorderStyle.solid,
                color: kCardBorder
            ),
          ),
          color: kAppWhite,
          child: Padding(
            padding: App.appSpacer.edgeInsets.symmetric(x: 's',y: 'xs'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString('My Name'),
                        fontSize: 16.0,
                        fontColor: kAppBlack,
                        fontWeight: FontWeight.w600
                    ),
                    const Spacer(),
                    SizedBox(
                      width: App.appQuery.responsiveWidth(8),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {

                          },
                          icon: SVGAssetImage(
                            height: App.appQuery.responsiveWidth(6),
                            width: App.appQuery.responsiveWidth(6),
                            url: 'assets/images/default/ic_info.svg',
                          )
                      ),
                    ),
                  ],
                ),
                App.appSpacer.vHxxxs,
                const Divider(height: 4,thickness: 1,),
                App.appSpacer.vHxs,
                _headingWidget,
                App.appSpacer.vHxs,
                _infoWidget,
                App.appSpacer.vHxs,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _headingWidget{
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          flex: 3,
          child: CustomTextField(
              textAlign: TextAlign.left,
              text: 'From',
              fontSize: 15.0,
              fontColor: kAppGreyB,
              fontWeight: FontWeight.w400
          ),
        ),
        Expanded(
          flex: 1,
          child: App.appSpacer.vWxs),
        const Expanded(
          flex: 3,
          child: CustomTextField(
              textAlign: TextAlign.left,
              text: 'To',
              fontSize: 15.0,
              fontColor: kAppGreyB,
              fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }

  Widget get _infoWidget{
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Central Warehouse',
                  fontSize: 15.0,
                  fontColor: kAppBlack,
                  fontWeight: FontWeight.w500
              ),
              App.appSpacer.vHxs,
              const CustomTextField(
                  textAlign: TextAlign.left,
                  text: '06/14/2024',
                  fontSize: 15.0,
                  fontColor: kAppGreyB,
                  fontWeight: FontWeight.w500
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SVGAssetImage(
            height: App.appQuery.responsiveWidth(6),
            width: App.appQuery.responsiveWidth(6),
            url: 'assets/images/default/ic_forward_blue_arrow.svg',
          )
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextField(
                  textAlign: TextAlign.left,
                  text: 'Central Warehouse',
                  fontSize: 15.0,
                  fontColor: kAppBlack,
                  fontWeight: FontWeight.w500
              ),
              App.appSpacer.vHxs,
              const CustomTextField(
                  textAlign: TextAlign.left,
                  text: '06/14/2024',
                  fontSize: 15.0,
                  fontColor: kAppGreyB,
                  fontWeight: FontWeight.w500
              ),
            ],
          ),
        ),
      ],
    );
  }
}
