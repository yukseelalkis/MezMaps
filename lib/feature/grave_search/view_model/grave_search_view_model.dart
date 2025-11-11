import 'package:mezmaps/feature/grave_search/view_model/state/grave_search_state.dart';
import 'package:mezmaps/product/mock/data/mock_grave_result.dart';
import 'package:mezmaps/product/mock/interface/cemetery_repository.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';
import 'package:mezmaps/product/utility/helpers/grave_search_helpers.dart';
import 'package:mezmaps/product/utility/mixin/province_district_data.dart';

final class GraveSearchViewModel extends BaseCubit<GraveSearchState>
    with ProvinceDistrictData {
  GraveSearchViewModel(this._repo) : super(GraveSearchState.initial());

  final IProvinceRepo _repo;

  // ProvinceDistrictData getters
  @override
  List<String> get provinceList => state.provinceList;

  @override
  String? get selectedProvince => state.selectedProvince;

  @override
  List<String> get districtList => state.districtList;

  @override
  String? get selectedDistrict => state.selectedDistrict;

  // İlk yükleme
  Future<void> load() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final List<Province> provinces = await _repo.getProvinces();
      if (provinces.isEmpty) {
        emit(
          state.copyWith(
            isLoading: false,
            provinces: const <Province>[],
            districts: const <District>[],
            cemeteries: const <Cemetery>[],
            selectedProvince: null,
            selectedDistrict: null,
            selectedCemetery: null,
          ),
        );
        return;
      }

      final String selectedProv = provinces.any((p) => p.name == '')
          ? ''
          : provinces.first.name;

      final List<District> districts = await _repo.getDistricts(selectedProv);
      final String? selectedDist = districts.any((d) => d.name == '')
          ? ''
          : (districts.isNotEmpty ? districts.first.name : null);

      final List<Cemetery> cemeteries = (selectedDist != null)
          ? await _repo.getCemeteries(selectedProv, selectedDist)
          : const <Cemetery>[];

      emit(
        state.copyWith(
          isLoading: false,
          provinces: provinces,
          districts: districts,
          cemeteries: cemeteries,
          selectedProvince: selectedProv,
          selectedDistrict: selectedDist,
          selectedCemetery: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  Future<void> onProvinceChanged(String? province) async {
    if (province == null) {
      emit(
        state.copyWith(
          selectedProvince: null,
          selectedDistrict: null,
          selectedCemetery: null,
          districts: const <District>[],
          cemeteries: const <Cemetery>[],
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        error: null,
        selectedProvince: province,
        selectedDistrict: null,
        selectedCemetery: null,
        cemeteries: const <Cemetery>[],
      ),
    );

    try {
      final List<District> districts = await _repo.getDistricts(province);

      String? firstDistrict;
      List<Cemetery> cemeteries = const <Cemetery>[];

      if (districts.isNotEmpty) {
        firstDistrict = districts.first.name;
        cemeteries = await _repo.getCemeteries(province, firstDistrict);
      }

      emit(
        state.copyWith(
          isLoading: false,
          districts: districts,
          cemeteries: cemeteries,
          selectedDistrict: firstDistrict,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  Future<void> onDistrictChanged(String? district) async {
    final String? prov = state.selectedProvince;
    if (prov == null || district == null) {
      emit(
        state.copyWith(
          selectedDistrict: null,
          selectedCemetery: null,
          cemeteries: const <Cemetery>[],
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, error: null, selectedCemetery: null));
    try {
      final List<Cemetery> cemeteries = await _repo.getCemeteries(
        prov,
        district,
      );

      emit(
        state.copyWith(
          isLoading: false,
          selectedDistrict: district,
          cemeteries: cemeteries,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Mezar isim dropdown’ı string tutuyor (UI kolaylığı)
  void onCemeteryChanged(String? value) {
    emit(state.copyWith(selectedCemetery: value));
  }

  Future<void> search() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final f = buildFilters(state);
      final filtered = mockGraveResult.where((e) => matches(e, f)).toList()
        ..sort((a, b) => compareResults(a, b, f));

      emit(state.copyWith(results: filtered));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
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

  void enableAutovalidate() {
    emit(state.copyWith(autovalidate: true));
  }

  bool validateBeforeSearch() {
    // 1) En az bir kriter girilmiş mi?
    if (!state.hasAnyFilter) {
      return false;
    }

    // 2) İl/ilçe zorunluysa kontrol et (isteğe bağlı)
    if (state.selectedProvince == null || state.selectedDistrict == null) {
      return false;
    }

    return true;
  }
}
