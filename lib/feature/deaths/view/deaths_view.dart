import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/feature/deaths/view_model/deaths_view_model.dart';
import 'package:mezmaps/feature/deaths/view_model/mixin/deaths_mixin.dart';
import 'package:mezmaps/feature/deaths/view_model/state/deaths_state.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/app_bar/custom_app_bar.dart';
import 'package:mezmaps/product/widgets/empty_widget/empty_widget.dart';
import 'package:mezmaps/product/widgets/grave_result_list/grave_result_list.dart';

class DeathsView extends StatefulWidget {
  const DeathsView({super.key});

  @override
  State<DeathsView> createState() => _DeathsViewState();
}

final class _DeathsViewState extends BaseState<DeathsView> with DeathsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.deathsHeader,
        widget: Assets.icons.vfLight.image(package: 'gen', width: 35),
      ),
      body: BaseBlocBody<DeathsViewModel, DeathsState>(
        bloc: viewModel,
        isLoading: (s) => s.isLoading,
        error: (s) => s.error,
        onRetry: () => viewModel.load(),
        builder: (context, state) {
          return ListView(
            padding: PaddingManager.normalPaddingAll(context),
            children: [
              if (state.results.isEmpty)
                const EmptyResults()
              else
                GraveResultsList<DeathsState, GraveResult>(
                  state: state,
                  resultsSelector: (s) => s.results,
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
