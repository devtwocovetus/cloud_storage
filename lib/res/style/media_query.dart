import 'package:flutter/material.dart';

class AppQuery {
  factory AppQuery() => _instance;

  AppQuery._();

  ///Singleton factory
  static final AppQuery _instance = AppQuery._();

  final double kSmallScreenWidth = 350;
  final double kMedScreenHeight = 700;

  late double width;
  late double height;
  late EdgeInsets mediaQueryPadding;

  MediaQueryData? mediaQueryData;

  void init(BuildContext context) {
    if (mediaQueryData == null) {
      mediaQueryData = MediaQuery.of(context);
      mediaQueryPadding = mediaQueryData!.padding;
      width = mediaQueryData!.size.width;
      height = mediaQueryData!.size.height;
    }
  }

  /// current device is iPhone 5 or smaller
  bool get isSmallDeviceByWidth => width < kSmallScreenWidth;

  /// current device is iPhone X or larger
  bool get isLargeDeviceByHeight => height > kMedScreenHeight;

  double get screenWidthFull => width;
  double get screenWidthHalf => width / 2;
  double get screenWidthThird => width / 3;
  double get screenWidthFourth => width / 4;
  double responsiveWidth(double percentage) => width * (percentage / 100);

  double get screenHeightFull => height;
  double get screenHeightHalf => height / 2;
  double get screenHeightThird => height / 3;
  double get screenHeightFourth => height / 4;
  double responsiveHeight(double percentage) => height * (percentage / 100);
}
