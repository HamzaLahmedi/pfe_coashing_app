import 'dart:convert';
import 'package:pfe_coashing_app/services/global/api_response.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:async';
import 'package:get/get.dart';
class APIErrorHandler {
  APIResponse handleError(dynamic error) {
    if (error is dio.DioException) {
      return _handleDioError(error);
    }
    if (error is TimeoutException) {
      return APIResponse(
        isError: true,
        errorMessage: "connection_timed_out".tr,
        status: null
      );
    }
    return APIResponse(
      isError: true,
      errorMessage: error.toString(),
      status: null
    );
  }

  APIResponse handleHttpError(dio.Response response) {
    if (response.statusCode == 401) {
      return APIResponse(
        isError: true,
        status: 401,
        errorMessage: "login_again"
      );
    }

    final data = response.data;
    if (data is String && data.contains("error")) {
      return APIResponse(
        isError: true,
        errorMessage: jsonDecode(data)["error"].toString().tr,
        status: response.statusCode
      );
    }

    return APIResponse(
      isError: true,
      errorMessage: response.statusMessage,
      status: response.statusCode
    );
  }

  APIResponse _handleDioError(dio.DioException error) {
    final statusCode = error.response?.statusCode;
    
    // Handle 500 errors specifically
    if (statusCode == 500) {
      return APIResponse(
        isError: true,
        errorMessage: "server_error".tr,
        status: 500,
        data: error.response?.data // Include error data for debugging
      );
    }

    if (statusCode == 401) {
      return APIResponse(
        isError: true,
        errorMessage: "unauthorized_session".tr,
        status: 401
      );
    }

    final errorData = error.response?.data;
    if (errorData == null) {
      return APIResponse(
        isError: true,
        errorMessage: "Unknown error".tr,
        status: error.response?.statusCode
      );
    }

    if (errorData is Map) {
      return _handleMapError(errorData, error.response?.statusCode);
    }

    return APIResponse(
      isError: true,
      errorMessage: errorData.toString().tr,
      status: error.response?.statusCode
    );
  }

  APIResponse _handleMapError(Map errorData, int? statusCode) {
    if (statusCode == 500) {
      final message = errorData["message"] ?? "server_error".tr;
      return APIResponse(
        isError: true,
        errorMessage: message.toString().tr,
        status: statusCode,
        data: errorData // Include full error data
      );
    }
    
    if (errorData.containsKey("message")) {
      final message = errorData["message"];
      if (message is Map && message.containsKey("errors")) {
        final firstError = message["errors"].values.first;
        return APIResponse(
          isError: true,
          errorMessage: firstError.toString().tr,
          status: statusCode
        );
      }
      return APIResponse(
        isError: true,
        errorMessage: message.toString().tr,
        status: statusCode
      );
    }
    return APIResponse(
      isError: true,
      errorMessage: "An error occurred".tr,
      status: statusCode
    );
  }
}
