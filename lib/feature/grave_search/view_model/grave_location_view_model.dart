// // lib/feature/grave_search/view_model/grave_search_view_model.dart

// import 'package:common/common.dart'; // TrNorm extension buradan geliyor
// import 'package:mezmaps/feature/grave_search/view_model/state/grave_location_state.dart';
// import 'package:mezmaps/product/mock/data/mock_cemetries_data.dart';
// import 'package:mezmaps/product/mock/data/mock_grave_result.dart';
// import 'package:mezmaps/product/mock/model/grave_result.dart';
// import 'package:mezmaps/product/state/base/base_cubit.dart';

// /// ========================== TOP-LEVEL YARDIMCILAR ==========================

// /// Named record alias (Dart 3)
// typedef GraveFilters = ({
//   String nameQ,
//   String surnameQ,
//   String? cityN,
//   String? districtN,
//   String? cemeteryN,
// });

// /// State → filtre snapshot (call sırasında sabit)
// GraveFilters buildFilters(GraveSearchState state) => (
//   nameQ: state.nameCtrl.text.norm(),
//   surnameQ: state.surnameCtrl.text.norm(),
//   cityN: state.selectedProvince.normOrNull(),
//   districtN: state.selectedDistrict.normOrNull(),
//   cemeteryN: state.selectedCemetery.normOrNull(),
// );

// /// Tek kaydın filtreyle eşleşme kuralı
// bool matches(GraveResult e, GraveFilters f) {
//   final nameNorm = e.name.norm();
//   final surnameNorm = e.surname.norm();
//   final cityNorm = e.city.norm();
//   final districtNorm = e.district.norm();
//   final cemNameNorm = e.cemeteriesName.norm();

//   final matchName = f.nameQ.isEmpty || nameNorm.contains(f.nameQ);
//   final matchSurname = f.surnameQ.isEmpty || surnameNorm.contains(f.surnameQ);
//   final matchCity = f.cityN == null || cityNorm == f.cityN;
//   final matchDistrict = f.districtN == null || districtNorm == f.districtN;
//   final matchCemetery = f.cemeteryN == null || cemNameNorm == f.cemeteryN;

//   return matchName &&
//       matchSurname &&
//       matchCity &&
//       matchDistrict &&
//       matchCemetery;
// }

// /// Puanlama (lokasyon ağırlıklı)
// int scoreFor(GraveResult r, GraveFilters f) {
//   int sc = 0;
//   if (f.cityN != null && r.city.norm() == f.cityN) sc += 3;
//   if (f.districtN != null && r.district.norm() == f.districtN) sc += 3;
//   if (f.cemeteryN != null && r.cemeteriesName.norm() == f.cemeteryN) sc += 4;
//   return sc;
// }

// /// Sıralama: önce puan (desc), sonra soyad/ad (asc)
// int compareResults(GraveResult a, GraveResult b, GraveFilters f) {
//   final sa = scoreFor(a, f);
//   final sb = scoreFor(b, f);
//   if (sa != sb) return sb.compareTo(sa);

//   final sComp = a.surname.norm().compareTo(b.surname.norm());
//   if (sComp != 0) return sComp;

//   return a.name.norm().compareTo(b.name.norm());
// }

// /// İl → ilçe listesi (alfabetik)
// List<String> _districtsOf(String province) =>
//     provincesMock
//         .where((p) => p.name == province)
//         .expand((p) => p.districts)
//         .map((d) => d.name)
//         .toList()
//       ..sort();

// /// İl + ilçe → mezarlık listesi (alfabetik)
// List<String> _cemeteriesOf({
//   required String province,
//   required String district,
// }) =>
//     provincesMock
//         .where((p) => p.name == province)
//         .expand((p) => p.districts)
//         .where((d) => d.name == district)
//         .expand((d) => d.cemeteries)
//         .map((c) => c.name)
//         .toList()
//       ..sort();

// /// ============================= VIEWMODEL =============================

// final class GraveSearchViewModel extends BaseCubit<GraveSearchState> {
//   GraveSearchViewModel() : super(GraveSearchState()) {
//     final provs = provincesMock.map((p) => p.name).toList()..sort();
//     emit(state.copyWith(provinceList: provs));
//   }

//   /// Province (il) değişince: ilçe listesini hazırla, ilk ilçeyi seç,
//   /// o ilçeye göre mezarlıkları doldur, seçili mezarlığı sıfırla.
//   void onProvinceChanged(String? value) {
//     final districts = (value == null) ? <String>[] : _districtsOf(value);
//     final firstDistrict = districts.isNotEmpty ? districts.first : null;

//     final cemeteries = (value != null && firstDistrict != null)
//         ? _cemeteriesOf(province: value, district: firstDistrict)
//         : <String>[];

