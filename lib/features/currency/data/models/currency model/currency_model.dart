//import json serializer
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/constants/hive_constants.dart';
import '../../../domain/entities/currency_entity.dart';
part 'currency_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveAdapter.currencyResponseModel)
class CurrencyResponseModel extends CurrencyResponseEntity {
  @override
  @HiveField(0)
  final bool success;
  @override
  @HiveField(1)
  final List<CurrencyResponseDataModel> symbols;
  CurrencyResponseModel({
    required this.success,
    required this.symbols,
  });

  //from json

  factory CurrencyResponseModel.fromJson(Map<String, dynamic> json) {
    print("We are calling from json method in currency model");
    Logger().i('We are calling from json method in currency model');
    print("Sucess is ${json['success']}");
    print("Symbols is ${json['symbols']}");

    //from map to list
    var list = json['symbols'] as Map<String, dynamic>;
    var symbols = list.entries
        .map((e) => CurrencyResponseDataModel(
              currencyCode: e.key,
              currencyName: e.value,
            ))
        .toList();
    var x = CurrencyResponseModel(
      success: json['success'],
      symbols: symbols,
    );

    Logger().i('We are calling from json method in currency model $x');
    return x;
  }

  //to json
  Map<String, dynamic> toJson() => _$CurrencyResponseModelToJson(this);

  //tostring
  @override
  String toString() {
    return 'CurrencyResponseModel{success: $success, symbols: $symbols}';
  }
}

@JsonSerializable()
@HiveType(typeId: HiveAdapter.currencyResponseDataModel)
class CurrencyResponseDataModel extends CurrencyResponseDataEntity {
  @override
  @HiveField(0)
  final String currencyCode;

  @override
  @HiveField(1)
  final String currencyName;

  CurrencyResponseDataModel({
    required this.currencyCode,
    required this.currencyName,
  });

  //from json
  factory CurrencyResponseDataModel.fromJson(Map<String, dynamic> json) {
    return CurrencyResponseDataModel(
      currencyCode: json.keys.first,
      currencyName: json.values.first,
    );
  }

  //to json
  Map<String, dynamic> toJson() => _$CurrencyResponseDataModelToJson(this);
}
