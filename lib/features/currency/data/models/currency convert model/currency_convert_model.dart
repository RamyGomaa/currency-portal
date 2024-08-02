import 'package:currency_converter/core/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/currrency_convert_entity.dart';
part 'currency_convert_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveAdapter.currencyConvertion)
class CurrencyConvertResponseModel extends CurrencyConvertResponseEntity {
  @override
  @HiveField(0)
  final bool success;
  @override
  @HiveField(1)
  final CurrencyConvertQueryModel query;
  @override
  @HiveField(2)
  final CurrencyConvertInfoModel info;
  @override
  @HiveField(3)
  final double result;
  CurrencyConvertResponseModel({
    required this.success,
    required this.query,
    required this.info,
    required this.result,
  });

  factory CurrencyConvertResponseModel.fromJson(Map<String, dynamic> json) {
    print("CurrencyConvertResponseModel ${json}");
    return _$CurrencyConvertResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CurrencyConvertResponseModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: HiveAdapter.currencyConvertionInfo)
class CurrencyConvertInfoModel extends CurrencyConvertInfoEntity {
  @override
  @HiveField(0)
  final int timestamp;
  @override
  @HiveField(1)
  final double quote;

  CurrencyConvertInfoModel({
    required this.timestamp,
    required this.quote,
  });
  factory CurrencyConvertInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConvertInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyConvertInfoModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: HiveAdapter.currencyConvertQueryModel)
class CurrencyConvertQueryModel extends CurrencyConvertQueryEntity {
  @override
  @HiveField(0)
  final String from;
  @override
  @HiveField(1)
  final String to;
  @override
  @HiveField(2)
  final num amount;
  CurrencyConvertQueryModel({
    required this.from,
    required this.to,
    required this.amount,
  });
  //fomr json

  factory CurrencyConvertQueryModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConvertQueryModelFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CurrencyConvertQueryModelToJson(this);
}
