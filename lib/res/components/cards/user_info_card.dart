import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../view_models/services/app_services.dart';
import '../../colors/app_color.dart';

class UserInfoCardView extends StatelessWidget {
  const UserInfoCardView({super.key,
    required this.cardWidth,
    required this.cardHeight,
    required this.isCardEnable,
  });

  final double cardWidth;
  final double cardHeight;
  final bool isCardEnable;

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
          color: isCardEnable ? kAppWhite : kBinCardBackground,
          child: Padding(
            padding: App.appSpacer.edgeInsets.symmetric(x: 's',y: 's'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _profileImageView,
                    App.appSpacer.vWxs,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'John Bush',
                          fontSize: 16.0,
                          fontColor: kAppBlack,
                          fontWeight: FontWeight.bold
                        ),
                        CustomTextField(
                          textAlign: TextAlign.left,
                          text: isCardEnable ? 'Description' : 'Admin',
                          fontSize: 12.0,
                          fontColor: kAppGreyB,
                          fontWeight: FontWeight.w500
                        )
                      ],
                    ),
                    Spacer(),
                    trailingWidget,
                  ],
                ),
                App.appSpacer.vHxs,
                Divider(),
                App.appSpacer.vHxs,
                _statusWidget,
                App.appSpacer.vHxs,
                _phoneNumberWidget,
                App.appSpacer.vHxs,
                _emailWidget,
                App.appSpacer.vHxs,

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _profileImageView{
    return AppCachedImage.profilePicture(
      url: '',
    );
  }

  Widget get trailingWidget{
    return Row(
      children: [
        SizedBox(
          height: App.appQuery.responsiveWidth(6),
          width: App.appQuery.responsiveWidth(6),
          child: const CircleAvatar(
            backgroundColor: kAppGreen,
            child: Text('M',style: TextStyle(color: Colors.white),),
          ),
        ),
        App.appSpacer.vWxs,
        if(isCardEnable)...[
          SizedBox(
            width: App.appQuery.responsiveWidth(8),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {

              },
              icon: SVGAssetImage(
                height: App.appQuery.responsiveWidth(6),
                width: App.appQuery.responsiveWidth(6),
                url: 'assets/images/default/ic_delete_icon.svg'
              ),
            ),
          ),
          // App.appSpacer.vWxs,
          SizedBox(
            width: App.appQuery.responsiveWidth(8),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {

              },
              icon: SVGAssetImage(
                height: App.appQuery.responsiveWidth(6),
                width: App.appQuery.responsiveWidth(6),
                url: 'assets/images/default/ic_edit_icon.svg',
              )
            ),
          ),
        ],
      ],
    );
  }

  Widget get _statusWidget{
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomTextField(
          textAlign: TextAlign.left,
          text: 'Status',
          fontSize: 15.0,
          fontColor: kAppGreyB,
          fontWeight: FontWeight.w400
        ),
        App.appSpacer.vWxs,
        Container(
          padding: App.appSpacer.edgeInsets.symmetric(x: 'sm',y: 'xxs'),
          decoration: BoxDecoration(
            color: kAppGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              style: BorderStyle.solid,
              color: kAppGreen.withOpacity(0.5)
            )
          ),
          child: const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Status',
              fontSize: 15.0,
              fontColor: kAppGreen,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }

  Widget get _phoneNumberWidget{
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Phone Number',
            fontSize: 15.0,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400
        ),
        App.appSpacer.vWxs,
        const Expanded(
          child: CustomTextField(
              textAlign: TextAlign.right,
              text: '(684) 555-0102',
              fontSize: 15.0,
              fontColor: kAppBlack,
              fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }

  Widget get _emailWidget{
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Email Address',
            fontSize: 15.0,
            fontColor: kAppGreyB,
            fontWeight: FontWeight.w400
        ),
        App.appSpacer.vWxs,
        const Expanded(
          child: CustomTextField(
            textAlign: TextAlign.right,
            text: 'nevaeh.simmons@example.com',
            fontSize: 15.0,
            fontColor: kAppBlack,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}
