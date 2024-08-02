// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_convert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyConvertResponseModel _$CurrencyConvertResponseModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyConvertResponseModel(
      success: json['success'] as bool,
      query: CurrencyConvertQueryModel.fromJson(
          json['query'] as Map<String, dynamic>),
      info: CurrencyConvertInfoModel.fromJson(
          json['info'] as Map<String, dynamic>),
      result: (json['result'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyConvertResponseModelToJson(
        CurrencyConvertResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
      'query': instance.query,
      'info': instance.info,
    };
