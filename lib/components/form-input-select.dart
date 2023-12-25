import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/components/form-label.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sscconnect/utils/utils.dart';

class CFormInputSelect extends StatefulWidget {
  final bool vIf;
  final String? label;
  final String? description;
  final String? invalidMessage;
  final String? text;
  final String? placeholder;
  final bool isLoading;
  final bool searchable;
  final bool removeable;
  final Function? onRemove;
  final List<String>? invalidMessages;
  final WidgetBuilder builder;

  const CFormInputSelect({
    Key? key,
    this.vIf = true,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.text,
    this.placeholder,
    this.isLoading = false,
    this.searchable = false,
    this.removeable = false,
    this.onRemove,
    required this.builder,
  }) : super(key: key);

  @override
  CFormInputSelectState createState() => CFormInputSelectState();
}

class CFormInputSelectState extends State<CFormInputSelect> {
  String fileName = "";
  FocusNode fnNode = FocusNode();

  void onTap() async {
    if (widget.isLoading) {
      return;
    }

    fnNode.unfocus();

    if (widget.removeable) {
      if (widget.text == null || widget.text == "") {
        navigate();
      } else {
        if (widget.onRemove != null) {
          widget.onRemove!();
        }
      }
    } else {
      navigate();
    }
  }

  void navigate() {
    context.navigate(widget.builder);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.vIf) {
      return SizedBox();
    }

    return Container(
      margin: EdgeInsets.only(bottom: formMarginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) FormLabel(label: widget.label),
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(
                bottom: adaptiveWidthSize(context, 10),
              ),
            ),
          TextField(
            controller: TextEditingController()..text = widget.text ?? "",
            focusNode: fnNode,
            onTap: onTap,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  formBorderRadius,
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor14,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  formBorderRadius,
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: textColor14,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  formBorderRadius,
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
              contentPadding: EdgeInsets.all(formInputPadding),
              suffixIcon: Padding(
                padding: EdgeInsets.all(formInputPadding),
                child: widget.isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      )
                    : (widget.removeable &&
                            widget.text != null &&
                            widget.text != "")
                        ? Icon(
                            Icons.close,
                            color: Color(formIconColor),
                            size: adaptiveWidthSize(context, 35),
                          )
                        : Icon(
                            Feather.chevron_down,
                            color: Color(formIconColor),
                            size: adaptiveWidthSize(context, 35),
                          ),
              ),
              suffixIconConstraints: BoxConstraints(
                minHeight: formInputPadding,
              ),
              helperText: widget.description,
              errorText: widget.invalidMessage ??
                  (widget.invalidMessages == null
                      ? null
                      : widget.invalidMessages![0]),
              errorStyle: TextStyle(
                fontSize: adaptiveWidthSize(context, 22.5),
              ),
              hintText: widget.placeholder,
            ),
            // onChanged: widget.onChange,
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
