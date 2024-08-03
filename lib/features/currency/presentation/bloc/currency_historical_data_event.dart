part of 'currency_historical_data_bloc.dart';

sealed class CurrencyHistoricalDataEvent extends Equatable {
  const CurrencyHistoricalDataEvent();

  @override
  List<Object> get props => [];
}

class GetHistoricalDataEvent extends CurrencyHistoricalDataEvent {
  final String targetCurrency;
  final String base;

  const GetHistoricalDataEvent({
    required this.targetCurrency,
    required this.base,
  });

  @override
  List<Object> get props => [
        targetCurrency,
        base,
      ];
}
