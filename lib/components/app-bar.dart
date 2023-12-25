import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final Widget? widgetTitle;
  final List<Widget>? actions;
  final bool isLoading;

  const CAppBar({
    Key? key,
    this.title,
    this.widgetTitle,
    this.actions,
    this.isLoading = false,
  })  : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widgetTitle ??
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, 35),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      actions: actions,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: isLoading
            ? LinearProgressIndicator(
                color: Colors.blueAccent,
                backgroundColor: Colors.blueAccent.withOpacity(.3),
              )
            : Container(
                color: Colors.redAccent,
                height: 0.0,
              ),
      ),
    );
  }
}
