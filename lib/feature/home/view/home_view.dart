import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/feature/cemeteries/view/cemeteries_view.dart';
import 'package:mezmaps/feature/deaths/view/deaths_view.dart';
import 'package:mezmaps/feature/grave_search/view/grave_search_view.dart';
import 'package:mezmaps/feature/home/view_model/mixin/home_mixin.dart';
import 'package:mezmaps/feature/info/view/info_view.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/utility/navigation/navigation_ext.dart';

part '../widget/home_view_widget.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ProjectString.appName)),
      body: Column(
        children: [
          _Logo(),

          /// Mezxarliklar
          _CustomButton(
            /// tekleyebiliriz bakacam cok tekrar ediyor
            logo: Assets.icons.mLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),
            text: ProjectString.cemeteries,
            onPressed: () {
              context.pushTo(CemeteriesView());
            },
          ),

          ///Mezarlık Konumları"
          _CustomButton(
            /// tekleyebiliriz bakacam cok tekrar ediyor
            logo: Assets.icons.mkLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),
            text: ProjectString.cemeteryLocations,
            onPressed: () {
              context.pushTo(GraveSearchView());
            },
          ),
          _CustomButton(
            logo: Assets.icons.vfLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),
            text: ProjectString.deceasedPeople,
            onPressed: () {
              context.pushTo(DeathsPage());
            },
          ),
          _CustomButton(
            logo: Assets.icons.infoLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),

            text: ProjectString.about,
            onPressed: () {
              context.pushTo(InfoView());
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
