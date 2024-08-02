import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart';

import '../../domain/entities/currrency_convert_entity.dart';

abstract class CurrencyRemoteDataSource {
  //historical
  //symbol
  //converter

  //get currency list
  Future<List<CurrencyResponseEntity>> getCurrencyList();

  //get historical data
  Future<HistoricalCurrencyResponseEntity> getHistoricalData(
      String symbol, String date);

  //convert currency
  Future<CurrencyConvertResponseEntity> convertCurrency(
      String from, String to, double amount);
}
