// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalCurrencyResponseModel _$HistoricalCurrencyResponseModelFromJson(
        Map<String, dynamic> json) =>
    HistoricalCurrencyResponseModel(
      success: json['success'] as bool?,
      base: json['base'] as String?,
      rates: (json['rates'] as List<dynamic>)
          .map((e) =>
              HistoricalCurrencyRateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$HistoricalCurrencyResponseModelToJson(
        HistoricalCurrencyResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'base': instance.base,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'rates': instance.rates,
    };
