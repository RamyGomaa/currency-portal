import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/currrency_convert_entity.dart';
import '../entities/historical_currency_entity.dart';
import '../params/convert_currency_params.dart';
import '../params/historical_currency_params.dart';

abstract class CurrencyRepository {
  /// Converts currency from one type to another.
  ///
  /// Takes a [ConvertCurrencyParams] object which contains the details
  /// of the conversion such as the source currency, target currency, and amount.
  ///
  /// Returns a [Future] that resolves to an [Either] containing a [Failure]
  /// on the left side if an error occurs, or a [double] on the right side
  /// representing the converted amount.
  Future<Either<Failure, CurrencyConvertResponseEntity>> convertCurrency(
      ConvertCurrencyParams params);

  /// Retrieves a list of available currencies.
  ///
  /// Returns a [Future] that resolves to an [Either] containing a [Failure]
  /// on the left side if an error occurs, or a [List] of [CurrencyEntity]
  /// objects on the right side representing the available currencies.
  Future<Either<Failure, CurrencyResponseEntity>> getCurrencyList();

  Future<Either<Failure, HistoricalCurrencyResponseEntity>>
      getHistoricalCurrencyData(HistoricalCurrencyParams params);
}
