import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';

import 'package:mezmaps/feature/cemeteries/view_model/mixin/cemetries_mixin.dart';
import 'package:mezmaps/feature/cemeteries/view_model/cemetries_view_model.dart';
import 'package:mezmaps/feature/cemeteries/view_model/state/cemetries_state.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/custom_app_bar.dart';

class CemeteriesView extends StatefulWidget {
  const CemeteriesView({super.key});

  @override
  State<CemeteriesView> createState() => _CemeteriesViewState();
}

final class _CemeteriesViewState extends BaseState<CemeteriesView>
    with CemetriesMixin {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.cemeteries,
        widget: Assets.icons.mLight.image(package: 'gen', width: 35),
      ),
      body: Padding(
        padding: PaddingManager.normalPaddingAll(context),
        child: BlocBuilder<CemetriesViewModel, CemetriesState>(
          bloc: cemeteriesViewModel, // mixin'den geliyor
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hata: ${state.error!}',
                      style: TextStyle(color: cs.error),
                    ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => cemeteriesViewModel.load(),
                      child: const Text('Tekrar Dene'),
                    ),
                  ],
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: PaddingManager.normalPaddingAll(context),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value:
                              (state.selectedProvince != null &&
                                  state.provinces.any(
                                    (p) => p.name == state.selectedProvince,
                                  ))
                              ? state.selectedProvince
                              : null,
                          items: state.provinces
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p.name,
                                  child: Text(p.name),
                                ),
                              )
                              .toList(),
                          onChanged: (v) {
                            if (v != null)
                              cemeteriesViewModel.onProvinceChanged(v);
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: PaddingManager.lessPaddingAll(context),
                          child: DropdownButtonFormField<String>(
                            value:
                                (state.selectedDistrict != null &&
                                    state.districts.any(
                                      (d) => d.name == state.selectedDistrict,
                                    ))
                                ? state.selectedDistrict
                                : null,
                            items: state.districts
                                .map(
                                  (d) => DropdownMenuItem(
                                    value: d.name,
                                    child: Text(d.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              if (v != null)
                                cemeteriesViewModel.onDistrictChanged(v);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),

                Expanded(
                  child: state.cemeteries.isEmpty
                      ? Center(
                          child: Text(
                            state.selectedProvince == null
                                ? 'İl/ilçe seçiniz'
                                : '${state.selectedProvince} / ${state.selectedDistrict ?? '-'} için kayıt yok',
                            style: TextStyle(color: cs.onSurfaceVariant),
                          ),
                        )
                      : ListView.separated(
                          padding: PaddingManager.lessPaddingAll(context),
                          itemCount: state.cemeteries.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, i) {
                            final c = state.cemeteries[i];
                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(color: cs.outlineVariant),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Text(
                                  c.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                ),
                                onTap: () {
                                  // TODO: detay/harita
                                },
                              ),
                            );
                          },
                        ),
                ),

                Padding(
                  padding: PaddingManager.normalPaddingAll(context),
                  child: SizedBox(
                    child: FilledButton(
                      onPressed: state.cemeteries.isEmpty
                          ? null
                          : () {
                              // TODO: tümünü haritada göster
                            },
                      child: const Text('Hepsini Haritada Görüntüle'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
