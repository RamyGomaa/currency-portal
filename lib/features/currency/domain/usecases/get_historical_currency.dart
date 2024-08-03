import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/historical_currency_entity.dart';
import '../params/historical_currency_params.dart';
import '../repositories/currency_repository.dart';

class GetHistoricalCurrencyUseCase
    implements
        UseCase<HistoricalCurrencyResponseEntity, HistoricalCurrencyParams> {
  final CurrencyRepository repository;

  GetHistoricalCurrencyUseCase(this.repository);

  @override
  Future<Either<Failure, HistoricalCurrencyResponseEntity>> call(
      HistoricalCurrencyParams params) async {
    return await repository.getHistoricalCurrencyData(params);
  }
}
