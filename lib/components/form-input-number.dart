import 'package:sscconnect/components/form-label.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CFormInputNumber extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final dynamic defaultValue;

  const CFormInputNumber({
    Key? key,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.defaultValue = "",
    this.onChange,
  }) : super(key: key);

  @override
  CFormInputNumberState createState() => CFormInputNumberState();
}

class CFormInputNumberState extends State<CFormInputNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: formMarginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormLabel(label: widget.label),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          TextField(
            controller: TextEditingController(text: widget.defaultValue),
            keyboardType: TextInputType.number,
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
              fillColor: Colors.white,
              isDense: true,
              contentPadding: EdgeInsets.all(formInputPadding),
              errorText: widget.invalidMessage ??
                  (widget.invalidMessages == null
                      ? null
                      : widget.invalidMessages![0]),
              errorStyle: TextStyle(
                fontSize: adaptiveWidthSize(context, 22.5),
              ),
            ),
            onChanged: widget.onChange,
            style: TextStyle(
              fontSize: formInputSize,
              color: Color(formInputColor),
            ),
          ),
        ],
      ),
    );
  }
}
