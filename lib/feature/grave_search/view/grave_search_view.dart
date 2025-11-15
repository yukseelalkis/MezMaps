import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/feature/grave_search/view_model/mixin/grave_search_mixin.dart';
import 'package:mezmaps/feature/grave_search/view_model/grave_search_view_model.dart';
import 'package:mezmaps/feature/grave_search/view_model/state/grave_search_state.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/utility/mixin/form_validator_mixin.dart';
import 'package:mezmaps/product/widgets/app_bar/custom_app_bar.dart';
import 'package:mezmaps/product/widgets/custom_text_field.dart';
import 'package:mezmaps/product/widgets/drop_down_widget/province_distirict_row.dart';
import 'package:mezmaps/product/widgets/empty_widget/empty_widget.dart';
import 'package:mezmaps/product/widgets/grave_result_list/grave_result_list.dart';

part '../widgets/grave_search_widget.dart';

final class GraveSearchView extends StatefulWidget {
  const GraveSearchView({super.key});

  @override
  State<GraveSearchView> createState() => _GraveSearchViewState();
}

final class _GraveSearchViewState extends BaseState<GraveSearchView>
    with GraveSearchMixin {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.cemeteryLocations,
        widget: Assets.icons.mkLight.image(package: 'gen', width: 32),
      ),
      body: BaseBlocBody<GraveSearchViewModel, GraveSearchState>(
        bloc: graveSearchViewModel,
        isLoading: (s) => s.isLoading,
        error: (s) => s.error,
        onRetry: () => graveSearchViewModel.load(),
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                padding: PaddingManager.normalPaddingAll(context),
                children: [
                  // FORM
                  GraveSearchForm(
                    state: state,
                    viewModel: graveSearchViewModel,
                    formKey: _formKey,
                  ),

                  _SearchButton(
                    formKey: _formKey,
                    viewModel: graveSearchViewModel,
                    state: state,
                  ),
                  const Divider(),
                  ResultCountText(count: state.results.length),
                  // SONUÇLAR
                  if (state.results.isEmpty)
                    const EmptyResults()
                  else
                    GraveResultsList<GraveSearchState, GraveResult>(
                      state: state,
                      resultsSelector: (s) => s.results,
                    ),
                ],
              ),
              // LOADING OVERLAY
              if (state.isLoading)
                ColoredBox(
                  color: cs.surface.withValues(),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
