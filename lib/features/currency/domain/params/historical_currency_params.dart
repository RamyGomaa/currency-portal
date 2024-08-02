class HistoricalCurrencyParams {
  final String base;
  final List<String> currencies;
  final DateTime startDate;
  final String? stringfyStartDate; //2024-07-25
  final DateTime endDate;
  final String? stringfyEndDate; //2024-07-25

  HistoricalCurrencyParams({
    required this.base,
    required this.currencies,
    required this.startDate,
    this.stringfyStartDate,
    required this.endDate,
    this.stringfyEndDate,
  });
}
