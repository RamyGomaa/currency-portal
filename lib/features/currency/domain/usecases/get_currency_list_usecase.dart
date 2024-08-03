import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/currency_repository.dart';

class GetCurrencyListUsecase
    implements UseCase<CurrencyResponseEntity, NoParams> {
  CurrencyRepository repository;
  GetCurrencyListUsecase(this.repository);
  @override
  Future<Either<Failure, CurrencyResponseEntity>> call(NoParams params) async {
    return await repository.getCurrencyList();
  }
}
