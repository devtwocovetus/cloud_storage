import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../colors/app_color.dart';

class SVGAssetImage extends StatelessWidget {
  const SVGAssetImage(
      {super.key,
        this.borderRadius,
        required this.url,
        this.fit,
        this.width,
        this.height,
        this.color,
        this.alignment,
        this.roundShape = false});

  factory SVGAssetImage.profilePicture({
    double? width,
    double? height,
  }) {
    return SVGAssetImage(
      url: 'assets/images/default/no_user_picture.png',
      width: width,
      height: height,
      fit: BoxFit.cover,
      roundShape: true,
      color: kAppBlack,
    );
  }

  final BorderRadius? borderRadius;
  final String? url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final Alignment? alignment;
  final bool roundShape;

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Container();
    }

    final Widget imageView = SvgPicture.asset(
      url!,
      semanticsLabel: 'Acme Logo',
      width: width,
      height: height,
    );

    if (roundShape) {
      return ClipOval(
        child: imageView,
      );
    } else {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: imageView,
      );
    }
  }
}
