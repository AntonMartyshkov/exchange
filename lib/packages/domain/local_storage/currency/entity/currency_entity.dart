import 'package:exchange/packages/data/currency/currency_model.dart';
import 'package:isar/isar.dart';

part 'currency_entity.g.dart';

@collection
class CurrencyEntity {
  Id id = Isar.autoIncrement;

  late final String name;
  late final double value;

  CurrencyModel toModel() {
    return CurrencyModel(
      name: name,
      value: value,
    );
  }

  CurrencyEntity fromModel(CurrencyModel model) {
    return CurrencyEntity()
      ..name = model.name
      ..value = model.value;
  }
}
