import '../../../domain/entities/historical_currency_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'historical_currency_rate_model.g.dart';

@JsonSerializable()
class HistoricalCurrencyRateModel extends HistoricalCurrencyRateEntity {
  HistoricalCurrencyRateModel({
    required super.date,
    required super.elements,
  });
  factory HistoricalCurrencyRateModel.fromJson(Map<String, dynamic> json) =>
      _$HistoricalCurrencyRateModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalCurrencyRateModelToJson(this);
}
