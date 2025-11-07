import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';

import 'package:mezmaps/feature/grave_search/view_model/mixin/grave_search_mixin.dart';
import 'package:mezmaps/feature/grave_search/view_model/grave_location_view_model.dart';
import 'package:mezmaps/feature/grave_search/view_model/state/grave_location_state.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/custom_app_bar.dart';

class GraveSearchView extends StatefulWidget {
  const GraveSearchView({super.key});

  @override
  State<GraveSearchView> createState() => _GraveSearchViewState();
}

final class _GraveSearchViewState extends BaseState<GraveSearchView>
    with GraveSearchMixin {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.cemeteryLocations,
        widget: Assets.icons.mkLight.image(package: 'gen', width: 32),
      ),
      body: BlocBuilder<GraveSearchViewModel, GraveSearchState>(
        bloc: graveSearchViewModel,
        builder: (context, state) {
          final String? selectedProvince =
              (state.selectedProvince != null &&
                  state.provinceList.contains(state.selectedProvince))
              ? state.selectedProvince
              : null;

          final String? selectedDistrict =
              (state.selectedDistrict != null &&
                  state.districtList.contains(state.selectedDistrict))
              ? state.selectedDistrict
              : null;

          final String? selectedCemetery =
              (state.selectedCemetery != null &&
                  state.cemeteryList.contains(state.selectedCemetery))
              ? state.selectedCemetery
              : null;

          final hasDistricts = state.districtList.isNotEmpty;
          final hasCemeteries = state.cemeteryList.isNotEmpty;

          return Stack(
            children: [
              ListView(
                padding: PaddingManager.normalPaddingAll(context),
                children: [
                  // Ad
                  TextField(
                    controller: state.nameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Ad',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Soyad
                  TextField(
                    controller: state.surnameCtrl,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => graveSearchViewModel.search(),
                    decoration: const InputDecoration(
                      labelText: 'Soyad',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // İl
                  DropdownButtonFormField<String>(
                    isDense: true,
                    initialValue: selectedProvince,
                    decoration: const InputDecoration(
                      labelText: 'İl',
                      border: OutlineInputBorder(),
                    ),
                    items: state.provinceList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => graveSearchViewModel.onProvinceChanged(v),
                  ),
                  const SizedBox(height: 12),

                  // İlçe
                  DropdownButtonFormField<String>(
                    isDense: true,
                    initialValue: selectedDistrict,
                    decoration: const InputDecoration(
                      labelText: 'İlçe',
                      border: OutlineInputBorder(),
                    ),
                    items: state.districtList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: hasDistricts
                        ? (v) => graveSearchViewModel.onDistrictChanged(v)
                        : null,
                  ),
                  const SizedBox(height: 12),

                  // Mezarlık
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      DropdownButtonFormField<String>(
                        isDense: true,
                        initialValue: selectedCemetery,
                        decoration: const InputDecoration(
                          labelText: 'Mezarlık',
                          border: OutlineInputBorder(),
                        ),
                        hint: const Text('Mezarlık seçiniz'),
                        items: state.cemeteryList
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: hasCemeteries
                            ? graveSearchViewModel.onCemeteryChanged
                            : null,
                      ),
                      if (hasCemeteries && selectedCemetery != null)
                        Positioned(
                          right: 6,
                          child: IconButton(
                            tooltip: 'Seçimi temizle',
                            icon: const Icon(Icons.close, size: 20),
                            color: cs.primary,
                            onPressed: () =>
                                graveSearchViewModel.onCemeteryChanged(null),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Ara
                  SizedBox(
                    height: 48,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.search),
                      onPressed: graveSearchViewModel.search,
                      label: const Text('Ara'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),

                  // Sonuç sayısı
                  Text(
                    'Kayıtlı Mezar Sayısı: ${state.results.length}',
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 12),

                  // Sonuç listesi
                  if (state.results.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                        'Sonuç bulunamadı',
                        style: TextStyle(color: cs.onSurfaceVariant),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, i) {
                        final r = state.results[i];

                        final name = (r.name).toString().trim(); // null guard
                        final title = name.isEmpty ? '—' : name;

                        // Modelinde 'cemetery' yok; 'Mezarlık' satırını 'Defin Yeri' ile gösterelim.
                        final subLeftTop = _kv('Defin Yeri', r.burialPlace);
                        final subRightTop = _kv('—', '—');

                        final subLeftBottom = _kv('Vefat', r.deathDate);
                        final subRightBottom = _kv('Defin', r.burialDate);

                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(color: cs.outlineVariant),
                          ),
                          child: Padding(
                            padding: PaddingManager.responsiveLTRB(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: cs.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [subLeftTop, subRightTop],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [subLeftBottom, subRightBottom],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 24),
                ],
              ),

              // Loading overlay
              if (state.isLoading)
                ColoredBox(
                  color: cs.surface.withOpacity(0.4),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _kv(String k, String? v) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '$k: ',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black54,
        ),
      ),
      Text(v == null || v.isEmpty ? '-' : v),
    ],
  );
}
