// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_convert_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyConvertResponseModelAdapter
    extends TypeAdapter<CurrencyConvertResponseModel> {
  @override
  final int typeId = 1;

  @override
  CurrencyConvertResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyConvertResponseModel(
      success: fields[0] as bool,
      query: fields[1] as CurrencyConvertQueryModel,
      info: fields[2] as CurrencyConvertInfoModel,
      result: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyConvertResponseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.query)
      ..writeByte(2)
      ..write(obj.info)
      ..writeByte(3)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyConvertResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CurrencyConvertInfoModelAdapter
    extends TypeAdapter<CurrencyConvertInfoModel> {
  @override
  final int typeId = 2;

  @override
  CurrencyConvertInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyConvertInfoModel(
      timestamp: fields[0] as int,
      quote: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyConvertInfoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.quote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyConvertInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CurrencyConvertQueryModelAdapter
    extends TypeAdapter<CurrencyConvertQueryModel> {
  @override
  final int typeId = 3;

  @override
  CurrencyConvertQueryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyConvertQueryModel(
      from: fields[0] as String,
      to: fields[1] as String,
      amount: fields[2] as num,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyConvertQueryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.to)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyConvertQueryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      'query': instance.query,
      'info': instance.info,
      'result': instance.result,
    };

CurrencyConvertInfoModel _$CurrencyConvertInfoModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyConvertInfoModel(
      timestamp: (json['timestamp'] as num).toInt(),
      quote: (json['quote'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyConvertInfoModelToJson(
        CurrencyConvertInfoModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'quote': instance.quote,
    };

CurrencyConvertQueryModel _$CurrencyConvertQueryModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyConvertQueryModel(
      from: json['from'] as String,
      to: json['to'] as String,
      amount: json['amount'] as num,
    );

Map<String, dynamic> _$CurrencyConvertQueryModelToJson(
        CurrencyConvertQueryModel instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
    };
