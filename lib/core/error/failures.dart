import 'package:equatable/equatable.dart';

import '../resources/strings_manager.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = AppStrings.locGeneralError});
}

//Gemeral Failures

class ServerFailure extends Failure {
  const ServerFailure({super.message = AppStrings.locServerErrorMessage});
  @override
  List<Object?> get props => [];
}

class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure(
      {super.message = AppStrings.locUnAuthorizedErrorMessage});
  @override
  List<Object?> get props => [];
}

class LoginAuthFailure extends Failure {
  const LoginAuthFailure({super.message = AppStrings.locLoginAuthErrorMessage});
  @override
  List<Object?> get props => [];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = AppStrings.locNotFoundErrorMessage});
  @override
  List<Object?> get props => [];
}

class NoTokenFailure extends Failure {
  const NoTokenFailure({super.message = AppStrings.locNoTokenErrorMessage});
  @override
  List<Object?> get props => [];
}

class RefreshTokenExpiredFailure extends Failure {
  const RefreshTokenExpiredFailure(
      {super.message = AppStrings.locTokenExpiredErrorMessage});
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = AppStrings.locNetworkErrorMessage});
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnimplementedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

//location failures
class LocationFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocationPermissionDeniedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocationServiceDisabledFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocationPermissionDeniedForeverFailure extends Failure {
  @override
  List<Object?> get props => [];
}

//pick image failures
class PickImageFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CompressImageFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UpdateFailure extends Failure {
  @override
  List<Object?> get props => [];
}

final exceptionToFailureMap = {
  ServerException: const ServerFailure(),
  UnAuthorizedException: const UnAuthorizedFailure(),
  LoginAuthException: const LoginAuthFailure(),
  NotFoundException: const NotFoundFailure(),
  NoTokenException: const NoTokenFailure(),
  RefreshTokenExpiredException: const RefreshTokenExpiredFailure(),
  NetworkException: const NetworkFailure(),
  CacheException: CacheFailure(),
  LocationException: LocationFailure(),
  LocationPermissionDeniedException: LocationPermissionDeniedFailure(),
  LocationServiceDisabledException: LocationServiceDisabledFailure(),
  LocationPermissionDeniedForeverException:
      LocationPermissionDeniedForeverFailure(),
  PickImageException: PickImageFailure(),
  CompressImageException: CompressImageFailure(),
  UpdateException: UpdateFailure(),
};

Failure fromExceptionToFailure(Exception e) {
  return exceptionToFailureMap[e.runtimeType] ?? UnimplementedFailure();
}
