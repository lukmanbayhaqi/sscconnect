import 'dart:convert';

import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

enum CColorToast {
  primary,
  danger,
  warning,
  success,
}

class GlobalState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String status = ApiResponse().status ?? "";

  bool _isLoadingAppBar = false;
  bool get isLoadingAppBar => _isLoadingAppBar;

  bool _isShowToast = false;
  bool get isShowToast => _isShowToast;

  String _textToast = "";
  String get textToast => _textToast;

  Color _colorToast = primaryColor;
  Color get colorToast => _colorToast;

  String _currentLangId = "en";
  String get currentLangId => _currentLangId;

  Map _language = {};

  String language(id) => _language[id] ?? id;

  // void load() {
  //   // _currentLangId = prefs?.getString(prefKeyLangId) ?? "en";
  //   notifyListeners();
  // }

  void setLocale(context, id) async {
    _currentLangId = id;
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/lang/${id.toString()}.json");
    _language = jsonDecode(data);
    // prefs?.setString(prefKeyLangId, id);
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setLoadingAppBar(bool val) {
    _isLoadingAppBar = val;
    notifyListeners();
  }

  void setShowToast({
    bool show = true,
    String? text,
    CColorToast? color,
    int? duration,
  }) {
    _isShowToast = show;

    if (text != null) {
      _textToast = text;
    }

    if (color == CColorToast.primary) {
      _colorToast = primaryColor;
    } else if (color == CColorToast.danger) {
      _colorToast = Color.fromARGB(255, 255, 92, 80);
    } else if (color == CColorToast.warning) {
      _colorToast = Colors.orange;
    } else if (color == CColorToast.success) {
      _colorToast = Colors.lightGreen;
    }

    setTimeout(duration ?? 3000, () {
      _isShowToast = false;

      notifyListeners();
    });

    notifyListeners();
  }
}
