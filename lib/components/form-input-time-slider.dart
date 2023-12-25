import 'package:sscconnect/components/form-label.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sscconnect/utils/utils.dart';

class CFormInputTimeSlider extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final dynamic defaultValue;
  final DateTime? maxDate;
  final DateTime? minDate;
  final bool disabled;
  final bool use24hFormat;

  const CFormInputTimeSlider({
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.onChange,
    this.defaultValue,
    this.maxDate,
    this.minDate,
    this.disabled = false,
    this.use24hFormat = true,
    super.key,
  });

  @override
  CFormInputTimeSliderState createState() => CFormInputTimeSliderState();
}

class CFormInputTimeSliderState extends State<CFormInputTimeSlider> {
  String value = "";
  FocusNode fnNode = FocusNode();

  @override
  void initState() {
    setState(() {
      value = widget.defaultValue ?? "";
    });

    super.initState();
  }

  void handleTap() async {
    context.popupTimeSlider(
      context,
      fnNode: fnNode,
      defaultValue: value,
      minDate: widget.minDate,
      maxDate: widget.maxDate,
      use24hFormat: widget.use24hFormat,
      onChange: (DateTime v) {
        DateTime val = DateTime(v.year, v.month, v.day, v.hour, v.minute, 0);

        if (widget.onChange != null) {
          widget.onChange!(val.toString());
        }

        setState(() {
          value = val
              .toString()
              .toDateTime(format: "yyyy-MM-dd HH:mm:ss")
              .toIso8601String();
        });
      },
    );
  }

  String? getText() {
    if (value == "") {
      return null;
    }

    if (!widget.use24hFormat) {
      return DateTime.parse(value).formatDate(format: "hh:mm a");
    }

    return DateTime.parse(value).toFormattedTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: formMarginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormLabel(label: widget.label),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          TextField(
            enabled: !widget.disabled,
            focusNode: fnNode,
            controller: TextEditingController(
              text: getText(),
            ),
            onTap: handleTap,
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
                padding: EdgeInsets.all(formInputPadding),
                child: Icon(
                  Feather.clock,
                  color: Color(formIconColor),
                  size: formIconSize,
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                minHeight: formInputPadding,
              ),
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
