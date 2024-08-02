import 'package:currency_converter/features/currency/data/models/currency%20convert%20model/currency_convert_query_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/currrency_convert_entity.dart';
import 'currency_convert_info_model.dart';
part 'currency_convert_model.g.dart';

@JsonSerializable()
class CurrencyConvertResponseModel extends CurrencyConvertResponseEntity {
  final CurrencyConvertQueryModel query;
  final CurrencyConvertInfoModel info;
  CurrencyConvertResponseModel({
    required super.success,
    required this.query,
    required this.info,
    required super.result,
  });

  factory CurrencyConvertResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConvertResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyConvertResponseModelToJson(this);
}
