import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class FormNumber extends StatefulWidget {
  final String? label;
  final int? defaultValue;
  final int? min;
  final int? max;
  final ValueChanged<int>? onChange;
  final MainAxisAlignment? mainAxisAlignment;

  const FormNumber({
    this.label,
    this.defaultValue,
    this.min,
    this.max,
    this.onChange,
    this.mainAxisAlignment,
    super.key,
  });

  @override
  State<FormNumber> createState() => _FormNumberState();
}

class _FormNumberState extends State<FormNumber> {
  int value = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      value = widget.defaultValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: [
        if (widget.label != null) FormLabel(label: widget.label),
        Row(
          children: [
            CButtonIcon(
              Icons.remove,
              onPressed: () {
                setState(() {
                  value--;
                });
              },
              disabled: widget.min != null ? value <= widget.min! : false,
              size: CButtonIconSize.custom,
              paddingSize: 5,
              iconSize: 40,
            ),
            Container(
              width: adaptiveWidthSize(context, 45),
              margin: EdgeInsets.symmetric(
                horizontal: adaptiveWidthSize(context, 10),
              ),
              child: Text(
                "$value",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: adaptiveWidthSize(context, 30),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CButtonIcon(
              Icons.add,
              onPressed: () {
                setState(() {
                  value++;
                });
              },
              disabled: widget.max != null ? value >= widget.max! : false,
              size: CButtonIconSize.custom,
              paddingSize: 5,
              iconSize: 40,
            ),
          ],
        ),
      ],
    );
  }
}
