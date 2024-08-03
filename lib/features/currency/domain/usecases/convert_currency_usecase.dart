import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart';
import 'package:currency_converter/features/currency/domain/repositories/currency_repository.dart';
import 'package:currency_converter/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/currrency_convert_entity.dart';

class ConvertCurrencyUsecase
    implements UseCase<CurrencyConvertResponseEntity, ConvertCurrencyParams> {
  CurrencyRepository repository;
  ConvertCurrencyUsecase(this.repository);
  @override
  Future<Either<Failure, CurrencyConvertResponseEntity>> call(
      ConvertCurrencyParams params) async {
    return await repository.convertCurrency(params);
  }
}
