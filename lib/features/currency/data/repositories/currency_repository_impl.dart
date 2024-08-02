import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/currrency_convert_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart';
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart';
import 'package:currency_converter/features/currency/domain/params/historical_currency_params.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_local_datasource.dart';
import '../datasources/currency_remote_datasource.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  final CurrencyLocalDataSource localDataSource;

  CurrencyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CurrencyConvertResponseEntity>> convertCurrency(
      ConvertCurrencyParams params) {
    // TODO: implement convertCurrency
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CurrencyResponseEntity>>> getCurrencyList() {
    // TODO: implement getCurrencyList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, HistoricalCurrencyResponseEntity>>
      getHistoricalCurrencyData(HistoricalCurrencyParams params) {
    // TODO: implement getHistoricalData
    throw UnimplementedError();
  }
}
