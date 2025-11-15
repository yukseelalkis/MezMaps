import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/feature/grave_search/view/grave_search_view.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';

// State'lerin temel sınıfını import edin (Varsayım: BaseState'in bir türevi)


// StateT: State'in genel tipi
// T: GraveResult'tan miras almak zorunda olan liste veri tipi (Güvenli Kısıtlama)
@immutable
final class GraveResultsList<StateT, T extends GraveResult>
    extends StatelessWidget {
  const GraveResultsList({
    required this.state,
    required this.resultsSelector, // State içindeki listeyi seçen fonksiyon
    super.key,
  });

  final StateT state; // Tipi StateT olarak güncellendi
  // State objesini alır ve T tipindeki listeyi döndürür.
  final List<T> Function(StateT state) resultsSelector;

  @override
  Widget build(BuildContext context) {
    final results = resultsSelector(state);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, i) {
        final r = results[i];

        // T tipi zaten GraveResult'tan miras almak zorunda olduğu için,
        // güvenli bir şekilde GraveResult olarak kullanabiliriz.
        final graveResult = r;

        return GraveSearchResultCard(
          title: graveResult.name.trim().isEmpty ? '—' : graveResult.name,
          subLeftTop: KeyValueText(
            label: ProjectString.buriatSite,
            value: graveResult.burialPlace,
          ),
          subRightTop: const KeyValueText(label: '—', value: '—'),
          subLeftBottom: KeyValueText(
            label: ProjectString.death,
            value: graveResult.deathDate,
          ),
          subRightBottom: KeyValueText(
            label: ProjectString.buriat,
            value: graveResult.burialDate,
          ),
        );
      },
    );
  }
}

@immutable
final class GraveSearchResultCard extends StatelessWidget {
  const GraveSearchResultCard({
    super.key,
    required this.title,
    required this.subLeftTop,
    required this.subRightTop,
    required this.subLeftBottom,
    required this.subRightBottom,
  });

  final String title;
  final Widget subLeftTop;
  final Widget subRightTop;
  final Widget subLeftBottom;
  final Widget subRightBottom;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.moreBorderRadius,
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: PaddingManager.responsiveLTRB(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık
            Padding(
              padding: PaddingManager.cardTitlePadding(context),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: cs.primary,
                ),
              ),
            ),

            // Üst satır
            Padding(
              padding: PaddingManager.verticalItemGap(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subLeftTop, subRightTop],
              ),
            ),

            // Alt satır
            Padding(
              padding: PaddingManager.verticalItemGap(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subLeftBottom, subRightBottom],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
