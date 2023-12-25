import 'package:sscconnect/components/components.dart';

import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

enum CButtonSize {
  small,
  medium,
  large,
}

class CButton extends StatelessWidget {
  final String label;
  final GestureTapCallback? onPressed;
  final Color? color;
  final Color? disabledColor;
  final Color textColor;
  final bool disabled;
  final CButtonSize size;
  final bool isLoading;
  final Color? loadingColor;

  const CButton(
    this.label, {
    @required this.onPressed,
    this.color = primaryColor,
    this.disabledColor = primaryDisabledColor,
    this.textColor = Colors.white,
    this.size = CButtonSize.medium,
    this.disabled = false,
    this.isLoading = false,
    this.loadingColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double paddingSize = 17.5;
    double loadingSize = 50;
    double textSize = 30;

    if (size == CButtonSize.small) {
      paddingSize = 15;
      loadingSize = 40;
      textSize = 27.5;
    }
    if (size == CButtonSize.medium) {
      paddingSize = 17.5;
      loadingSize = 45;
      textSize = 30;
    }
    if (size == CButtonSize.large) {
      paddingSize = 17.5;
      loadingSize = 52.5;
      textSize = 35;
    }

    return GestureDetector(
      onTap: disabled || isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: adaptiveWidthSize(context, paddingSize),
        ),
        decoration: BoxDecoration(
          color: disabled || isLoading ? disabledColor : color,
          borderRadius: BorderRadius.circular(
            adaptiveWidthSize(context, 12.5),
          ),
        ),
        child: Stack(
          children: [
            if (!isLoading)
              Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: adaptiveWidthSize(context, textSize),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              Loading(
                type: CLoadingType.threeBounce,
                size: CLoadingSize.custom,
                customSize: loadingSize,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
