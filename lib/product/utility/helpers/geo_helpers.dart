// lib/feature/grave_search/domain/geo_helpers.dart
import 'package:mezmaps/product/mock/model/mock_model.dart'; 
// Province/District/Cemetery modellerin neredeyse onu import et

List<String> districtsOf(String province, List<Province> provinces) =>
    provinces
        .where((p) => p.name == province)
        .expand((p) => p.districts)
        .map((d) => d.name)
        .toList()
      ..sort();

List<String> cemeteriesOf({
  required String province,
  required String district,
  required List<Province> provinces,
}) =>
    provinces
        .where((p) => p.name == province)
        .expand((p) => p.districts)
        .where((d) => d.name == district)
        .expand((d) => d.cemeteries)
        .map((c) => c.name)
        .toList()
      ..sort();
