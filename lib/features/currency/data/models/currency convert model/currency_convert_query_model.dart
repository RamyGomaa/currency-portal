import '../../../domain/entities/currrency_convert_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'currency_convert_query_model.g.dart';

@JsonSerializable()
class CurrencyConvertQueryModel extends CurrencyConvertQueryEntity {
  CurrencyConvertQueryModel({
    required super.from,
    required super.to,
    required super.amount,
  });
  //fomr json

  factory CurrencyConvertQueryModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConvertQueryModelFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CurrencyConvertQueryModelToJson(this);
}
