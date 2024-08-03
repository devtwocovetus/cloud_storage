// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../../../view_models/services/app_services.dart';
import '../../colors/app_color.dart';
import 'asset_image_view.dart';

class AppCachedImage extends StatefulWidget {
  const AppCachedImage(
      {super.key,
        required this.url,
        this.width,
        this.height,
        this.fit,
        this.color,
        this.blendMode,
        this.errorWidget,
        this.alignment = Alignment.center,
        this.showLoading = true,
        this.roundShape = false,
        this.showErrorImage = true,
        this.borderRadius,
        this.bgColor = kAppTransparent,
        this.onError, this.withShadow, this.borderColor});

  static Widget profilePicture({
    String? url,
    double? width,
    double? height,
    bool withBorder = false,
    Color? borderColor,
  }) {
    final Widget child = AppCachedImage(
      url: url,
      width: width ?? App.appQuery.responsiveWidth(12),
      height: height ?? App.appQuery.responsiveWidth(12),
      fit: BoxFit.cover,
      roundShape: true,
      errorWidget: AppAssetImage(
        url: 'assets/images/default/no_user_picture.png',
        width: width,
        height: height,
        fit: BoxFit.cover,
        roundShape: true,
        // color: kAppBlack,
      ),
    );

    if (withBorder) {
      return Container(
        decoration:  BoxDecoration(
            shape: BoxShape.circle,
            //color: borderColor??kAppPrimaryRed,
            border: Border.all(color:borderColor??kAppTransparent,width: 2.0 )
        ),
        padding: const EdgeInsets.all(0),
        child: child,
      );
    } else {
      return child;
    }
  }

  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? blendMode;
  final Alignment alignment;
  final Widget? errorWidget;
  final bool showLoading;
  final bool roundShape;
  final bool showErrorImage;
  final BorderRadius? borderRadius;
  final Color bgColor;
  final Color? borderColor;
  final Function(dynamic)? onError;
  final bool? withShadow;

  @override
  _AppCachedImageState createState() => _AppCachedImageState();
}

class _AppCachedImageState extends State<AppCachedImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.roundShape) {
      return ClipOval(
        child: _cachedImageView,
      );
    } else {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: _cachedImageView,
      );
    }
  }

  Widget get _cachedImageView {
    if (widget.url == null || widget.url!.isEmpty) {
      return _defaultErrorWidget;
    }

    return CachedNetworkImage(
      imageUrl: widget.url!,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      fit: widget.fit ?? BoxFit.cover,
      colorBlendMode: widget.blendMode,
      alignment: widget.alignment,
      errorWidget: (BuildContext context, String url, dynamic error) {
        if (widget.showErrorImage) {
          return widget.errorWidget ?? _defaultErrorWidget;
        } else {
          return Container();
        }
      },
      placeholder: (BuildContext context, String url) => widget.showLoading
          ? Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: kAppGrey,
        ),
      )
          : Container(),
    );
  }

  Widget get _defaultErrorWidget {
    if (widget.roundShape) {
      return ClipOval(
        child: Container(
          color: widget.bgColor,
          width: widget.width,
          height: widget.height,
          child: widget.errorWidget ?? _errorImage,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: Container(
          color: widget.bgColor,
          width: widget.width,
          height: widget.height,
          child: widget.errorWidget ?? _errorImage,
        ),
      );
    }
  }

  Widget get _errorImage => AppAssetImage(
    url: 'assets/images/default/no_user_png.png',
    width: widget.width,
    height: widget.height,
    fit: widget.fit,
  );
}
