// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_currency_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalCurrencyParams _$HistoricalCurrencyParamsFromJson(
        Map<String, dynamic> json) =>
    HistoricalCurrencyParams(
      apiKey: json['api_key'] as String,
      base: json['base'] as String,
      currencies: json['currencies'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
    );

Map<String, dynamic> _$HistoricalCurrencyParamsToJson(
        HistoricalCurrencyParams instance) =>
    <String, dynamic>{
      'api_key': instance.apiKey,
      'base': instance.base,
      'currencies': instance.currencies,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
