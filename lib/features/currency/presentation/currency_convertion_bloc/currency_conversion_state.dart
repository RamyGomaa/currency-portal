part of 'currency_conversion_bloc.dart';

sealed class CurrencyConversionState extends Equatable {
  const CurrencyConversionState();

  @override
  List<Object> get props => [];
}

final class CurrencyConversionInitial extends CurrencyConversionState {}

final class CurrencyConversionLoading extends CurrencyConversionState {}

final class CurrencyConversionLoaded extends CurrencyConversionState {
  final CurrencyConvertResponseEntity result;

  const CurrencyConversionLoaded({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

final class CurrencyConversionError extends CurrencyConversionState {
  final String message;

  const CurrencyConversionError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
