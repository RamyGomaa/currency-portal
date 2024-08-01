class DefaultException implements Exception {
  final ErrorModel? errModel;
  DefaultException({this.errModel});
}

class ErrorModel {
  final String? message;
  final String? errorCode;
  ErrorModel({this.message, this.errorCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'],
      errorCode: json['errorCode'],
    );
  }
}

class ServerException extends DefaultException {
  ServerException({super.errModel});
}

class NotFoundException implements Exception {
  final ErrorModel? errModel;
  NotFoundException({this.errModel});
}

class UnAuthorizedException implements Exception {
  final ErrorModel? errModel;
  UnAuthorizedException({this.errModel});
}

class NoTokenException implements Exception {
  final ErrorModel? errModel;
  NoTokenException({this.errModel});
}

class RefreshTokenExpiredException implements Exception {
  final ErrorModel? errModel;
  RefreshTokenExpiredException({this.errModel});
}

class LoginAuthException implements Exception {
  final ErrorModel? errModel;
  LoginAuthException({this.errModel});
}

class CacheException implements Exception {
  final ErrorModel? errModel;
  CacheException({this.errModel});
}

class NetworkException implements Exception {
  final ErrorModel? errModel;
  NetworkException({this.errModel});
}

//location exceptions

class LocationException implements Exception {
  final ErrorModel? errModel;
  LocationException({this.errModel});
}

class LocationServiceDisabledException implements Exception {
  final ErrorModel? errModel;
  LocationServiceDisabledException({this.errModel});
}

class LocationPermissionDeniedException implements Exception {
  final ErrorModel? errModel;
  LocationPermissionDeniedException({this.errModel});
}

class LocationPermissionDeniedForeverException implements Exception {
  final ErrorModel? errModel;
  LocationPermissionDeniedForeverException({this.errModel});
}

class UpdateException implements Exception {
  final ErrorModel? errModel;
  UpdateException({this.errModel});
}

class CompressImageException implements Exception {
  final ErrorModel? errModel;
  CompressImageException({this.errModel});
}

class PickImageException implements Exception {
  final ErrorModel? errModel;
  PickImageException({this.errModel});
}
