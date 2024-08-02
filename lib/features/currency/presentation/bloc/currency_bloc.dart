import 'package:bloc/bloc.dart';
import 'package:currency_converter/core/flavor/flavor_config.dart';
import 'package:currency_converter/features/currency/domain/usecases/convert_currency_usecase.dart';
import 'package:currency_converter/features/currency/domain/usecases/get_currency_list_usecase.dart';
import 'package:currency_converter/features/currency/domain/usecases/get_historical_currency.dart';
import 'package:currency_converter/shared/domain/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/currrency_convert_entity.dart';
import '../../domain/params/convert_currency_params.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  GetCurrencyListUsecase getCurrencyListUsecase;
  GetHistoricalCurrencyUseCase getHistoricalCurrencyUseCase;
  ConvertCurrencyUsecase convertCurrencyUsecase;
  CurrencyBloc(
    this.getCurrencyListUsecase,
    this.getHistoricalCurrencyUseCase,
    this.convertCurrencyUsecase,
  ) : super(CurrencyInitial()) {
    on<CurrencyEvent>((event, emit) async {
      if (event is GetCurrencyListEvent) {
        emit(CurrencyLoading());
        var res = await getCurrencyListUsecase(NoParams());
        res.fold(
          (l) => emit(CurrencyError(message: l.message)),
          (r) => emit(CurrencyLoaded(currenyData: r)),
        );
      }
      // if (event is ConvertCurrencyEvent) {
      //   emit(CurrencyLoading());
      //   var res = await convertCurrencyUsecase(ConvertCurrencyParams(
      //     fromCurrency: event.params.fromCurrency,
      //     toCurrency: event.params.toCurrency,
      //     amount: event.params.amount,
      //     apiKey: FlavorConfig.instance.currencyApiKey,
      //     //2024-01-01
      //     date: DateTime.now().toIso8601String().substring(0, 10),
      //   ));
      //   res.fold(
      //     (l) => emit(CurrencyError(message: l.message)),
      //     (r) => emit(CurrencyLoaded(convertResponse: r)),
      //   );
      // }
    });
  }
}
