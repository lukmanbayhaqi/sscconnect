import 'package:sscconnect/components/form-label.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CFormInputDateSlider extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final dynamic defaultValue;
  final DateTime? maxDate;
  final DateTime? minDate;
  final bool disabled;
  final double? borderRadius;

  const CFormInputDateSlider({
    Key? key,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.onChange,
    this.defaultValue,
    this.maxDate,
    this.minDate,
    this.disabled = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  CFormInputDateSliderState createState() => CFormInputDateSliderState();
}

class CFormInputDateSliderState extends State<CFormInputDateSlider> {
  String value = "";
  FocusNode fnNode = FocusNode();

  @override
  void initState() {
    super.initState();

    value = widget.defaultValue ?? "";
  }

  void handleTap() async {
    fnNode.unfocus();
    DateTime? selectedDate;
    DateTime? max = widget.maxDate;
    DateTime? min = widget.minDate;
    DateTime initVal = DateTime.now();

    if (max != null) {
      max = max.copyWith(
        hour: 23,
        minute: 59,
        second: 59,
        millisecond: 59,
        microsecond: 59,
      );
    }

    if (min != null) {
      min = min.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
      initVal = min.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

      if (widget.defaultValue != null) {
        if (DateFormat('yyyy-MM-ddThh:mm:ss')
            .parse(widget.defaultValue!)
            .isBefore(min)) {
          initVal =
              DateFormat('yyyy-MM-ddThh:mm:ss').parse(widget.defaultValue!);
        } else {
          initVal =
              DateFormat('yyyy-MM-ddThh:mm:ss').parse(widget.defaultValue!);
        }
      }
    }

    value = initVal
        .toString()
        .toDateTime(format: "yyyy-MM-dd hh:mm:ss")
        .toIso8601String();

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            maximumDate: max,
            minimumDate: min,
            initialDateTime: value != ''
                ? DateFormat('yyyy-MM-ddThh:mm:ss').parse(value)
                : null,
            onDateTimeChanged: (DateTime v) {
              selectedDate = v;
            },
          ),
        ),
      ),
    );

    selectedDate ??= (value != "")
        ? DateFormat('yyyy-MM-ddThh:mm:ss').parse(value)
        : DateTime.now();

    if (widget.onChange != null) {
      widget.onChange!(
        selectedDate
            .toString()
            .toDateTime(format: "yyyy-MM-dd hh:mm:ss")
            .toIso8601String(),
      );
    }

    setState(() {
      if (selectedDate != null) {
        value = selectedDate!
            .toString()
            .toDateTime(format: "yyyy-MM-dd hh:mm:ss")
            .toIso8601String();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: formMarginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Row(
              children: [
                FormLabel(label: widget.label),
                // Container(
                //   margin: EdgeInsets.only(left: adaptiveWidthSize(context, 5),),
                //   child: Text(widget.description ??),
                // ),
              ],
            ),
          if (widget.label != null)
            Padding(padding: EdgeInsets.only(bottom: 5)),
          TextField(
            enabled: !widget.disabled,
            focusNode: fnNode,
            controller: TextEditingController(
              text:
                  value != "" ? DateTime.parse(value).toFormattedDate() : null,
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
                widget.borderRadius != null
                    ? widget.borderRadius!
                    : formBorderRadius,
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.all(formInputPadding),
                child: Icon(
                  Feather.calendar,
                  color: Color(formIconColor),
                  size: adaptiveWidthSize(context, 35),
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
              fontSize: adaptiveWidthSize(context, 27.5),
              color: Color(formInputColor),
            ),
          ),
        ],
      ),
    );
  }
}
