import 'package:mezmaps/product/mock/data/cemetries_data.dart';
import 'package:mezmaps/product/mock/interface/cemetery_repository.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';

class MockCemeteryRepository implements ICemeteryRepository {
  const MockCemeteryRepository();

  @override
  Future<List<Province>> getProvinces() async {
    return provincesMock;
  }

  @override
  Future<List<District>> getDistricts(String province) async {
    final p = provincesMock.firstWhere((e) => e.name == province);
    return p.districts;
  }

  @override
  Future<List<Cemetery>> getCemeteries(String province, String district) async {
    final p = provincesMock.firstWhere((e) => e.name == province);
    final d = p.districts.firstWhere((e) => e.name == district);
    return d.cemeteries;
  }
}
