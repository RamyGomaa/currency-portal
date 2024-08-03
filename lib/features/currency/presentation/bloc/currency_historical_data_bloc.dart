import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart';
import 'package:currency_converter/features/currency/domain/usecases/get_historical_currency.dart';
import 'package:equatable/equatable.dart';

import '../../domain/params/historical_currency_params.dart';

part 'currency_historical_data_event.dart';
part 'currency_historical_data_state.dart';

class CurrencyHistoricalDataBloc
    extends Bloc<CurrencyHistoricalDataEvent, CurrencyHistoricalDataState> {
  final GetHistoricalCurrencyUseCase getHistoricalCurrencyUseCase;
  CurrencyHistoricalDataBloc(this.getHistoricalCurrencyUseCase)
      : super(CurrencyHistoricalDataInitial()) {
    on<CurrencyHistoricalDataEvent>((event, emit) async {
      if (event is GetHistoricalDataEvent) {
        emit(CurrencyHistoricalDataLoading());
        var res = await getHistoricalCurrencyUseCase(HistoricalCurrencyParams(
          currencies: event.targetCurrency,
          base: event.base,
        ));
        res.fold(
          (l) => emit(CurrencyHistoricalDataError(message: l.message)),
          (r) => emit(CurrencyHistoricalDataLoaded(historicalData: r)),
        );
      }
    });
  }
}
