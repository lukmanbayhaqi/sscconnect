import 'package:flutter/material.dart';

import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/utils/utils.dart';

class InputCustom extends StatelessWidget {
  final String label;
  final ValueChanged<String> onSelect;
  final List inputList;

  const InputCustom({
    required this.onSelect,
    required this.label,
    required this.inputList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget listItem(String type) {
      return InkWell(
        onTap: () {
          onSelect(type);

          context.goBack();
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: adaptiveWidthSize(context, 20),
            horizontal: adaptiveWidthSize(context, 35),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, 30),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CAppBar(
        title: "Select $label",
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: adaptiveWidthSize(context, 20),
            ),
          ),
          ...inputList
              .map(
                (e) => listItem(e),
              )
              .toList()
        ],
      ),
    );
  }
}
