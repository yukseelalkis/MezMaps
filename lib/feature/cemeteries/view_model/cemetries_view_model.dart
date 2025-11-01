import 'package:mezmaps/feature/cemeteries/view_model/state/cemetries_state.dart';
import 'package:mezmaps/product/mock/interface/cemetery_repository.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';

final class CemetriesViewModel extends BaseCubit<CemetriesState> {
  CemetriesViewModel(this._repo) : super(const CemetriesState.initial());

  final ICemeteryRepository _repo;

  /// İlk yükleme
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
          ),
        );
        return;
      }

      final String selectedProvince = provinces.any((p) => p.name == 'Hatay')
          ? 'Hatay'
          : provinces.first.name;

      final List<District> districts = await _repo.getDistricts(
        selectedProvince,
      );

      final String? selectedDistrict =
          districts.any((d) => d.name == 'İskenderun')
          ? 'İskenderun'
          : (districts.isNotEmpty ? districts.first.name : null);

      final List<Cemetery> cemeteries = (selectedDistrict != null)
          ? await _repo.getCemeteries(selectedProvince, selectedDistrict)
          : const <Cemetery>[];

      emit(
        state.copyWith(
          isLoading: false,
          provinces: provinces,
          districts: districts,
          cemeteries: cemeteries,
          selectedProvince: selectedProvince,
          selectedDistrict: selectedDistrict,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// İl değişti
  Future<void> onProvinceChanged(String province) async {
    // province değiştiyse district ve cemeteries resetlenir
    emit(
      state.copyWith(
        isLoading: true,
        error: null,
        selectedProvince: province,
        selectedDistrict: null,
        cemeteries: const <Cemetery>[],
      ),
    );

    try {
      final List<District> districts = await _repo.getDistricts(province);

      String? selectedDistrict;
      List<Cemetery> cemeteries = const <Cemetery>[];

      if (districts.isNotEmpty) {
        selectedDistrict = districts.first.name;
        cemeteries = await _repo.getCemeteries(province, selectedDistrict);
      }

      emit(
        state.copyWith(
          isLoading: false,
          districts: districts,
          cemeteries: cemeteries,
          selectedDistrict: selectedDistrict,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// İlçe değişti
  Future<void> onDistrictChanged(String district) async {
    final String? province = state.selectedProvince;
    if (province == null) return; // güvenlik

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final List<Cemetery> cemeteries = await _repo.getCemeteries(
        province,
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

  /// UI'dan çağırabileceğin kısa yollar
  Future<void> retry() => load();
  void clearError() => emit(state.copyWith(error: null));
}
