abstract class CurrencyConvertResponseEntity {
  final bool? success;
  final CurrencyConvertQueryEntity? query;
  final CurrencyConvertInfoEntity? info;
  final double? result;

  CurrencyConvertResponseEntity({
    this.success,
    this.query,
    this.info,
    this.result,
  });
}

abstract class CurrencyConvertInfoEntity {
  final double? quote;
  final int? timestamp;

  CurrencyConvertInfoEntity({
    this.quote,
    this.timestamp,
  });
}

abstract class CurrencyConvertQueryEntity {
  final String? from;
  final String? to;
  final num? amount;

  CurrencyConvertQueryEntity({
    this.from,
    this.to,
    this.amount,
  });
}
