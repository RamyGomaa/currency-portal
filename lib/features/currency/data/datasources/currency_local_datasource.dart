import 'package:currency_converter/core/constants/hive_constants.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/currrency_convert_entity.dart';
import '../../domain/entities/historical_currency_entity.dart';
import '../../domain/params/convert_currency_params.dart';
import '../../domain/params/historical_currency_params.dart';

abstract class CurrencyLocalDataSource {
  //get currency list
  Future<CurrencyResponseEntity>? getCurrencyList();

  Future<void> cacheCurrencyList(CurrencyResponseEntity currencyList);

  //get historical data
  Future<HistoricalCurrencyResponseEntity>? getHistoricalData(
      HistoricalCurrencyParams params);

  Future<void> cacheHistoricalData(
      HistoricalCurrencyResponseEntity historicalCurrencyResponseEntity);

  //convert currency
  Future<CurrencyConvertResponseEntity>? getConvertCurrency(
      ConvertCurrencyParams params);

  Future<void> cacheCurrencyConversion(
      CurrencyConvertResponseEntity currencyConvertResponseEntity);
}

class CurrencyLocalDataSourceImpl implements CurrencyLocalDataSource {
  HiveInterface hive;
  CurrencyLocalDataSourceImpl({required this.hive});
  @override
  Future<void> cacheCurrencyConversion(
      CurrencyConvertResponseEntity currencyConvertResponseEntity) async {
    var res = await hive.openBox(HiveBox.currencyConvertion);
    res.put(HiveBox.currencyConvertion, currencyConvertResponseEntity);
  }

  @override
  Future<void> cacheCurrencyList(CurrencyResponseEntity currencyList) async {
    var res = await hive.openBox(HiveBox.currencyList);
    res.put(HiveBox.currencyList, currencyList);
  }

  @override
  Future<void> cacheHistoricalData(
      HistoricalCurrencyResponseEntity historicalCurrencyResponseEntity) async {
    var res = await hive.openBox(HiveBox.historicalData);
    res.put(HiveBox.historicalData, historicalCurrencyResponseEntity);
  }

  @override
  Future<CurrencyConvertResponseEntity>? getConvertCurrency(
      ConvertCurrencyParams params) async {
    var res = await hive.openBox(HiveBox.currencyConvertion);
    return res.get(HiveBox.currencyConvertion);
  }

  @override
  Future<CurrencyResponseEntity> getCurrencyList() async {
    var res = await hive.openBox(HiveBox.currencyList);
    final data = res.get(HiveBox.currencyList);
    if (data != null) {
      return data;
    } else {
      throw Exception('No data found in local storage');
    }
  }

  @override
  Future<HistoricalCurrencyResponseEntity>? getHistoricalData(
      HistoricalCurrencyParams params) async {
    var res = await Hive.openBox(HiveBox.historicalData);
    return res.get(HiveBox.historicalData);
  }
}
