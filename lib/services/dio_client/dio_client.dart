import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/constants.dart';
import 'package:zartek_machine_test/utils/enums_and_constants/enums.dart';

class DioClient {
  static late Dio _dioWithoutToken;

  Dio get unAuthenticatedInstance {
    _dioWithoutToken = _initWithOutToken();
    return _dioWithoutToken;
  }

  DioClient() {
    _dioWithoutToken = _initWithOutToken();
  }

  Dio _initWithOutToken() {
    Dio _dio = Dio();
    _dio.options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      followRedirects: false,
      validateStatus: (status) {
        if (status != null) {
          return status < 500;
        } else {
          return false;
        }
      },
      contentType: 'application/json',
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    _dio.options.baseUrl = ApiUrls.baseUrl;
    return _dio;
  }

  Future<Response> request({
    required Uri uri,
    required APIMethod method,
    String? params,
    FormData? formData,
    bool isAuth = true,
  }) async {
    Response? response;

    try {
      if (method == APIMethod.POST) {
        response = await (_dioWithoutToken).postUri(
          uri,
          data: formData ?? params,
        );
      } else if (method == APIMethod.PUT) {
        response = await (_dioWithoutToken).putUri(
          uri,
          data: formData ?? params,
        );
      } else if (method == APIMethod.DELETE) {
        response = await (_dioWithoutToken).deleteUri(uri);
      } else if (method == APIMethod.PATCH) {
        response = await (_dioWithoutToken).patchUri(uri);
      } else {
        response = await (_dioWithoutToken).getUri(uri);
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 422) {
        return response;
      } else if (response.statusCode == 400) {
        throw Exception(response.data!["message"]);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException catch (e) {
      debugPrint(e.message);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      debugPrint("$e");
      throw Exception(e);
    } catch (e) {
// logger.e(e);
      debugPrint("$e");
      throw Exception("Something went wrong");
    }
  }
}
