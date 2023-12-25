import 'package:sscconnect/components/form-label.dart';

import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CFormInputRadioBtn extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final List<String> items;
  final String defaultValue;

  const CFormInputRadioBtn({
    Key? key,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.onChange,
    required this.items,
    required this.defaultValue,
  }) : super(key: key);

  @override
  State<CFormInputRadioBtn> createState() => _CFormInputRadioBtnState();
}

class _CFormInputRadioBtnState extends State<CFormInputRadioBtn> {
  String value = "";

  @override
  void initState() {
    super.initState();

    value = widget.defaultValue;
  }

  Widget radioBtn(String item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = item;
        });

        if (widget.onChange != null) {
          widget.onChange!(item);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
          right: 7.5,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              width: adaptiveWidthSize(context, 27.5),
              height: adaptiveWidthSize(context, 27.5),
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: item == value ? Colors.blue : Colors.grey,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                margin: EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  color: item == value ? Colors.blue : null,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Text(
              item,
              style: TextStyle(
                fontSize: adaptiveWidthSize(context, 27.5),
                color: Color(formInputColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) FormLabel(label: widget.label),
        Container(
          margin: EdgeInsets.symmetric(vertical: 2.5),
          child: Wrap(
            children: [
              ...widget.items.map((el) => radioBtn(el)).toList(),
            ],
          ),
        ),
        if (widget.invalidMessage != null || widget.invalidMessages != null)
          Container(
            margin: EdgeInsets.only(top: 2.5, bottom: 5),
            child: Text(
              widget.invalidMessage ??
                  (widget.invalidMessages!.isNotEmpty
                      ? ""
                      : widget.invalidMessages![0]),
              style: TextStyle(
                fontSize: adaptiveWidthSize(context, 22.5),
                color: Colors.red[700],
              ),
            ),
          ),
      ],
    );
  }
}
