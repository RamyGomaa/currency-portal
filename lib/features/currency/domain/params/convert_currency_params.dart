import 'package:json_annotation/json_annotation.dart';
part 'convert_currency_params.g.dart';

@JsonSerializable()
class ConvertCurrencyParams {
  @JsonKey(name: 'api_key')
  String? apiKey;
  @JsonKey(name: 'from')
  final String fromCurrency;
  @JsonKey(name: 'to')
  final String toCurrency;
  final double amount;
  String? date;

  ConvertCurrencyParams({
    this.apiKey,
    this.date,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  factory ConvertCurrencyParams.fromJson(Map<String, dynamic> json) =>
      _$ConvertCurrencyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ConvertCurrencyParamsToJson(this);
}
