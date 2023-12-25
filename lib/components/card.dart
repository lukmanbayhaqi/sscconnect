import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const CCard({
    required this.child,
    this.backgroundColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(0x11), //.withAlpha(1),
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: adaptiveWidthSize(context, 25),
          horizontal: adaptiveWidthSize(context, 20),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}
