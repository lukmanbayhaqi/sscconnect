import 'package:sscconnect/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:sscconnect/components/form-label.dart';

import 'package:flutter/material.dart';

class CFormInputMoney extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final dynamic defaultValue;
  final double? borderRadius;

  const CFormInputMoney({
    Key? key,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.defaultValue = "",
    this.onChange,
    this.borderRadius,
  }) : super(key: key);

  @override
  CFormInputMoneyState createState() => CFormInputMoneyState();
}

class CFormInputMoneyState extends State<CFormInputMoney> {
  final controller = TextEditingController();
  static const _locale = 'id';

  String formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(
        int.parse(s),
      );

  @override
  void initState() {
    super.initState();

    var ad = widget.defaultValue.toString().replaceAll('.', '');

    if (widget.onChange != null) {
      widget.onChange!(ad);
    }

    ad = formatNumber(ad);
    controller.value = TextEditingValue(
      text: ad,
      selection: TextSelection.collapsed(offset: ad.length),
    );

    controller.text = ad;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: adaptiveWidthSize(context, 25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) FormLabel(label: widget.label),
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 5),
            ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius != null
                      ? widget.borderRadius!
                      : formBorderRadius,
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor14,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius != null
                      ? widget.borderRadius!
                      : formBorderRadius,
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor14,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius != null
                      ? widget.borderRadius!
                      : formBorderRadius,
                ),
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
              contentPadding: EdgeInsets.all(
                adaptiveWidthSize(context, 20),
              ),
              errorText: widget.invalidMessage ??
                  (widget.invalidMessages == null
                      ? null
                      : widget.invalidMessages![0]),
              errorStyle: TextStyle(
                fontSize: adaptiveWidthSize(context, 22.5),
              ),
            ),
            onChanged: (v) {
              String ad = v.replaceAll('.', '');

              if (ad == "") {
                ad = "0";
              }

              if (widget.onChange != null) {
                widget.onChange!(ad);
              }

              if (v.isNotEmpty) {
                ad = formatNumber(ad);
              }

              controller.value = TextEditingValue(
                text: ad,
                selection: TextSelection.collapsed(offset: ad.length),
              );
            },
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
