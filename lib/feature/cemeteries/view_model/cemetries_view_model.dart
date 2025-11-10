// import 'package:mezmaps/feature/cemeteries/view_model/state/cemetries_state.dart';
import 'package:common/common.dart';
import 'package:mezmaps/feature/cemeteries/view_model/state/cemetries_state.dart';
import 'package:mezmaps/product/mock/interface/cemetery_repository.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';
import 'package:mezmaps/product/utility/mixin/province_district_data.dart';

final class CemetriesViewModel extends BaseCubit<CemetriesState>
    with ProvinceDistrictData {
  CemetriesViewModel(this._repo) : super(const CemetriesState.initial());

  final ICemeteryRepository _repo;

  @override
  List<String> get provinceList => state.provinceList;

  @override
  String? get selectedProvince => state.selectedProvince;

  @override
  List<String> get districtList => state.districtList;

  @override
  String? get selectedDistrict => state.selectedDistrict;

  // ... (load metodu)

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
  @override
  // PARAMETRE DÜZELTİLDİ: String yerine String? (nullable) kullanıldı
  Future<void> onProvinceChanged(String? province) async {
    // province null gelirse seçimleri sıfırla
    if (province == null) {
      emit(
        state.copyWith(
          selectedProvince: null,
          selectedDistrict: null,
          districts: const <District>[],
          cemeteries: const <Cemetery>[],
        ),
      );
      return;
    }

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

  @override
  // PARAMETRE DÜZELTİLDİ: String yerine String? (nullable) kullanıldı
  Future<void> onDistrictChanged(String? district) async {
    final String? province = state.selectedProvince;
    // district null gelirse veya province yoksa sıfırla/durdur
    if (province == null || district == null) {
      emit(state.copyWith(selectedDistrict: null, cemeteries: const []));
      return;
    }

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

  /// Belirtilen mezarlığın haritasını açma işlemini tetikler.
  /// İşlemin başarılı olup olmadığını döndürür (UI katmanında SnackBar göstermek için).
  Future<bool> openCemeteryMap(Cemetery c) async {
    // NOT: urlPackage import edilmeli/erişilebilir olmalıdır.

    final ok = await urlPackage.openMap(
      lat: c.lat,
      lng: c.lng,
      label: c.name,
      zoom: 16,
      preferGoogle: true,
    );

    return ok; // Sonucu View'e döndürüyoruz
  }

  /// UI'dan çağırabileceğin kısa yollar
  Future<void> retry() => load();
  void clearError() => emit(state.copyWith(error: null));
}
