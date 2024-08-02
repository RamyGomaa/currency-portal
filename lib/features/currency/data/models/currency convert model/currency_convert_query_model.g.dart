// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_convert_query_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyConvertQueryModel _$CurrencyConvertQueryModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyConvertQueryModel(
      from: json['from'] as String,
      to: json['to'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$CurrencyConvertQueryModelToJson(
        CurrencyConvertQueryModel instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
    };
