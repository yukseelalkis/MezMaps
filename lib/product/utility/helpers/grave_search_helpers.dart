import 'package:mezmaps/product/mock/model/grave_result.dart';
import 'package:mezmaps/feature/grave_search/view_model/state/grave_search_state.dart';

/// ---------------------------
///  Normalize yardımcıları
/// ---------------------------

String _normalizeTR(String v) => v
    .trim()
    .toLowerCase()
    .replaceAll('ı', 'i')
    .replaceAll('ğ', 'g')
    .replaceAll('ü', 'u')
    .replaceAll('ş', 's')
    .replaceAll('ö', 'o')
    .replaceAll('ç', 'c');

/// Nullable güvenli normalize (null -> '')
String _n(String? v) => _normalizeTR(v ?? '');

/// ---------------------------
///  Filtre modeli
/// ---------------------------

typedef GraveFilters = ({
  String nameQ,
  String surnameQ,
  String? cityN,
  String? districtN,
  String? cemeteryN,
});

/// This function `buildFilters` takes a `GraveSearchState` object as a parameter and returns a
/// `GraveFilters` object. Inside the function, it extracts relevant information from the `state` object
/// to build the filters for searching graves.
GraveFilters buildFilters(GraveSearchState state) => (
  nameQ: _n(state.nameCtrl.text),
  surnameQ: _n(state.surnameCtrl.text),
  cityN: state.selectedProvince,
  districtN: state.selectedDistrict,
  cemeteryN: state.selectedCemetery,
);

/// ---------------------------
///  Eşleşme & Sıralama
/// ---------------------------

/// The `matches` function in Dart compares the properties of a `GraveResult` object with the filters
/// specified in a `GraveFilters` object to determine if they match.
/// 
/// Args:
///   e (GraveResult): The `e` parameter in the `matches` function represents a `GraveResult` object,
/// which likely contains information about a grave such as the name, surname, city, district, and
/// cemetery associated with it.
///   f (GraveFilters): The `f` parameter in the `matches` function represents the `GraveFilters`
/// object, which contains filter criteria for graves. It includes properties such as `cityN`,
/// `districtN`, `cemeteryN`, `nameQ`, and `surnameQ` that are used to filter grave
/// 
/// Returns:
///   The `matches` function returns a boolean value indicating whether a given `GraveResult` object `e`
/// matches the specified `GraveFilters` object `f` based on certain criteria related to name, surname,
/// city, district, and cemetery. The function checks if the normalized values of the attributes of `e`
/// (name, surname, city, district, cemetery) match the normalized query
bool matches(GraveResult e, GraveFilters f) {
  final name = _n(e.name);
  final surname = _n(e.surname);
  final city = _n(e.city);
  final district = _n(e.district);
  final cemetery = _n(e.cemeteriesName);

  // Sorgu değerlerini (nullable olanlar) tek yerde normalize et
  final qCity = _n(f.cityN);
  final qDistrict = _n(f.districtN);
  final qCemetery = _n(f.cemeteryN);

  final nameOk = f.nameQ.isEmpty || name.contains(f.nameQ);
  final surnameOk = f.surnameQ.isEmpty || surname.contains(f.surnameQ);
  final cityOk = f.cityN == null || city == qCity;
  final districtOk = f.districtN == null || district == qDistrict;
  final cemeteryOk = f.cemeteryN == null || cemetery == qCemetery;

  return nameOk && surnameOk && cityOk && districtOk && cemeteryOk;
}

/// This Dart function compares two GraveResult objects based on specified GraveFilters criteria and
/// returns the result.
/// 
/// Args:
///   a (GraveResult): GraveResult a: This parameter represents the first GraveResult object for
/// comparison. It contains information about a grave, such as the name and surname of the deceased
/// person.
///   b (GraveResult): The `compareResults` function takes in two `GraveResult` objects `a` and `b`, as
/// well as `GraveFilters` object `f`, and compares them based on certain criteria. The function
/// calculates a score for each `GraveResult` object based on the filters provided
///   f (GraveFilters): GraveFilters f is an object containing filters for comparing GraveResult
/// objects. It includes fields like nameQ and surnameQ which are used to filter and score the
/// GraveResult objects based on their name and surname properties.
/// 
/// Returns:
///   The `compareResults` function is returning the result of the comparison between GraveResult `a`
/// and GraveResult `b` based on the scoring logic defined in the `score` function. The comparison is
/// done first based on the scores calculated for each result using the `score` function, and if the
/// scores are equal, then it falls back to comparing the names of the results (`a.name.compareTo
int compareResults(GraveResult a, GraveResult b, GraveFilters f) {
  int score(GraveResult x) {
    final nm = _n(x.name);
    final sn = _n(x.surname);
    int sc = 0;
    if (f.nameQ.isNotEmpty && nm.startsWith(f.nameQ)) sc += 2;
    if (f.surnameQ.isNotEmpty && sn.startsWith(f.surnameQ)) sc += 1;
    return -sc; // küçük skor daha önde
  }

  final c = score(a).compareTo(score(b));
  if (c != 0) return c;
  return a.name.compareTo(b.name);
}
