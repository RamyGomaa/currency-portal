// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyResponseModel _$CurrencyResponseModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyResponseModel(
      success: json['success'] as bool,
      symbols: Map<String, String>.from(json['symbols'] as Map),
    );

Map<String, dynamic> _$CurrencyResponseModelToJson(
        CurrencyResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'symbols': instance.symbols,
    };
