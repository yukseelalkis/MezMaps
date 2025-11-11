import 'package:flutter/material.dart';
import 'package:mezmaps/feature/grave_search/view/grave_search_view.dart';
import 'package:mezmaps/feature/grave_search/view_model/grave_search_view_model.dart';
import 'package:mezmaps/product/mock/repository/cemeteries_repo.dart';
import 'package:mezmaps/product/state/base/base_state.dart';

mixin GraveSearchMixin on BaseState<GraveSearchView> {
  late final GraveSearchViewModel _graveSearchModel;
  GraveSearchViewModel get graveSearchViewModel => _graveSearchModel;

  @override
  void initState() {
    _graveSearchModel = GraveSearchViewModel(MockCemeteryRepository());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _graveSearchModel.load();
    });
    super.initState();
  }

  @override
  void dispose() {
    _graveSearchModel.close();
    super.dispose();
  }
}
