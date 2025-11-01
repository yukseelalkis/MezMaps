import 'package:flutter/material.dart';
import 'package:mezmaps/feature/cemeteries/view/cemeteries_view.dart';
import 'package:mezmaps/feature/cemeteries/view_model/cemetries_view_model.dart';
import 'package:mezmaps/product/mock/repository/cemeteries_repo.dart';
import 'package:mezmaps/product/state/base/base_state.dart';

mixin CemetriesMixin on BaseState<CemeteriesView> {
  late final CemetriesViewModel _cemetriesViewModel;
  CemetriesViewModel get cemeteriesViewModel => _cemetriesViewModel;
  @override
  void initState() {
    // repo’yu Cubit'e veriyoruz
    _cemetriesViewModel = CemetriesViewModel(MockCemeteryRepository());

    // Ekran yüklendikten sonra Cubit’in load() fonksiyonunu çalıştırıyoruz
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cemetriesViewModel.load();
    });
    super.initState();
  }

  @override
  void dispose() {
    _cemetriesViewModel.close(); // BaseCubit -> Bloc’ta dispose gibi
    super.dispose();
  }
}
