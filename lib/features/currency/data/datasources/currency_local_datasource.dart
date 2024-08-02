import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/currrency_convert_entity.dart';
import '../../domain/entities/historical_currency_entity.dart';

abstract class CurrencyLocalDataSource {
  //get currency list
  Future<List<CurrencyResponseEntity>> getCurrencyList();

  Future<void> cacheCurrencyList(List<CurrencyResponseEntity> currencyList);

  //get historical data
  Future<HistoricalCurrencyResponseEntity> getHistoricalData(
      String symbol, String date);

  Future<void> cacheHistoricalData(
      HistoricalCurrencyResponseEntity historicalCurrencyResponseEntity);

  //convert currency
  Future<CurrencyConvertResponseEntity> getConvertCurrency(
      String from, String to, double amount);

  Future<void> cacheCurrencyConversion(
      CurrencyConvertResponseEntity currencyConvertResponseEntity);
}
