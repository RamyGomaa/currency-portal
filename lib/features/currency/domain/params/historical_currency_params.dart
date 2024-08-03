import 'package:json_annotation/json_annotation.dart';
part 'historical_currency_params.g.dart';

@JsonSerializable()
class HistoricalCurrencyParams {
  @JsonKey(name: 'api_key')
  String? apiKey;
  final String? base;
  final String currencies;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;

  HistoricalCurrencyParams({
    this.apiKey,
    required this.base,
    required this.currencies,
    this.startDate,
    this.endDate,
  });

  factory HistoricalCurrencyParams.fromJson(Map<String, dynamic> json) =>
      _$HistoricalCurrencyParamsFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalCurrencyParamsToJson(this);
}
