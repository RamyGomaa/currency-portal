import 'package:bloc/bloc.dart';
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart';
import 'package:currency_converter/features/currency/domain/usecases/convert_currency_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/currrency_convert_entity.dart';

part 'currency_conversion_event.dart';
part 'currency_conversion_state.dart';

class CurrencyConversionBloc
    extends Bloc<CurrencyConversionEvent, CurrencyConversionState> {
  ConvertCurrencyUsecase usecase;
  CurrencyConversionBloc(
    this.usecase,
  ) : super(CurrencyConversionInitial()) {
    on<CurrencyConversionEvent>((event, emit) async {
      if (event is ConvertCurrencyEvent) {
        emit(CurrencyConversionLoading());
        final res = await usecase(
          ConvertCurrencyParams(
            amount: event.amount,
            fromCurrency: event.fromCurrency,
            toCurrency: event.toCurrency,
          ),
        );
        res.fold(
          (l) => emit(CurrencyConversionError(message: l.message)),
          (r) => emit(CurrencyConversionLoaded(result: r)),
        );
      }
    });
  }
}
