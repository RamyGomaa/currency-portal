abstract class CurrencyConvertResponseEntity {
  final bool success;
  final CurrencyConvertQueryEntity? query;
  final CurrencyConvertInfoEntity? info;
  final double result;

  CurrencyConvertResponseEntity({
    required this.success,
    this.query,
    this.info,
    required this.result,
  });
}

abstract class CurrencyConvertInfoEntity {
  final double quote;
  final int timestamp;

  CurrencyConvertInfoEntity({
    required this.quote,
    required this.timestamp,
  });
}

abstract class CurrencyConvertQueryEntity {
  final String from;
  final String to;
  final int amount;

  CurrencyConvertQueryEntity({
    required this.from,
    required this.to,
    required this.amount,
  });
}
