import 'package:flutter/material.dart';
import 'package:mezmaps/feature/grave_location/view_model/state/grave_location_state.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';


final class GraveLocationViewModel extends BaseCubit<GraveLocationState> {
  GraveLocationViewModel() : super(const GraveLocationState());

  /// form controller’lar
  final nameCtrl = TextEditingController();
  final surnameCtrl = TextEditingController();

  /// dropdown kaynakları (mock)
  final List<String> cemeteries = const ['Asri Mezarlık', 'Yeni Mezarlık'];

  void onCemeteryChanged(String? value) {
    emit(state.copyWith(selectedCemetery: value));
  }

  Future<void> search() async {
    emit(state.copyWith(isLoading: true));
    await Future<void>.delayed(const Duration(milliseconds: 400)); // fake io

    final mock = <GraveResult>[
      const GraveResult(
        name: 'Deniz Çelik',
        age: 21,
        burialPlace: 'K-1309',
        deathDate: '13.05.2025',
        burialDate: '13.05.2025',
      ),
      const GraveResult(
        name: 'Yüksel Alkış',
        age: 24,
        burialPlace: 'B-777',
        deathDate: '03.07.2011',
        burialDate: '03.07.2011',
      ),
    ];

    // basit filtre örneği
    final filtered = mock.where((e) {
      final n = nameCtrl.text.trim().toLowerCase();
      final s = surnameCtrl.text.trim().toLowerCase();
      final matchesName = n.isEmpty || e.name.toLowerCase().contains(n);
      final matchesSurname = s.isEmpty || e.name.toLowerCase().contains(s);
      return matchesName && matchesSurname;
    }).toList();

    emit(state.copyWith(isLoading: false, results: filtered));
  }

  @override
  Future<void> close() {
    nameCtrl.dispose();
    surnameCtrl.dispose();
    return super.close();
  }
}
