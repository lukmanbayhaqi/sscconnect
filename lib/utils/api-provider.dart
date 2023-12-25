import 'dart:io';

import 'package:sscconnect/utils/utils.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:sscconnect/utils/variables.dart';
import 'package:flutter/material.dart';

class ApiDataTableResponse<T> {
  T? items;
  int length = 0;
  int page = 0;
  int total = 0;
  int filtered = 0;

  ApiDataTableResponse({
    this.items,
    required this.length,
    required this.page,
    required this.filtered,
    required this.total,
  });

  factory ApiDataTableResponse.fromJson(Map<String, dynamic> json) =>
      ApiDataTableResponse(
        items: json["Items"],
        length: json["Length"],
        page: json["Page"],
        total: json["Total"],
        filtered: json["Filtered"],
      );
}

class ApiResponse<T> {
  String? status;
  Map<String, dynamic>? errors;
  String? message;
  T? data;

  bool get isSuccess => status == "Success";
  bool get isError => status == "Error";
  bool get isInvalid => status == "Invalid";
  bool get isNotFound => status == "NotFound";
  bool get isDisconnected => status == "Disconnected";
  bool get isUnauthorized => status == "Unauthorized";

  ApiResponse({
    this.status = "Success",
    this.errors,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        errors: json["Errors"],
        status: json["Status"],
        data: json["Data"] as T,
        message: json["Message"],
      );

  List<dynamic> getItems() {
    if (data != null) {
      return (data as Map<String, dynamic>)["Items"] as List;
    }

    return List.empty();
  }

  Map<String, List<String>> getErrors() {
    if (errors != null) {
      Map<String, List<String>> tempErr = {};

      for (var el in errors!.entries) {
        List tempList = el.value.toList();

        tempErr[el.key] = tempList.map((item) => item as String).toList();
      }

      return tempErr;
    }

    return {};
  }
}

Future<ApiResponse> httpPost<T>(
  BuildContext context,
  String path, {
  data,
  bool redirect = true,
}) async {
  Dio dio = Dio();

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.headers["Authorization"] = "Bearer $authenticationToken";
  dio.options.headers["WorkspaceId"] = currentWorkspaceId;
  dio.options.baseUrl = baseUrl;

  if (data is FormData) {
    dio.options.headers["Content-Type"] = "multipart/form-data";
  }

  try {
    var response = await dio.post(path, data: data);

    if (response.statusCode == 200) {
      return ApiResponse<T>.fromJson(response.data);
    }

    return ApiResponse<T>(errors: response.data["Error"], status: "Error");
  } on DioError catch (e) {
    if (e.type == DioErrorType.other &&
        e.message.startsWith("SocketException: Failed host lookup:")) {
      return ApiResponse<T>(status: "Disconnected", message: e.message);
    }

    if (e.type == DioErrorType.response && e.response?.statusCode == 400) {
      return ApiResponse<T>(
        status: "Invalid",
        message: e.message,
        errors: e.response?.data["Errors"],
      );
    }

    if (e.type == DioErrorType.response && e.response?.statusCode == 401) {
      if (redirect) {
        context.forceLogout();
      }

      return ApiResponse<T>(
        status: "Unauthorized",
        message: e.message,
      );
    }

    return ApiResponse<T>(status: "Error", message: e.message);
  }
}

Future<ApiResponse> httpPatch<T>(
  BuildContext context,
  String path, {
  data,
}) async {
  Dio dio = Dio();

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.headers["Authorization"] = "Bearer $authenticationToken";
  dio.options.headers["WorkspaceId"] = currentWorkspaceId;
  dio.options.baseUrl = baseUrl;

  if (data is FormData) {
    dio.options.headers["Content-Type"] = "multipart/form-data";
  }

  try {
    var response = await dio.patch(path, data: data);

    if (response.statusCode == 200) {
      return ApiResponse<T>.fromJson(response.data);
    }

    return ApiResponse<T>(errors: response.data["Error"], status: "Error");
  } on DioError catch (e) {
    if (e.type == DioErrorType.other &&
        e.message.startsWith("SocketException: Failed host lookup:")) {
      return ApiResponse<T>(status: "Disconnected", message: e.message);
    }

    if (e.type == DioErrorType.response && e.response?.statusCode == 400) {
      return ApiResponse<T>(
        status: "Invalid",
        message: e.response?.data["Message"] ?? e.message,
        errors: e.response?.data["Errors"],
      );
    }

    if (e.type == DioErrorType.response && e.response?.statusCode == 401) {
      context.forceLogout();

      return ApiResponse<T>(
        status: "Unauthorized",
        message: e.message,
      );
    }

    return ApiResponse<T>(status: "Error", message: e.message);
  }
}

Future<ApiResponse> httpDelete<T>(
  BuildContext context,
  String path, {
  data,
}) async {
  Dio dio = Dio();

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.headers["Authorization"] = "Bearer $authenticationToken";
  dio.options.headers["WorkspaceId"] = currentWorkspaceId;
  dio.options.baseUrl = baseUrl;
  if (data is FormData) {
    dio.options.headers["Content-Type"] = "multipart/form-data";
  }
  try {
    var response = await dio.delete(path, data: data);
    if (response.statusCode == 200) {
      return ApiResponse<T>.fromJson(response.data);
    }
    return ApiResponse<T>(errors: response.data["Error"], status: "Error");
  } on DioError catch (e) {
    if (e.type == DioErrorType.other &&
        e.message.startsWith("SocketException: Failed host lookup:")) {
      return ApiResponse<T>(status: "Disconnected", message: e.message);
    }

    if (e.type == DioErrorType.response && e.response?.statusCode == 400) {
      return ApiResponse<T>(
        status: "Invalid",
        message: e.message,
        errors: e.response?.data["Errors"],
      );
    }

    if (e.type == DioErrorType.response && e.response?.statusCode == 401) {
      context.forceLogout();

      return ApiResponse<T>(
        status: "Unauthorized",
        message: e.message,
      );
    }

    return ApiResponse<T>(status: "Error", message: e.message);
  }
}

Future<ApiResponse> httpGet(
  BuildContext context,
  String path, {
  bool redirect = true,
}) async {
  Dio dio = Dio();

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.options.headers["Authorization"] = "Bearer $authenticationToken";
  dio.options.headers["WorkspaceId"] = currentWorkspaceId;
  dio.options.baseUrl = baseUrl;

  try {
    var response = await dio.get(path);

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(response.data);
    }

    return ApiResponse(errors: response.data["Error"]);
  } on DioError catch (e) {
    if (e.type == DioErrorType.connectTimeout) {
      return ApiResponse(status: "Error", message: e.message);
    }

    if (e.type == DioErrorType.response && e.response?.statusCode == 401) {
      if (redirect) {
        context.forceLogout();
      }

      return ApiResponse(
        status: "Unauthorized",
        message: e.message,
      );
    }

    return ApiResponse(status: "Error", message: e.message);
  }
}
