import 'package:flutter/material.dart';
import 'package:mezmaps/feature/grave_location/view_model/grave_location_view_model.dart';

mixin GraveLocationMixin<T extends StatefulWidget> on State<T> {
  late final GraveLocationViewModel graveLocationViewModel;

  @override
  void initState() {
    super.initState();
    graveLocationViewModel = GraveLocationViewModel();
  }

  @override
  void dispose() {
    graveLocationViewModel.close();
    super.dispose();
  }
}
