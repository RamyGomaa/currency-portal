import 'package:equatable/equatable.dart';

abstract class HistoricalCurrencyResponseEntity extends Equatable {
  final bool? success;
  final String? base;
  final String? startDate;
  final String? endDate;
  final Map<String, Map<String, double>>? rates;

  const HistoricalCurrencyResponseEntity({
    this.success,
    this.base,
    this.startDate,
    this.endDate,
    this.rates,
  });

  @override
  String toString() {
    return 'HistoricalCurrencyResponseEntity(success: $success, base: $base, startDate: $startDate, endDate: $endDate, rates: $rates)';
  }
}

abstract class HistoricalCurrencyRateEntity {
  final Map<String, double>? elements;
  HistoricalCurrencyRateEntity({
    this.elements,
  });

  @override
  String toString() {
    return 'HistoricalCurrencyRateEntity( elements: $elements)';
  }
}
