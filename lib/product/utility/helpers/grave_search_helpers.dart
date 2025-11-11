import 'package:common/common.dart';
import 'package:mezmaps/feature/grave_search/view_model/state/grave_search_state.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';

typedef GraveFilters = ({
  String nameQ,
  String surnameQ,
  String? cityN,
  String? districtN,
  String? cemeteryN,
});

GraveFilters buildFilters(GraveSearchState state) => (
  nameQ: state.nameCtrl.text.norm(),
  surnameQ: state.surnameCtrl.text.norm(),
  cityN: state.selectedProvince.normOrNull(),
  districtN: state.selectedDistrict.normOrNull(),
  cemeteryN: state.selectedCemetery.normOrNull(),
);

bool matches(GraveResult e, GraveFilters f) {
  final nameNorm = e.name.norm();
  final surnameNorm = e.surname.norm();
  final cityNorm = e.city.norm();
  final districtNorm = e.district.norm();
  final cemNameNorm = e.cemeteriesName.norm();

  final matchName = f.nameQ.isEmpty || nameNorm.contains(f.nameQ);
  final matchSurname = f.surnameQ.isEmpty || surnameNorm.contains(f.surnameQ);
  final matchCity = f.cityN == null || cityNorm == f.cityN;
  final matchDistrict = f.districtN == null || districtNorm == f.districtN;
  final matchCemetery = f.cemeteryN == null || cemNameNorm == f.cemeteryN;

  return matchName &&
      matchSurname &&
      matchCity &&
      matchDistrict &&
      matchCemetery;
}

int scoreFor(GraveResult r, GraveFilters f) {
  int sc = 0;
  if (f.cityN != null && r.city.norm() == f.cityN) sc += 3;
  if (f.districtN != null && r.district.norm() == f.districtN) sc += 3;
  if (f.cemeteryN != null && r.cemeteriesName.norm() == f.cemeteryN) sc += 4;
  return sc;
}

int compareResults(GraveResult a, GraveResult b, GraveFilters f) {
  final sa = scoreFor(a, f);
  final sb = scoreFor(b, f);
  if (sa != sb) return sb.compareTo(sa);
  final sComp = a.surname.norm().compareTo(b.surname.norm());
  if (sComp != 0) return sComp;
  return a.name.norm().compareTo(b.name.norm());
}
