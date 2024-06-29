import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';

import '../../variables/var_string.dart';
import '../image_view/svg_asset_image.dart';

class BasicDivider extends StatelessWidget {
  const BasicDivider({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: App.appSpacer.edgeInsets.y.sm,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SVGAssetImage(
            width: width,
            url: horizontalLine,
          ),
          const Align(
            alignment: Alignment.center,
            child: SVGAssetImage(
              fit: BoxFit.fill,
              url: crossImage,
            ),
          )
        ],
      ),
    );
  }
}
