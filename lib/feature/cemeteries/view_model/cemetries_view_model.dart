import 'package:common/common.dart';
import 'package:mezmaps/feature/cemeteries/view_model/state/cemetries_state.dart';
import 'package:mezmaps/product/mock/interface/cemetery_repository.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';
import 'package:mezmaps/product/utility/mixin/province_district_data.dart';

final class CemetriesViewModel extends BaseCubit<CemetriesState>
    with ProvinceDistrictData {
  CemetriesViewModel(this._repo) : super(const CemetriesState.initial());

  final IProvinceRepo _repo;

  /// These `@override` methods in the `CemetriesViewModel` class are implementing getters for certain
  /// properties from the `CemetriesState` class. Here's what each of these getters is doing:

  @override
  List<String> get provinceList => state.provinceList;

  @override
  String? get selectedProvince => state.selectedProvince;

  @override
  List<String> get districtList => state.districtList;

  @override
  String? get selectedDistrict => state.selectedDistrict;

  /// The `load` function fetches provinces, districts, and cemeteries data based on certain conditions
  /// and updates the state accordingly, handling errors if they occur.
  ///
  /// Returns:
  ///   If the `provinces` list is empty, a state with empty lists for `provinces`, `districts`, and
  /// `cemeteries`, and `null` values for `selectedProvince` and `selectedDistrict` is being returned.
  /// Otherwise, a state with the loaded data including `provinces`, `districts`, `cemeteries`,
  /// `selectedProvince`, and `selectedDistrict`
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

  @override
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

  /// This function updates the state with selected district and list of cemeteries based on the selected
  /// province and district, handling loading and error states.
  ///
  /// Args:
  ///   district (String): The `onDistrictChanged` method is a function that handles changes in the
  /// selected district. It first checks if the selected province is null or if the district is null, in
  /// which case it resets the selected district and clears the list of cemeteries.
  ///
  /// Returns:
  ///   In the `onDistrictChanged` method, if the `province` is null or the `district` is null, the state
  /// is updated with `selectedDistrict` set to null and `cemeteries` set to an empty list. After that, a
  /// return statement is used to exit the method early.

  @override
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

  /// This Dart function triggers the opening of a cemetery map and returns a boolean indicating whether
  /// the operation was successful.
  ///
  /// Args:
  ///   c (Cemetery): The parameter `c` represents a `Cemetery` object, which likely contains information
  /// about a cemetery such as its latitude, longitude, name, and other relevant details. In the provided
  /// code snippet, this `Cemetery` object `c` is used to open the map of the specified cemetery location
  ///
  /// Returns:
  ///   The function `openCemeteryMap` returns a `Future<bool>` which indicates whether the operation of
  /// opening the map for the specified cemetery was successful or not. This boolean value can be used in
  /// the UI layer to show a SnackBar message to the user.
  /// Belirtilen mezarlığın haritasını açma işlemini tetikler.
  /// İşlemin başarılı olup olmadığını döndürür (UI katmanında SnackBar göstermek için).
  Future<bool> openCemeteryMap(Cemetery c) async {
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
