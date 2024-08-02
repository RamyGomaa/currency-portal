abstract class HistoricalCurrencyResponseEntity {
  final bool? success;
  final String? base;
  final DateTime? startDate;
  final DateTime? endDate;
  List<HistoricalCurrencyRateEntity>? rates;

  HistoricalCurrencyResponseEntity({
    this.success,
    this.base,
    this.startDate,
    this.endDate,
    this.rates,
  });
}

abstract class HistoricalCurrencyRateEntity {
  final String? date;
  final Map<String, double>? elements;
  HistoricalCurrencyRateEntity({
    this.date,
    this.elements,
  });
}
