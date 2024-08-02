import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/domain/entities/currrency_convert_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/domain/usecase/usecase.dart';
import '../repositories/currency_repository.dart';

class GetCurrencyListUsecase
    implements UseCase<List<CurrencyResponseEntity>, NoParams> {
  CurrencyRepository repository;
  GetCurrencyListUsecase(this.repository);
  @override
  Future<Either<Failure, List<CurrencyResponseEntity>>> call(
      NoParams params) async {
    return await repository.getCurrencyList();
  }
}
