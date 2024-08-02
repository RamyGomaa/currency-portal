abstract class CurrencyResponseEntity {
  final bool? success;
  final List<CurrencyResponseDataEntity>? symbols;

  CurrencyResponseEntity({
    this.success,
    this.symbols,
  });
}

abstract class CurrencyResponseDataEntity {
  final String? currencyCode;
  final String? currencyName;
  final String? imageUrl;

  CurrencyResponseDataEntity({
    this.currencyCode,
    this.currencyName,
    this.imageUrl,
  });
}
