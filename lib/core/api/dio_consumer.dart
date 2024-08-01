import 'package:dio/dio.dart';

import '../constants/api_request_constants.dart';
import '../constants/constants.dart';
import '../constants/end_points.dart';
import '../error/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.connectTimeout =
        const Duration(seconds: Constants.networkTimeout);
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
    Options? options,
    bool requireToken = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: getOptions(options, requireToken),
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requireToken = false,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: getOptions(options, requireToken),
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isFromData = false,
    bool requireToken = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: getOptions(options, requireToken),
      );

      return response.data;
    } on DioException catch (e) {
      throw handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isFromData = false,
    bool requireToken = false,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: getOptions(options, requireToken),
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioExceptions(e);
    }
  }

  getOptions(Options? options, bool requireToken) {
    return options?.copyWith(
          headers: {
            'accept': 'application/json',
            ApiRequestConstants.requiredToken: requireToken,
          },
        ) ??
        Options(
          headers: {
            'accept': 'application/json',
            ApiRequestConstants.requiredToken: requireToken,
          },
        );
  }
}

Exception handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ServerException(errModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.sendTimeout:
      return ServerException(errModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.receiveTimeout:
      return ServerException(errModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.badCertificate:
      return ServerException(errModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.cancel:
      return ServerException(errModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.connectionError:
      return ServerException(errModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.unknown:
      return ServerException(errModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          return NotFoundException();
        case 401: //unauthorized
          return UnAuthorizedException();
        case 403: //forbidden
          return ServerException();
        case 404: //not found
          return NotFoundException();
        case 405: //method not allowed
          return ServerException();
        case 409: //cofficient
          return ServerException();
        case 422: //  Unprocessable Entity
          return ServerException();
        case 504: // Server exception
          return ServerException();
        default:
          return ServerException();
      }
  }
}
