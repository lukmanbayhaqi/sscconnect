import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CFormInputCheckBox extends StatefulWidget {
  final String? label;
  final Widget? labelWidget;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<bool>? onChange;
  final dynamic defaultValue;
  final String labelPosition;
  final MainAxisAlignment mainAxisAlignment;
  final bool disabled;

  const CFormInputCheckBox({
    this.label,
    this.labelWidget,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.onChange,
    this.defaultValue,
    this.labelPosition = "right",
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.disabled = false,
    super.key,
  });

  @override
  CFormInputCheckBoxState createState() => CFormInputCheckBoxState();
}

class CFormInputCheckBoxState extends State<CFormInputCheckBox> {
  bool value = false;

  @override
  void initState() {
    super.initState();

    if (widget.defaultValue != null) {
      setState(() {
        value = widget.defaultValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disabled
          ? null
          : () {
              bool val = !value;

              setState(() {
                value = val;
              });

              if (widget.onChange != null) widget.onChange!(val);
            },
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          if (widget.labelPosition == "left")
            if (widget.labelWidget == null)
              Flexible(
                child: Text(
                  widget.label ?? "",
                  style: TextStyle(
                    fontSize: adaptiveWidthSize(context, 27.5),
                  ),
                ),
              )
            else
              widget.labelWidget!,
          Transform.scale(
            scale: adaptiveWidthSize(context, 2),
            child: Checkbox(
              activeColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  adaptiveWidthSize(context, 5),
                ),
              ),
              value: value,
              onChanged: widget.disabled
                  ? null
                  : (bool? val) {
                      if (val == null) return;

                      setState(() {
                        value = val;
                      });

                      if (widget.onChange != null) widget.onChange!(val);
                    },
            ),
          ),
          if (widget.labelPosition == "right")
            if (widget.labelWidget == null)
              Flexible(
                child: Text(
                  widget.label ?? "",
                  style: TextStyle(
                    fontSize: adaptiveWidthSize(context, 27.5),
                  ),
                ),
              )
            else
              widget.labelWidget!,
        ],
      ),
    );
  }
}
