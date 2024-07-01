import 'package:flutter/cupertino.dart';

import '../../colors/app_color.dart';


class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
      {super.key,
      this.borderRadius,
      required this.url,
      this.fit,
      this.width,
      this.height,
      this.color,
      this.alignment,
      this.roundShape = false});

  factory AppAssetImage.profilePicture({
    double? width,
    double? height,
  }) {
    return AppAssetImage(
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

    final Widget imageView = Image.asset(
      url!,
      fit: fit ?? BoxFit.scaleDown,
      width: width,
      height: height,
      color: color,
      alignment: alignment ?? Alignment.center,
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
