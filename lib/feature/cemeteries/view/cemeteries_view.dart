import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/feature/cemeteries/view_model/mixin/cemetries_mixin.dart';
import 'package:mezmaps/feature/cemeteries/view_model/cemetries_view_model.dart';
import 'package:mezmaps/feature/cemeteries/view_model/state/cemetries_state.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/app_bar/custom_app_bar.dart';
import 'package:mezmaps/product/widgets/drop_down_widget.dart/province_distirict_row.dart';

part '../widgets/all_map_button.dart';

class CemeteriesView extends StatefulWidget {
  const CemeteriesView({super.key});

  @override
  State<CemeteriesView> createState() => _CemeteriesViewState();
}

final class _CemeteriesViewState extends BaseState<CemeteriesView>
    with CemetriesMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.cemeteries,
        widget: Assets.icons.mLight.image(package: 'gen', width: 35),
      ),
      body: Padding(
        padding: PaddingManager.normalPaddingAll(context),
        child: BaseBlocBody<CemetriesViewModel, CemetriesState>(
          bloc: cemeteriesViewModel,
          isLoading: (s) => s.isLoading,
          error: (s) => s.error,
          onRetry: () => cemeteriesViewModel.load(),
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
             /// The code snippet you provided is creating a `Padding` widget with specific padding
             /// using `PaddingManager.normalPaddingAll(context)`. Inside this `Padding` widget, there
             /// is a `ProvinceDistrictRow` widget being displayed.
                Padding(
                  padding: PaddingManager.normalPaddingAll(context),
                  child: ProvinceDistrictRow(
                    province: ProjectString.province,
                    district: ProjectString.district,
                    dataManager: cemeteriesViewModel,
                  ),
                ),
                const Divider(),

                /// ---------- Mezarlık Listesi ----------
                Expanded(
                  /// This code snippet is a ternary operator in Dart. It is used to
                  /// conditionally render either the `_CemeteriesEmptyState` widget or the
                  /// `_CemeteriesList` widget based on the condition `state.cemeteries.isEmpty`.
                  child: state.cemeteries.isEmpty
                      ? _CemeteriesEmptyState(
                          selectedProvince: state.selectedProvince,
                          selectedDistrict: state.selectedDistrict,
                        )
                      : _CemeteriesList(
                          cemeteries: state.cemeteries,
                          viewModel: cemeteriesViewModel,
                        ),
                ),

                /// ---------- Haritada Göster Butonu ----------
                _AllMapButton(onPressed: () {}),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
