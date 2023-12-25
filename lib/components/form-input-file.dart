import 'package:sscconnect/components/form-label.dart';

import 'package:sscconnect/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CFormInputFile extends StatefulWidget {
  final String? label;
  final String? description;
  final String? invalidMessage;
  final List<String>? invalidMessages;
  final ValueChanged<String>? onChange;

  const CFormInputFile(
      {Key? key,
      this.label,
      this.description,
      this.invalidMessage,
      this.invalidMessages,
      this.onChange})
      : super(key: key);

  @override
  CFormInputFileState createState() => CFormInputFileState();
}

class CFormInputFileState extends State<CFormInputFile> {
  String fileName = "";
  FocusNode fnNode = FocusNode();

  void onTap() async {
    fnNode.unfocus();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }

    if (widget.onChange != null) {
      widget.onChange!(result.files.single.path!);
    }

    setState(() {
      fileName = result.files.single.name;
    });
    fnNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: formMarginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormLabel(label: widget.label),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          TextField(
            controller: TextEditingController()..text = fileName,
            focusNode: fnNode,
            onTap: onTap,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide(
                    width: 1, color: textColor14, style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide(
                    width: 1, color: textColor14, style: BorderStyle.solid),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(formBorderRadius),
                borderSide: BorderSide(
                    width: 1, color: textColor14, style: BorderStyle.solid),
              ),
              filled: true,
              // fillColor: textColor15,
              fillColor: Colors.white,
              isDense: true,
              contentPadding: EdgeInsets.all(formInputPadding),
              suffixIcon: Container(
                padding: EdgeInsets.all(formInputPadding),
                child: Icon(
                  Entypo.attachment,
                  color: Color(formIconColor),
                  size: formIconSize,
                ),
              ),
              suffixIconConstraints:
                  BoxConstraints(minHeight: formInputPadding),
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
                fontSize: formInputSize, color: Color(formInputColor)),
          )
        ],
      ),
    );
  }
}
