import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../injection_container.dart';
import '../constants/api_request_constants.dart';

class AppSettings {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
}

class ApiInterceptor extends Interceptor {
  // final AuthRepository authRepository;
  ApiInterceptor();
  // ApiInterceptor({required this.authRepository});
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // options.headers[ApiRequestConstants.acceptLanguage] =
    //     EasyLocalization.of(AppSettings.navigatorState.currentContext!)!
    //         .currentLocale!
    //         .toLanguageTag();
    if (options.headers[ApiRequestConstants.requiredToken] == true) {
      // var expirRes = await authRepository.getToken();
      // await expirRes.fold((l) {
      //   sl<LoginBloc>().add(LogoutEvent());
      //   sl<LoginCheckerBloc>().add(const CheckLoginEvent());
      // }, (userToken) async {
      //   options.headers[ApiRequestConstants.authorization] =
      //       '${ApiRequestConstants.bearer} ${userToken.accessToken}';
      // });
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        err.requestOptions.headers[ApiRequestConstants.requiredToken] == true) {
      // var tokenRes =
      //     await authRepository.getValidAccessToken(forceRefresh: true);
      // await tokenRes.fold((l) {
      //   sl<LoginBloc>().add(LogoutEvent());
      //   sl<LoginCheckerBloc>().add(const CheckLoginEvent());
      // }, (r) async {
      // handler.resolve(await _retry(err.requestOptions));
      // });
    }
    return handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return sl<Dio>().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }
}
