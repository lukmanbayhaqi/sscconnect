import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

extension BuildContextExtension on BuildContext {
  void navigate(WidgetBuilder builder) {
    MaterialPageRoute route = MaterialPageRoute(builder: builder);
    Navigator.push(this, route);
  }

  void pushNamed(String routeName, {Object? args}) {
    Navigator.pushNamed(this, routeName, arguments: args);
    prefs?.setString(prefKeyLastRoute, routeName);
  }

  void pushPermanent(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false);

    prefs?.setString(prefKeyLastRoute, routeName);
  }

  void forceLogout() {
    // UserState().clearSession();

    // pushPermanent("sign-in");
  }

  void goBack() {
    Navigator.of(this).pop();
    String? routeName = ModalRoute.of(this)?.settings.name;
    if (routeName != null) {
      prefs?.setString(prefKeyLastRoute, routeName);
    }
  }

  T provider<T>({listen = false}) {
    return Provider.of<T>(this, listen: listen);
  }

  Future<T?> showBottomSheet<T>(
    WidgetBuilder builder, {
    bool isDismissible = true,
    bool isDraggable = true,
  }) {
    return showBarModalBottomSheet<T>(
      barrierColor: Colors.black.withOpacity(.5),
      context: this,
      builder: builder,
      expand: false,
      isDismissible: isDismissible,
      bounce: true,
      enableDrag: isDraggable,
    );
  }

  void showModalBottom(WidgetBuilder builder) {
    showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      builder: builder,
    );
  }

  Future<T?> showExpandedBottomSheet<T>(WidgetBuilder builder) {
    return showBarModalBottomSheet<T>(
      barrierColor: Colors.black.withOpacity(.5),
      context: this,
      builder: builder,
      expand: true,
    );
  }

  Future<void> alertWarning({
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) {
    return showDialog<void>(
      context: this,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                context.goBack();
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  void popupDateSlider(
    BuildContext context, {
    FocusNode? fnNode,
    String? defaultValue,
    DateTime? minDate,
    DateTime? maxDate,
    bool? use24hFormat,
    ValueChanged<DateTime>? onChange,
  }) {
    if (fnNode != null) {
      fnNode.unfocus();
    }
  }

  void popupTimeSlider(
    BuildContext context, {
    FocusNode? fnNode,
    String? defaultValue,
    DateTime? minDate,
    DateTime? maxDate,
    bool? use24hFormat,
    ValueChanged<DateTime>? onChange,
  }) async {
    if (fnNode != null) {
      fnNode.unfocus();
    }

    String value = "";
    DateTime? selectedDate;
    DateTime? max = maxDate;
    DateTime? min = minDate;
    final DateTime today = DateTime.now();
    DateTime initVal = DateTime.now();

    if (defaultValue != null && defaultValue != "") {
      initVal = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(defaultValue);
    }

    if (max != null) {
      max = DateTime(
        max.year,
        max.month,
        max.day,
        max.hour,
        max.minute,
        0,
        0,
      );
    }

    if (min != null) {
      min = DateTime(
        min.year,
        min.month,
        min.day,
        min.hour,
        min.minute,
        0,
        0,
      ).add(Duration(minutes: 30));
      initVal =
          DateTime(min.year, min.month, min.day, min.hour, min.minute, 0, 0);

      if (defaultValue != null && defaultValue != "") {
        if (DateFormat('yyyy-MM-ddTHH:mm:ss')
            .parse(defaultValue)
            .isBefore(min)) {
          initVal = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(defaultValue);
        } else {
          initVal = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(defaultValue);
        }
      }
    }

    value = initVal
        .add(
          Duration(
              minutes: initVal.minute % 30 == 0 ? 0 : 30 - initVal.minute % 30),
        )
        .toString()
        .toDateTime(format: "yyyy-MM-dd HH:mm:ss")
        .toIso8601String();

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: adaptiveWidthSize(context, 400),
        padding: EdgeInsets.only(
          top: adaptiveWidthSize(context, 10),
        ),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: adaptiveWidthSize(context, 10),
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            minuteInterval: 30,
            use24hFormat: use24hFormat ?? true,
            maximumDate: max,
            minimumDate: min,
            initialDateTime: value != ''
                ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value)
                : null,
            onDateTimeChanged: (DateTime v) {
              selectedDate = v;
            },
          ),
        ),
      ),
    );

    selectedDate ??= (value != "")
        ? DateFormat('yyyy-MM-ddTHH:mm:ss').parse(value)
        : today.add(
            Duration(minutes: 30 - today.minute % 30),
          );

    if (onChange != null && selectedDate != null) {
      onChange(selectedDate!);
    }
  }
}

enum DiffDateType {
  day,
  hour,
  minute,
  second,
}

extension DateTimeExtension on DateTime {
  String format() {
    return "${day.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-${year.toString().padLeft(4, '0')}";
  }

  String formatDate({String format = "yyyy-MM-ddThh:mm:ss"}) {
    return DateFormat(format).format(this);
  }

  String toFormattedDate() {
    return DateFormat("dd MMM yyyy").format(this);
  }

  String toFormattedDateTime() {
    return DateFormat("dd MMM yyyy HH:mm").format(this);
  }

  String toFormattedTime() {
    return DateFormat("HH:mm").format(this);
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  int diffDate({
    required DateTime withDate,
    required DiffDateType type,
  }) {
    if (type == DiffDateType.day) {
      return withDate.difference(this).inDays;
    }

    if (type == DiffDateType.hour) {
      return withDate.difference(this).inHours;
    }

    if (type == DiffDateType.minute) {
      return withDate.difference(this).inMinutes;
    }

    if (type == DiffDateType.second) {
      return withDate.difference(this).inSeconds;
    }

    return 0;
  }
}

extension DynamicExtension on dynamic {
  DateTime toDateTime({String format = 'yyyy-MM-ddThh:mm:ss'}) {
    return DateFormat(format).parse(this);
  }

  DateTime? toNullableDateTime() {
    if (this == null) {
      return null;
    }
    return DateFormat('yyyy-MM-ddThh:mm:ss').parse(this);
  }

  double toDouble() {
    return double.tryParse(this) ?? 0;
  }
}

extension StringExtension on String {
  DateTime toDateTime({String format = 'yyyy-MM-ddThh:mm:ss'}) {
    return DateFormat(format).parse(this);
  }

  DateTime? toNullableDateTime({String format = 'yyyy-MM-ddThh:mm:ss'}) {
    if (this == "" || this == "null") {
      return null;
    }

    return DateFormat(format).parse(this);
  }

  double toDouble() {
    return double.tryParse(this) ?? 0;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String formatTime() {
    return "${hour.toString().padLeft(2, '0')}.${minute.toString().padLeft(2, '0')}";
  }
}

extension DoubleExtension on double {
  String toStr() {
    return this % 1 == 0 ? toInt().toString() : toString();
  }

  String formatMoney() {
    var value = toString();

    if (value.length > 2) {
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
      return value;
    }

    return value;
  }
}

// bikin baru karena kalo di format jadi nambah satu 0 nya
// ex 75.000 => 750.000
extension IntExtension on int {
  String formatMoney() {
    var value = toString();

    if (value.length > 2) {
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
      return value;
    }

    return value;
  }
}

extension NullExt on Null {
  String toStr() {
    return "";
  }
}
