import 'package:currency_converter/core/flavor/flavor_config.dart';
import 'package:currency_converter/features/currency/data/models/currency%20convert%20model/currency_convert_model.dart';
import 'package:currency_converter/features/currency/data/models/currency%20model/currency_model.dart';
import 'package:currency_converter/features/currency/data/models/historical%20currency%20model/historical_currency_model.dart';
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart';
import 'package:currency_converter/injection_container.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entities/currrency_convert_entity.dart';
import '../../domain/params/convert_currency_params.dart';
import '../../domain/params/historical_currency_params.dart';
// part 'currency_remote_datasource.g.dart';

abstract class CurrencyRemoteDataSource {
  Future<CurrencyConvertResponseEntity> convertCurrency(
    ConvertCurrencyParams params,
  );

  Future<CurrencyResponseEntity> getCurrencyList(
    String apiKey,
  );

  Future<HistoricalCurrencyResponseEntity> getHistoricalData(
      HistoricalCurrencyParams params);
}

// @RestApi()
class CurrencyRemoteDataSourceImpl extends CurrencyRemoteDataSource {
  // factory CurrencyRemoteDataSourceImpl(Dio dio, {String baseUrl}) =
  //     _CurrencyRemoteDataSourceImpl;
  final Dio dio;
  CurrencyRemoteDataSourceImpl(this.dio);

  // @GET('/convert')
  @override
  Future<CurrencyConvertResponseModel> convertCurrency(
    ConvertCurrencyParams params,
  ) {
    throw UnimplementedError();
  }

  // @GET('/symbols')
  @override
  Future<CurrencyResponseModel> getCurrencyList(
    String apiKey,
  ) async {
    Logger().i('getCurrencyList called wllahi');
    var res = await sl<Dio>().get(
        FlavorConfig.instance.currencyBaseUrl + '/symbols',
        queryParameters: {'api_key': apiKey});

    // Logger().e("Here is the data after calling it ${res.data}");
    var data = CurrencyResponseModel.fromJson(res.data);
    // Logger().i(data);
    return data;
  }

  //convert currency
  // @GET('/timeframe')
  @override
  Future<HistoricalCurrencyResponseModel> getHistoricalData(
      @Queries() HistoricalCurrencyParams params) {
    throw UnimplementedError();
  }
}
