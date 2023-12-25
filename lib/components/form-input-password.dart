import 'package:sscconnect/components/form-label.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CFormInputPassword extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged? onChange;

  const CFormInputPassword({
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  CFormInputPasswordState createState() => CFormInputPasswordState();
}

class CFormInputPasswordState extends State<CFormInputPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: adaptiveWidthSize(context, 20),
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
            obscureText: !showPassword,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: (widget.invalidMessage != null ||
                      widget.invalidMessages != null)
                  ? Colors.redAccent.withOpacity(.2)
                  : textColor15,
              isDense: true,
              contentPadding: EdgeInsets.all(formInputPadding),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(formInputPadding),
                  child: Icon(
                    !showPassword ? Feather.eye : Feather.eye_off,
                    color: Color(formIconColor),
                    size: adaptiveWidthSize(context, 35),
                  ),
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
            onChanged: (val) {
              if (widget.onChange != null) widget.onChange!(val);
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
