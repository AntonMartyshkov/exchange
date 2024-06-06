import 'package:exchange/packages/data/currency/currency_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_dto.g.dart';

@JsonSerializable()
class CurrencyDTO {
  late final String name;
  late final double value;
  CurrencyDTO({
    required this.name,
    required this.value,
  });

  CurrencyDTO copyWith({
    String? name,
    double? value,
  }) {
    return CurrencyDTO(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  factory CurrencyDTO.fromJson(Map<String, dynamic> json) => _$CurrencyDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyDTOToJson(this);

  CurrencyModel toModel() {
    return CurrencyModel(
      name: name,
      value: value,
    );
  }
}
