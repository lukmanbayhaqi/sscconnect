import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'extensions.dart';
import 'package:sscconnect/utils/variables.dart';

Timer setTimeout(int duration, VoidCallback callback) {
  return Timer(Duration(milliseconds: duration), callback);
}

Timer setIntervalTimer(int interval, void Function(Timer) callback) {
  return Timer.periodic(Duration(milliseconds: interval), callback);
}

Timer setIntervalTick(int interval, void Function(int) callback) {
  return Timer.periodic(Duration(milliseconds: interval), (timer) {
    callback(timer.tick);
  });
}

Timer setInterval(int interval, VoidCallback callback) {
  return Timer.periodic(Duration(milliseconds: interval), (timer) {
    callback();
  });
}

String formatDate(DateTime? date) {
  if (date == null) return "";
  return date.toFormattedDate();
}

String formatDateTime(DateTime? date) {
  if (date == null) return "";
  return date.toFormattedDateTime();
}

Color randomColor() {
  Random rnd = Random();
  List<Color> colorList = <Color>[
    Color(0xffaa2e25),
    Color(0xfff44336),
    Color(0xfff6685e),
    Color(0xffa31545),
    Color(0xffe91e63),
    Color(0xffed4b82),
    Color(0xff6d1b7b),
    Color(0xff9c27b0),
    Color(0xffaf52bf),
    Color(0xff482880),
    Color(0xff673ab7),
    Color(0xff8561c5),
    Color(0xff2c387e),
    Color(0xff3f51b5),
    Color(0xff3f51b5),
    Color(0xff1769aa),
    Color(0xff2196f3),
    Color(0xff4dabf5),
    Color(0xff0276aa),
    Color(0xff03a9f4),
    Color(0xff35baf6),
    Color(0xff008394),
    Color(0xff008394),
    Color(0xff33c9dc),
    Color(0xff00695f),
    Color(0xff009688),
    Color(0xff33ab9f),
    Color(0xff357a38),
    Color(0xff4caf50),
    Color(0xff6fbf73),
    Color(0xff618833),
    Color(0xff8bc34a),
    Color(0xffa2cf6e),
    Color(0xff8f9a27),
    Color(0xffcddc39),
    Color(0xffd7e360),
    Color(0xffb2a429),
    Color(0xffffeb3b),
    Color(0xffffef62),
    Color(0xffb28704),
    Color(0xffffc107),
    Color(0xffffcd38),
    Color(0xffb26a00),
    Color(0xffb26a00),
    Color(0xffffac33),
    Color(0xffb23c17),
    Color(0xffff5722),
    Color(0xffff784e),
    // Color(0xff1769aa),
    // Color(0xff1769aa),
    // Color(0xff1769aa),
    // Color(0xff1769aa),
    // Color(0xff1769aa),
    // Color(0xff1769aa),
    // Color(0xff1769aa),
    // Color(0xff1769aa),
    // Color(0xff2196f3),
    // Color(0xfff50057),
    // Color(0xffff5722),
    // Color(0xff00bcd4),
    // Color(0xffe91e63),
    // Color(0xfff44336),
    // Color(0xff482880),
    // Color(0xff673ab7),
    // Color(0xff8561c5),
    // Color(0xff00bcd4),
  ];

  return colorList[rnd.nextInt(colorList.length - 1)];
}

String randomImage() {
  Random rnd = Random();
  return "https://source.unsplash.com/random/200x200?sig=${rnd.nextInt(1000)}";
}

String url(String path) {
  return "$baseUrl$path";
}

String urlFor(String path) {
  if (path.contains("?")) {
    return "$baseUrl$path&workspace=$currentWorkspaceId";
  }

  return "$baseUrl$path?workspace=$currentWorkspaceId";
}

double adaptiveHeightSize(BuildContext context, dynamic value) {
  return (value / 720) * MediaQuery.of(context).size.height;
}

double adaptiveWidthSize(BuildContext context, double value) {
  return (value / 720) * MediaQuery.of(context).size.width;
}

bool checkIsAfter({
  required String a,
  required String b,
  String formatDate = "yyyy-MM-ddThh:mm:ss",
}) {
  if (a == "" || b == "") {
    return false;
  }

  return DateFormat(formatDate)
      .parse(a)
      .isAfter(DateFormat(formatDate).parse(b));
}
