import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

enum CButtonIconSize {
  small,
  medium,
  large,
  custom,
}

class CButtonIcon extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Color color;
  final Color iconColor;
  final Color disabledColor;
  final bool disabled;
  final CButtonIconSize size;
  final IconData icon;
  final double paddingSize;
  final double iconSize;

  const CButtonIcon(
    this.icon, {
    @required this.onPressed,
    this.color = primaryColor,
    this.iconColor = Colors.white,
    this.disabledColor = primaryDisabledColor,
    this.size = CButtonIconSize.medium,
    this.disabled = false,
    this.paddingSize = 15,
    this.iconSize = 55,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = paddingSize;
    double sizeIcon = iconSize;

    if (size != CButtonIconSize.custom) {
      if (size == CButtonIconSize.small) {
        padding = 15;
        sizeIcon = 35;
      }
      if (size == CButtonIconSize.large) {
        padding = 25;
        sizeIcon = 75;
      }
    }

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        padding: EdgeInsets.all(
          adaptiveWidthSize(context, padding),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: disabled ? disabledColor : color,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: adaptiveWidthSize(context, sizeIcon),
        ),
      ),
    );
  }
}