//     emit(
//       state.copyWith(
//         selectedProvince: value,
//         selectedDistrict: firstDistrict,
//         selectedCemetery: null,
//         districtList: districts,
//         cemeteryList: cemeteries,
//       ),
//     );
//   }

//   /// District (ilçe) değişince: mezarlık listesini güncelle, seçili mezarlığı sıfırla.
//   void onDistrictChanged(String? value) {
//     final prov = state.selectedProvince;
//     if (prov == null) {
//       emit(
//         state.copyWith(
//           selectedDistrict: null,
//           selectedCemetery: null,
//           cemeteryList: const [],
//         ),
//       );
//       return;
//     }

//     final cemeteries = (value == null)
//         ? <String>[]
//         : _cemeteriesOf(province: prov, district: value);

//     emit(
//       state.copyWith(
//         selectedDistrict: value,
//         selectedCemetery: null,
//         cemeteryList: cemeteries,
//       ),
//     );
//   }

//   /// Cemetery (mezarlık) seçimi
//   void onCemeteryChanged(String? value) {
//     emit(state.copyWith(selectedCemetery: value));
//   }

//   /// Arama
//   Future<void> search() async {
//     emit(state.copyWith(isLoading: true));
//     await Future<void>.delayed(const Duration(milliseconds: 300));

//     final f = buildFilters(state);
//     final filtered = mockGraveResult.where((e) => matches(e, f)).toList()
//       ..sort((a, b) => compareResults(a, b, f));

//     emit(state.copyWith(isLoading: false, results: filtered));
//   }

//   @override
//   Future<void> close() {
//     state.nameCtrl.dispose();
//     state.surnameCtrl.dispose();
//     return super.close();
//   }
// }

// lib/feature/grave_search/view_model/grave_search_view_model.dart

import 'package:mezmaps/feature/grave_search/view_model/state/grave_location_state.dart';
import 'package:mezmaps/product/helpers/geo_helpers.dart';
import 'package:mezmaps/product/helpers/grave_search_helpers.dart' show buildFilters, compareResults, matches;
import 'package:mezmaps/product/mock/data/mock_cemetries_data.dart';
import 'package:mezmaps/product/mock/data/mock_grave_result.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';

// 👇 domain helper'lar (barrel yoksa ikisini tek tek import et)

final class GraveSearchViewModel extends BaseCubit<GraveSearchState> {
  GraveSearchViewModel() : super(GraveSearchState()) {
    final provs = provincesMock.map((p) => p.name).toList()..sort();
    emit(state.copyWith(provinceList: provs));
  }

  /// Province (il) değişince: ilçe listesini hazırla, ilk ilçeyi seç,
  /// o ilçeye göre mezarlıkları doldur, seçili mezarlığı sıfırla.
  void onProvinceChanged(String? value) {
    final districts = (value == null)
        ? <String>[]
        : districtsOf(value, provincesMock);
    final firstDistrict = districts.isNotEmpty ? districts.first : null;

    final cemeteries = (value != null && firstDistrict != null)
        ? cemeteriesOf(
            province: value,
            district: firstDistrict,
            provinces: provincesMock,
          )
        : <String>[];

    emit(
      state.copyWith(
        selectedProvince: value,
        selectedDistrict: firstDistrict,
        selectedCemetery: null,
        districtList: districts,
        cemeteryList: cemeteries,
      ),
    );
  }

  /// District (ilçe) değişince: mezarlık listesini güncelle, seçili mezarlığı sıfırla.
  void onDistrictChanged(String? value) {
    final prov = state.selectedProvince;
    if (prov == null) {
      emit(
        state.copyWith(
          selectedDistrict: null,
          selectedCemetery: null,
          cemeteryList: const [],
        ),
      );
      return;
    }

    final cemeteries = (value == null)
        ? <String>[]
        : cemeteriesOf(
            province: prov,
            district: value,
            provinces: provincesMock,
          );

    emit(
      state.copyWith(
        selectedDistrict: value,
        selectedCemetery: null,
        cemeteryList: cemeteries,
      ),
    );
  }

  /// Cemetery (mezarlık) seçimi
  void onCemeteryChanged(String? value) {
    emit(state.copyWith(selectedCemetery: value));
  }

  /// Arama
  Future<void> search() async {
    emit(state.copyWith(isLoading: true));
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));

      final f = buildFilters(state); // record snapshot
      final filtered = mockGraveResult.where((e) => matches(e, f)).toList()
        ..sort((a, b) => compareResults(a, b, f));

      emit(state.copyWith(results: filtered));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  @override
  Future<void> close() {
    state.nameCtrl.dispose();
    state.surnameCtrl.dispose();
    return super.close();
  }
}
