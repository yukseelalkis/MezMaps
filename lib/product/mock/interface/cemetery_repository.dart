import 'package:mezmaps/product/mock/model/mock_model.dart';

abstract class ICemeteryRepository {
  Future<List<Province>> getProvinces();
  Future<List<District>> getDistricts(String province);
  Future<List<Cemetery>> getCemeteries(String province, String district);
}
