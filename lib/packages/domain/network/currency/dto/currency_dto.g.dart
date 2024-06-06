// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyDTO _$CurrencyDTOFromJson(Map<String, dynamic> json) => CurrencyDTO(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyDTOToJson(CurrencyDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };
