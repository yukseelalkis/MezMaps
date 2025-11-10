import 'package:mezmaps/feature/grave_search/view_model/state/grave_location_state.dart';
import 'package:mezmaps/product/utility/helpers/geo_helpers.dart';
import 'package:mezmaps/product/utility/helpers/grave_search_helpers.dart'
    show buildFilters, compareResults, matches;
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
