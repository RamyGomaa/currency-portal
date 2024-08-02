part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class GetCurrencyListEvent extends CurrencyEvent {}

class ConvertCurrencyEvent extends CurrencyEvent {
  final ConvertCurrencyParams params;

  const ConvertCurrencyEvent({required this.params});

  @override
  List<Object> get props => [params];
}
