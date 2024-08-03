import 'package:currency_converter/core/constants/hive_constants.dart';
import 'package:currency_converter/features/currency/data/models/historical%20currency%20model/historical_currency_rate_model.dart';
import 'package:hive/hive.dart';

import '../../../domain/entities/historical_currency_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'historical_currency_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveAdapter.historicalCurrencyResponseModel)
class HistoricalCurrencyResponseModel extends HistoricalCurrencyResponseEntity {
  @HiveField(0)
  final bool success;
  @HiveField(1)
  final String base;
  @HiveField(2)
  @JsonKey(name: 'start_date')
  final String startDate;
  @HiveField(3)
  @JsonKey(name: 'end_date')
  final String endDate;
  @HiveField(4)
  final Map<String, Map<String, double>> rates;

  const HistoricalCurrencyResponseModel({
    required this.success,
    required this.base,
    required this.startDate,
    required this.endDate,
    required this.rates,
  });
  factory HistoricalCurrencyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HistoricalCurrencyResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$HistoricalCurrencyResponseModelToJson(this);

  @override
  List<Object?> get props => [success, base, startDate, endDate, rates];
}
