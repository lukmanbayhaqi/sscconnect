import 'package:sscconnect/components/form-label.dart';
import 'package:sscconnect/utils/utils.dart';

import 'package:flutter/material.dart';

class CFormInputToggle extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged? onChange;

  const CFormInputToggle(
      {Key? key,
      this.label,
      this.description,
      this.invalidMessage,
      this.invalidMessages,
      this.onChange})
      : super(key: key);

  @override
  CFormInputToggleState createState() => CFormInputToggleState();
}

class CFormInputToggleState extends State<CFormInputToggle> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: formMarginBottom),
        child: Row(
          children: [
            Switch(
                value: value,
                onChanged: (val) {
                  setState(() {
                    // if(val != null)
                    value = val;
                  });
                  if (widget.onChange != null) widget.onChange!(val);
                }),
            FormLabel(label: widget.label),
          ],
        ));
  }
}
