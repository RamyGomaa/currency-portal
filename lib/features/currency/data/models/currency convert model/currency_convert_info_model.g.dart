// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_convert_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyConvertInfoModel _$CurrencyConvertInfoModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyConvertInfoModel(
      timestamp: (json['timestamp'] as num).toInt(),
      quote: (json['quote'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyConvertInfoModelToJson(
        CurrencyConvertInfoModel instance) =>
    <String, dynamic>{
      'quote': instance.quote,
      'timestamp': instance.timestamp,
    };
