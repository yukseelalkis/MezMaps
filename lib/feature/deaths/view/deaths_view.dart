import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/custom_app_bar.dart';
import 'package:mezmaps/feature/home/view/home_view.dart'; // BottomBar buradan geliyor

class DeathsPage extends StatelessWidget {
  const DeathsPage({super.key});

  final List<_Grave> _deceasedList = const [
    _Grave(
      'Deniz',
      'Çelik',
      21,
      '13.05.2025',
      '13.05.2025',
      'A-13',
      'Asri Mezarlık',
      "Esra",
      "Bilo Baba",
    ),
    _Grave(
      'Yüksel',
      'Alkış',
      24,
      '03.07.2011',
      '03.07.2011',
      'B-14',
      'Yeşilkent Mezarlığı',
      "Saliha",
      "Murat",
    ),
    _Grave(
      'Vahap',
      'Soylu',
      21,
      '21.09.2021',
      '23.09.2021',
      'C-15',
      'Asri Mezarlık',
      'Meliha',
      'İmam-ı Azam',
    ),
    _Grave(
      "Eren",
      "Selli",
      31,
      '22.10.2024',
      "22.10.2024",
      "D-16",
      "Asri Mezarlık",
      "Arzu",
      "Şükrü",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.deceasedPeople,
        widget: Assets.icons.mkLight.image(package: 'gen', width: 35),
      ),
      body: Padding(
        padding: PaddingManager.normalPaddingAll(context),
        child: ListView.builder(
          itemCount: _deceasedList.length,
          itemBuilder: (context, index) {
            final g = _deceasedList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: cs.outline, width: 3.0),
              ),
              child: Padding(
                padding: PaddingManager.responsiveLTRB(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${g.ad} ${g.soyad}',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: cs.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _kv('Yaş:', '${g.yas}'),
                        _kv('Defin Yeri:', g.definYeri),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _kv('Vefat Tarihi:', g.vefatTarihi),
                        _kv('Defin Tarihi:', g.definTarihi),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _kv('Anne Adı:', g.anneAdi),
                        _kv('Baba Adı:', g.babaAdi),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        g.mezarlik,
                        style: TextStyle(
                          color: cs.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _kv(String k, String v) => Row(
        children: [
          Text(
            k,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 6),
          Text(v),
        ],
      );
}

class _Grave {
  final String ad,
      soyad,
      definTarihi,
      definYeri,
      vefatTarihi,
      mezarlik,
      anneAdi,
      babaAdi;
  final int yas;

  const _Grave(
    this.ad,
    this.soyad,
    this.yas,
    this.vefatTarihi,
    this.definTarihi,
    this.definYeri,
    this.mezarlik,
    this.anneAdi,
    this.babaAdi,
  );
}
