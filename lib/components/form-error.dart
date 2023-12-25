import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  final String? errorMessage;
  final double fontSize;

  const FormError({
    this.errorMessage,
    this.fontSize = 22.5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage ?? "",
      style: TextStyle(
        fontSize: adaptiveWidthSize(context, fontSize),
        color: Colors.red[700],
      ),
    );
  }
}
