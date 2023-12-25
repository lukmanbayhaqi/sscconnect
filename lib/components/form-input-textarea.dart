import 'package:sscconnect/components/form-label.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CFormInputTextarea extends StatelessWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final FocusNode? focusNode;
  final dynamic defaultValue;

  const CFormInputTextarea({
    Key? key,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.onChange,
    this.focusNode,
    this.defaultValue = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(
      text: defaultValue,
    );

    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return Container(
      margin: EdgeInsets.only(bottom: formMarginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormLabel(label: label),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor14,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor14,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor14,
                  style: BorderStyle.solid,
                ),
              ),
              filled: true,
              // fillColor: textColor15,
              fillColor: Colors.white,
              isDense: true,
              contentPadding: EdgeInsets.all(formInputPadding),
              errorText: invalidMessage ??
                  (invalidMessages == null ? null : invalidMessages![0]),
              errorStyle: TextStyle(
                fontSize: adaptiveWidthSize(context, 22.5),
              ),
            ),
            onChanged: onChange,
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, 27.5),
              color: Color(formInputColor),
            ),
          )
        ],
      ),
    );
  }
}
