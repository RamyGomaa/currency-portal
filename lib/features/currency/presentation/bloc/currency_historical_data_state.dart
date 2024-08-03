part of 'currency_historical_data_bloc.dart';

sealed class CurrencyHistoricalDataState extends Equatable {
  const CurrencyHistoricalDataState();

  @override
  List<Object> get props => [];
}

final class CurrencyHistoricalDataInitial extends CurrencyHistoricalDataState {}

final class CurrencyHistoricalDataLoading extends CurrencyHistoricalDataState {}

final class CurrencyHistoricalDataLoaded extends CurrencyHistoricalDataState {
  final HistoricalCurrencyResponseEntity historicalData;

  const CurrencyHistoricalDataLoaded({
    required this.historicalData,
  });

  @override
  List<Object> get props => [historicalData];
}

final class CurrencyHistoricalDataError extends CurrencyHistoricalDataState {
  final String message;

  const CurrencyHistoricalDataError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
