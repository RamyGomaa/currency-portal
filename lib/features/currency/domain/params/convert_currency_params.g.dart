// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_currency_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertCurrencyParams _$ConvertCurrencyParamsFromJson(
        Map<String, dynamic> json) =>
    ConvertCurrencyParams(
      apiKey: json['api_key'] as String,
      date: json['date'] as String,
      fromCurrency: json['from'] as String,
      toCurrency: json['to'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$ConvertCurrencyParamsToJson(
        ConvertCurrencyParams instance) =>
    <String, dynamic>{
      'api_key': instance.apiKey,
      'from': instance.fromCurrency,
      'to': instance.toCurrency,
      'amount': instance.amount,
      'date': instance.date,
    };
