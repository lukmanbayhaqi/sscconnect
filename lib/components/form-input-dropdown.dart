import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:sscconnect/components/form-label.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CFormInputDropdown<T> extends StatefulWidget {
  final bool vIf;
  final String? label;
  final String? description;
  final String? invalidMessage;
  final String? text;
  final bool isLoading;
  final bool searchable;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSearch;
  final AsyncCallback? onOpen;
  final List<Widget> children;

  const CFormInputDropdown({
    Key? key,
    this.vIf = true,
    this.label,
    this.description,
    this.invalidMessage,
    this.invalidMessages,
    this.text,
    this.isLoading = true,
    this.searchable = false,
    this.onChange,
    this.onSearch,
    this.onOpen,
    required this.children,
  }) : super(key: key);

  @override
  CFormInputDropdownState createState() => CFormInputDropdownState();
}

class CFormInputDropdownState extends State<CFormInputDropdown> {
  String fileName = "";
  FocusNode fnNode = FocusNode();

  void onTap() async {
    if (widget.isLoading) {
      return;
    }

    fnNode.unfocus();
    showModal();
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        widget.label.toString(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor1,
        ),
      ),
    );
  }

  Widget searchBox() {
    if (!widget.searchable) {
      return SizedBox();
    }

    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search..",
          hintStyle: TextStyle(
            fontSize: adaptiveWidthSize(context, 27.5),
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onChanged: (v) {
          if (widget.onSearch != null) {
            widget.onSearch!(v);
          }
        },
      ),
    );
  }

  Widget listItems() {
    if (widget.children.isEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 50),
        padding: EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Center(
          child: Text(
            "No Items",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      padding: EdgeInsets.only(top: 15),
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Expanded(
        child: SingleChildScrollView(
          // padding: EdgeInsets.all(20),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: widget.children,
          ),
        ),
      ),
    );
  }

  void showModal() {
    if (widget.onOpen != null) {
      widget.onOpen!();
    }

    showBarModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(.5),
      backgroundColor: Colors.white,
      bounce: true,
      expand: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [title(), searchBox(), listItems()],
            );
          },
        );
      },
    );
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
          FormLabel(label: widget.label),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          TextField(
            controller: TextEditingController()..text = widget.text ?? "",
            focusNode: fnNode,
            onTap: onTap,
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
                    : Icon(
                        Feather.chevron_down,
                        color: Color(formIconColor),
                        size: formIconSize,
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
            ),
            onChanged: widget.onChange,
            style: TextStyle(
              fontSize: formInputSize,
              color: Color(
                formInputColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
