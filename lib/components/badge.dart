import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CBadge extends StatelessWidget {
  final String? label;
  final Widget? widgetLabel;
  final Color? borderColor;
  final Color? statusColor;
  final Color? color;
  final Color? bgColor;
  final double fontSize;
  final double padVer;
  final double padHor;
  final double radius;
  final FontWeight? fontWeight;

  const CBadge({
    this.label,
    this.widgetLabel,
    this.borderColor,
    this.statusColor,
    this.color,
    this.bgColor,
    this.fontSize = 20,
    this.padVer = 2.5,
    this.padHor = 15,
    this.radius = 15,
    this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: adaptiveWidthSize(context, padVer),
        horizontal: adaptiveWidthSize(context, padHor),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          adaptiveWidthSize(context, radius),
        ),
        color: bgColor ??
            borderColor?.withAlpha(0x11) ??
            color?.withAlpha(0x11) ??
            Color(0xFF009ef7).withAlpha(0x11),
        border: Border.all(
          color: borderColor ?? color ?? Color(0xFF009ef7),
          width: adaptiveWidthSize(context, 1.5),
        ),
      ),
      child: widgetLabel ??
          Text(
            label ?? "",
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, fontSize),
              color: statusColor ?? color ?? Color(0xFF009ef7),
              fontWeight: fontWeight,
            ),
          ),
    );
  }
}
