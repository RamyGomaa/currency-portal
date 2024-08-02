import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/currrency_convert_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/domain/usecase/usecase.dart';
import '../repositories/currency_repository.dart';

class GetCurrencyListUsecase
    implements UseCase<CurrencyResponseEntity, NoParams> {
  CurrencyRepository repository;
  GetCurrencyListUsecase(this.repository);
  @override
  Future<Either<Failure, CurrencyResponseEntity>> call(NoParams params) async {
    Logger().i('GetCurrencyListUsecase called');
    return await repository.getCurrencyList();
  }
}
