import 'package:json_annotation/json_annotation.dart';
part 'historical_currency_params.g.dart';

@JsonSerializable()
class HistoricalCurrencyParams {
  @JsonKey(name: 'api_key')
  final String apiKey;
  final String base;
  final String currencies;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;

  HistoricalCurrencyParams({
    required this.apiKey,
    required this.base,
    required this.currencies,
    required this.startDate,
    required this.endDate,
  });

  factory HistoricalCurrencyParams.fromJson(Map<String, dynamic> json) =>
      _$HistoricalCurrencyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalCurrencyParamsToJson(this);
}
