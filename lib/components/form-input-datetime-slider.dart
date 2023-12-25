import 'package:sscconnect/components/form-label.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CFormInputDateTimeSlider extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final String? defaultValue;
  final DateTime? maxDate;
  final DateTime? minDate;
  final bool disabled;

  const CFormInputDateTimeSlider({
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
  }) : super(key: key);

  @override
  CFormInputDateTimeSliderState createState() =>
      CFormInputDateTimeSliderState();
}

class CFormInputDateTimeSliderState extends State<CFormInputDateTimeSlider> {
  String value = "";
  FocusNode fnNode = FocusNode();

  @override
  void initState() {
    value = widget.defaultValue ?? "";

    super.initState();
  }

  void handleTap() async {
    fnNode.unfocus();
    final DateTime today = DateTime.now();
    DateTime? selectedDate;
    DateTime? max = widget.maxDate;
    DateTime? min = widget.minDate;
    DateTime initVal = DateTime.now();

    if (max != null) {
      max = DateTime(max.year, max.month, max.day, 23, 59, 0, 0);
    }

    if (min != null) {
      min = DateTime(min.year, min.month, min.day, min.hour, min.minute, 0, 0);
      initVal =
          DateTime(min.year, min.month, min.day, min.hour, min.minute, 0, 0);

      if (widget.defaultValue != null) {
        if (DateFormat('yyyy-MM-ddTHH:mm:ss')
            .parse(widget.defaultValue!)
            .isBefore(min)) {
          initVal =
              DateFormat('yyyy-MM-ddTHH:mm:ss').parse(widget.defaultValue!);
        } else {
          initVal =
              DateFormat('yyyy-MM-ddTHH:mm:ss').parse(widget.defaultValue!);
        }
      }
    }

    value = initVal
        .add(
          Duration(
              minutes: initVal.minute % 30 == 0 ? 0 : 30 - initVal.minute % 30),
        )
        .toString()
        .toDateTime(format: "yyyy-MM-dd HH:mm:ss")
        .toIso8601String();

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            maximumDate: max,
            minimumDate: min,
            use24hFormat: true,
            minuteInterval: 30,
            initialDateTime: value != ''
                ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value)
                : null,
            onDateTimeChanged: (DateTime v) {
              selectedDate = v;
            },
          ),
        ),
      ),
    );

    selectedDate ??= (value != "")
        ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value)
        : today.add(
            Duration(minutes: 30 - today.minute % 30),
          );

    if (widget.onChange != null) {
      widget.onChange!(
        selectedDate
            .toString()
            .toDateTime(format: "yyyy-MM-dd HH:mm:ss")
            .toIso8601String(),
      );
    }

    setState(() {
      if (selectedDate != null) {
        value = selectedDate!
            .toString()
            .toDateTime(format: "yyyy-MM-dd HH:mm:ss")
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
          FormLabel(label: widget.label),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          TextField(
            enabled: !widget.disabled,
            focusNode: fnNode,
            controller: TextEditingController(
              text: value != ""
                  ? DateTime.parse(value).toFormattedDateTime()
                  : null,
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
                  Feather.calendar,
                  color: Color(formIconColor),
                  size: adaptiveWidthSize(context, 35),
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                minHeight: formInputPadding,
              ),
              errorText: widget.disabled
                  ? null
                  : widget.invalidMessage ??
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
