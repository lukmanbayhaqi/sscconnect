import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

enum CAlertType {
  primary,
  success,
  danger,
  warning,
}

class CAlert extends StatefulWidget {
  final String title;
  final String? description;
  final CAlertType type;

  const CAlert({
    Key? key,
    required this.title,
    this.description,
    this.type = CAlertType.primary,
  }) : super(key: key);

  @override
  CAlertState createState() => CAlertState();
}

class CAlertState extends State<CAlert> {
  Icon? icon;
  Color color = Color.fromARGB(255, 198, 221, 251).withAlpha(0x55);
  Color borderColor = Color.fromARGB(255, 65, 132, 241);
  Color textColor = Color.fromARGB(255, 43, 39, 143);

  @override
  void initState() {
    super.initState();

    if (widget.type == CAlertType.danger) {
      color = Color(0xfffbc6d3).withAlpha(0x55);
      borderColor = Color(0xfff1416c);
      textColor = Color(0xff912741);
    }

    if (widget.type == CAlertType.success) {
      color = Color.fromARGB(255, 56, 134, 98).withAlpha(0x55);
      borderColor = Color(0xff198754);
      textColor = Color.fromARGB(255, 15, 83, 51);
    }

    if (widget.type == CAlertType.warning) {
      color = Color.fromARGB(255, 244, 200, 68).withAlpha(0x55);
      borderColor = Color(0xffffc107);
      textColor = Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: adaptiveWidthSize(context, 15),
          horizontal: adaptiveWidthSize(context, 20),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: adaptiveWidthSize(context, 30),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.description != null)
              Padding(
                padding: EdgeInsets.only(
                  top: adaptiveWidthSize(context, 10),
                  bottom: adaptiveWidthSize(context, 5),
                ),
                child: Text(
                  widget.description ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: adaptiveWidthSize(context, 25),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
