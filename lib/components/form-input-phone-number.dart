import 'package:sscconnect/components/form-label.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CFormInputPhoneNumber extends StatelessWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final dynamic defaultValue;

  const CFormInputPhoneNumber({
    Key? key,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.defaultValue = "",
    this.onChange,
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
          if (label != null) FormLabel(label: label),
          if (label != null) Padding(padding: EdgeInsets.only(bottom: 5)),
          TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            enableInteractiveSelection: false,
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
              suffixIcon: Container(
                child: Icon(
                  Entypo.mobile,
                  color: Color(formIconColor),
                  size: formIconSize,
                ),
              ),
              errorText: invalidMessage ??
                  (invalidMessages == null ? null : invalidMessages![0]),
              errorStyle: TextStyle(
                fontSize: adaptiveWidthSize(context, 22.5),
              ),
            ),
            onChanged: (v) {
              onChange!(v);
            },
            style: TextStyle(
              fontSize: formInputSize,
              color: Color(formInputColor),
            ),
          )
        ],
      ),
    );
  }
}
