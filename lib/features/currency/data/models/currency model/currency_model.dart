//import json serializer
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/currency_entity.dart';
part 'currency_model.g.dart';

@JsonSerializable()
class CurrencyResponseModel extends CurrencyResponseEntity {
  @override
  final bool success;
  @override
  final Map<String, String> symbols;
  CurrencyResponseModel({
    required this.success,
    required this.symbols,
  });

  //from json

  factory CurrencyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyResponseModelFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CurrencyResponseModelToJson(this);
}
