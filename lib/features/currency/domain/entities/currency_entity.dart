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
  String? imageUrl;
  String? base64Image;
  get hasImageUrl => imageUrl != null || base64Image != null;
  CurrencyResponseDataEntity({
    this.currencyCode,
    this.currencyName,
    this.imageUrl,
  });
}
