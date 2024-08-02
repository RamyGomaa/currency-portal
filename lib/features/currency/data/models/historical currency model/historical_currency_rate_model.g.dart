// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_currency_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalCurrencyRateModel _$HistoricalCurrencyRateModelFromJson(
        Map<String, dynamic> json) =>
    HistoricalCurrencyRateModel(
      date: json['date'] as String?,
      elements: (json['elements'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$HistoricalCurrencyRateModelToJson(
        HistoricalCurrencyRateModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'elements': instance.elements,
    };
