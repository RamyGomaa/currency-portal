import 'package:currency_converter/features/currency/data/models/currency%20convert%20model/currency_convert_model.dart';
import 'package:currency_converter/features/currency/data/models/currency%20model/currency_model.dart';
import 'package:currency_converter/features/currency/data/models/historical%20currency%20model/historical_currency_model.dart';
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entities/currrency_convert_entity.dart';
import '../../domain/params/convert_currency_params.dart';
import '../../domain/params/historical_currency_params.dart';
part 'currency_remote_datasource.g.dart';

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

@RestApi()
abstract class CurrencyRemoteDataSourceImpl extends CurrencyRemoteDataSource {
  factory CurrencyRemoteDataSourceImpl(Dio dio, {String baseUrl}) =
      _CurrencyRemoteDataSourceImpl;

  @GET('/convert')
  @override
  Future<CurrencyConvertResponseModel> convertCurrency(
    @Queries() ConvertCurrencyParams params,
  );

  @GET('/symbols')
  @override
  Future<CurrencyResponseModel> getCurrencyList(
    @Query('api_key') String apiKey,
  );

  //convert currency
  @GET('/timeframe')
  @override
  Future<HistoricalCurrencyResponseModel> getHistoricalData(
      @Queries() HistoricalCurrencyParams params);
}
