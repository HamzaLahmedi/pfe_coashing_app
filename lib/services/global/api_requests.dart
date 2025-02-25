import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:pfe_coashing_app/services/global/api_errorHandler.dart';
import 'package:pfe_coashing_app/services/global/api_response.dart';
import 'package:pfe_coashing_app/global/global_controller.dart';



class APIMethod {
  static const post = "POST";
  static const get = "GET";
  static const put = "PUT";
  static const delete = "DELETE";
  static const patch = "PATCH";
}

class APIRequest {
  static final dio.Dio dioInstance = dio.Dio();
  final APIErrorHandler _errorHandler = APIErrorHandler();
  
  static String get API {
    String api = const String.fromEnvironment('API_URL', defaultValue: 'http://localhost:1337/api');
    if (api.contains('localhost')) {
      if (Platform.isAndroid) {
        api = api.replaceAll('localhost', '10.0.2.2');
      } else if (Platform.isIOS) {
        api = api.replaceAll('localhost', '127.0.0.1');
      }
    }
    return api;
  }
  Future<APIResponse> getAPIRequest({
    required String method,
    required String path,
    Map? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool isMultipart = false,
  }) async {
    try {
      final response = await _executeRequest(
        method: method,
        path: path,
        body: body,
        headers: headers,
        queryParams: queryParams,
        isMultipart: isMultipart,
      );
      
      return _handleResponse(response);
    } catch (error) {
      return _errorHandler.handleError(error);
    }
  }

  Future<dio.Response> _executeRequest({
    required String method,
    required String path,
    Map? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool isMultipart = false,
  }) async {
    final defaultHeaders = {
      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
      'accept': '*/*',
    };

    // Add token from GlobalController if available
    if (GlobalController.token != null) {
      defaultHeaders['Authorization'] = 'Bearer ${GlobalController.token}';
    }

    final finalHeaders = {...defaultHeaders, ...?headers};
    final options = dio.Options(
      headers: finalHeaders,
      method: method,
      validateStatus: (status) => status! < 500,
    );

    return await dioInstance.request(
      '$API$path',
      data: body,
      queryParameters: queryParams,
      options: options,
    );
  }

  APIResponse _handleResponse(dio.Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return APIResponse(
        data: response.data,
        isError: false,
        status: response.statusCode,
      );
    }
    
    return _errorHandler.handleHttpError(response);
  }
}
