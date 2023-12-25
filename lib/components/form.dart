import 'package:sscconnect/components/button.dart';
import 'package:flutter/material.dart';

class CForm extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onSubmit;
  final bool disabledSubmit;
  final List<Widget> children;
  final String submitLabel;
  const CForm({
    Key? key,
    this.padding,
    this.onSubmit,
    required this.children,
    this.disabledSubmit = false,
    this.submitLabel = "Submit",
  }) : super(key: key);

  Widget get submitButton => Container(
        padding: padding == null
            ? null
            : EdgeInsets.only(
                left: padding!.horizontal / 2,
                right: padding!.horizontal / 2,
                bottom: padding!.vertical / 2,
                top: padding!.vertical / 4,
              ),
        child: CButton(
          submitLabel,
          onPressed: onSubmit,
          disabled: disabledSubmit,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        submitButton,
      ],
    );
  }
}
