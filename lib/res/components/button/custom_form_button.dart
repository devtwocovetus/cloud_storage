import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../colors/app_color.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  final double? horizontalPadding;
  final bool isOutlined;
  final bool isLoading;
  final bool isEnable;
  const CustomFormButton(
      {super.key,
        required this.innerText,
        required this.onPressed,
        this.isOutlined = false,
        this.isLoading = false,
        this.isEnable = true,
        this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: size.width * 0.82,
          minWidth: size.width * 0.82,
          minHeight: horizontalPadding ?? 55),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          enableFeedback: isEnable,
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(
                color: isOutlined ? kAppPrimary : Colors.transparent),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          )),
          backgroundColor: !isEnable
              ? WidgetStateProperty.all(kAppPrimary.withOpacity(.5))
              : WidgetStateProperty.all(
              isOutlined ? Colors.white : kAppPrimary),
          overlayColor: WidgetStateProperty.resolveWith(
                (states) {
              return states.contains(WidgetState.pressed)
                  ? Colors.white30
                  : null;
            },
          ),
        ),
        child: isLoading
            ? LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.white, size: 40)
            : Text(
          innerText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            // fontFamily: '',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isOutlined ? kAppPrimary : Colors.white),
        ),
      ),
    );
  }
}
