import 'package:currency_converter/features/currency/data/models/historical%20currency%20model/historical_currency_rate_model.dart';

import '../../../domain/entities/historical_currency_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'historical_currency_model.g.dart';

@JsonSerializable()
class HistoricalCurrencyResponseModel extends HistoricalCurrencyResponseEntity {
  final List<HistoricalCurrencyRateModel> rates;
  HistoricalCurrencyResponseModel({
    required super.success,
    required super.base,
    required this.rates,
    required super.startDate,
    required super.endDate,
  });
  factory HistoricalCurrencyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HistoricalCurrencyResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$HistoricalCurrencyResponseModelToJson(this);
}
