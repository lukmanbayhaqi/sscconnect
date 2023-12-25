import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String? label;
  final double? fontSize;
  final bool isMandatory;

  const FormLabel({
    this.label,
    this.fontSize,
    this.isMandatory = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return !isMandatory
        ? Text(
            label.toString(),
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, fontSize ?? 27.5),
              fontWeight: FontWeight.w600,
              color: Color(formLabelColor),
            ),
          )
        : RichText(
            text: TextSpan(
              text: label.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: adaptiveWidthSize(context, fontSize ?? 27.5),
                color: Color(formLabelColor),
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          );
  }
}
