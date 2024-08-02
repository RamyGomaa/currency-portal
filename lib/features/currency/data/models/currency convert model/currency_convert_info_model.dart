import '../../../domain/entities/currrency_convert_entity.dart';
import "package:json_annotation/json_annotation.dart";

part 'currency_convert_info_model.g.dart';

@JsonSerializable()
class CurrencyConvertInfoModel extends CurrencyConvertInfoEntity {
  CurrencyConvertInfoModel({
    required super.timestamp,
    required super.quote,
  });
  factory CurrencyConvertInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConvertInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyConvertInfoModelToJson(this);
}
