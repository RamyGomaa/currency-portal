// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyResponseModelAdapter extends TypeAdapter<CurrencyResponseModel> {
  @override
  final int typeId = 4;

  @override
  CurrencyResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyResponseModel(
      success: fields[0] as bool,
      symbols: (fields[1] as List).cast<CurrencyResponseDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.symbols);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CurrencyResponseDataModelAdapter
    extends TypeAdapter<CurrencyResponseDataModel> {
  @override
  final int typeId = 5;

  @override
  CurrencyResponseDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyResponseDataModel(
      currencyCode: fields[0] as String,
      currencyName: fields[1] as String,
      imageUrl: fields[2] as String?,
      base64Image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyResponseDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.currencyCode)
      ..writeByte(1)
      ..write(obj.currencyName)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.base64Image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyResponseDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyResponseModel _$CurrencyResponseModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyResponseModel(
      success: json['success'] as bool,
      symbols: (json['symbols'] as List<dynamic>)
          .map((e) =>
              CurrencyResponseDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrencyResponseModelToJson(
        CurrencyResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'symbols': instance.symbols,
    };

CurrencyResponseDataModel _$CurrencyResponseDataModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyResponseDataModel(
      currencyCode: json['currencyCode'] as String,
      currencyName: json['currencyName'] as String,
      imageUrl: json['imageUrl'] as String?,
      base64Image: json['base64Image'] as String?,
    );

Map<String, dynamic> _$CurrencyResponseDataModelToJson(
        CurrencyResponseDataModel instance) =>
    <String, dynamic>{
      'currencyCode': instance.currencyCode,
      'currencyName': instance.currencyName,
      'imageUrl': instance.imageUrl,
      'base64Image': instance.base64Image,
    };
