import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/core/flavor/flavor_config.dart';
import 'package:currency_converter/core/network/network_info.dart';
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/currrency_convert_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart';
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart';
import 'package:currency_converter/features/currency/domain/params/historical_currency_params.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_local_datasource.dart';
import '../datasources/currency_remote_datasource.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  final CurrencyLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CurrencyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CurrencyConvertResponseEntity>> convertCurrency(
      ConvertCurrencyParams params) async {
    if (await networkInfo.isConnected) {
      return await _fetchFromRemoteOrLocal(params);
    } else {
      return await _fetchFromLocal(params, isNetworkConnected: false);
    }
  }

  Future<Either<Failure, CurrencyConvertResponseEntity>>
      _fetchFromRemoteOrLocal(ConvertCurrencyParams params) async {
    try {
      final result = await remoteDataSource.convertCurrency(params);
      return Right(result);
    } catch (e) {
      return await _fetchFromLocal(params);
    }
  }

  Future<Either<Failure, CurrencyConvertResponseEntity>> _fetchFromLocal(
      ConvertCurrencyParams params,
      {bool isNetworkConnected = true}) async {
    try {
      final result = await localDataSource.getConvertCurrency(params);
      if (result == null) {
        throw CacheException();
      }
      return Right(result);
    } on Exception catch (_) {
      return Left(fromExceptionToFailure(
          isNetworkConnected ? ServerException() : NetworkException()));
    }
  }

  @override
  Future<Either<Failure, CurrencyResponseEntity>> getCurrencyList() async {
    try {
      // Try to get data from local storage first
      final localResult = await localDataSource.getCurrencyList();
      if (localResult == null) {
        throw CacheException();
      }
      return Right(localResult);
    } on Exception catch (_) {
      // If local data is not available, check for internet connection
      if (await networkInfo.isConnected) {
        try {
          // Fetch data from remote source
          final remoteResult = await remoteDataSource
              .getCurrencyList(FlavorConfig.instance.currencyApiKey);
          // Cache the fetched data
          localDataSource.cacheCurrencyList(remoteResult);
          return Right(remoteResult);
        } on Exception catch (_) {
          // If fetching from remote fails, return ServerFailure
          return const Left(ServerFailure());
        }
      } else {
        // If no internet connection, return NetworkFailure
        return const Left(NetworkFailure());
      }
    }
  }

  @override
  Future<Either<Failure, HistoricalCurrencyResponseEntity>>
      getHistoricalCurrencyData(HistoricalCurrencyParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getHistoricalData(params);
        return Right(result);
      } on Exception catch (_) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final result = await localDataSource.getHistoricalData(params);
        if (result == null) {
          throw CacheException();
        }
        return Right(result);
      } on Exception catch (_) {
        return const Left(CacheFailure());
      }
    }
  }
}
