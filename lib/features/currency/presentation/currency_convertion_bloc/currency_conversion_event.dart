part of 'currency_conversion_bloc.dart';

sealed class CurrencyConversionEvent extends Equatable {
  const CurrencyConversionEvent();

  @override
  List<Object> get props => [];
}

class ConvertCurrencyEvent extends CurrencyConversionEvent {
  final double amount;
  final String fromCurrency;
  final String toCurrency;

  const ConvertCurrencyEvent({
    required this.amount,
    required this.fromCurrency,
    required this.toCurrency,
  });

  @override
  List<Object> get props => [amount, fromCurrency, toCurrency];
}
