import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/custom_app_bar.dart';

class GraveSearchPage extends StatefulWidget {
  const GraveSearchPage({super.key});
  @override
  State<GraveSearchPage> createState() => _GraveSearchPageState();
}

class _GraveSearchPageState extends State<GraveSearchPage> {
  final _ad = TextEditingController();
  final _soyad = TextEditingController();
  final _anneAdi = TextEditingController();
  final _babaAdi = TextEditingController();
  final _mezarliklar = const ['Asri Mezarlık', 'Yeşilkent Mezarlığı'];
  String? _mezarlik = null;

  final List<_Grave> _all = const [
    _Grave(
      'Deniz',
      'Çelik',
      21,
      '13.05.2025',
      '13.05.2025',
      'A-13',
      'Asri Mezarlık',
      "Esra",
      "BİLO BABA",
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
      'İMAM-I AZAM',
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
  late List<_Grave> _result = List.of(_all);

  // yazdıgımız isimleri ekranda gösteren kısım
  void _search() {
    final a = _ad.text.trim().toLowerCase();
    final s = _soyad.text.trim().toLowerCase();
    final aa = _anneAdi.text.trim().toLowerCase();
    final ba = _babaAdi.text.trim().toLowerCase();
    final m = _mezarlik;
    setState(() {
      _result = _all.where((g) {
        final adOk = a.isEmpty || g.ad.toLowerCase().contains(a);
        final soOk = s.isEmpty || g.soyad.toLowerCase().contains(s);
        final aa0k = aa.isEmpty || g.anneAdi.toLowerCase().contains(aa);
        final baOk = ba.isEmpty || g.babaAdi.toLowerCase().contains(ba);
        final meOk = m == null || g.mezarlik == m;
        return adOk && soOk && aa0k && baOk && meOk;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gl = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.cemeteryLocations,
        widget: Assets.icons.mkLight.image(package: 'gen', width: 35),
      ),
      body: Padding(
        padding: PaddingManager.normalPaddingAll(context),
        child: ListView(
          children: [
            SizedBox(height: 4),
            TextField(
              controller: _ad,
              decoration: const InputDecoration(
                labelText: 'Ad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _soyad,
              decoration: const InputDecoration(
                labelText: 'Soyad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _anneAdi,
              decoration: const InputDecoration(
                labelText: 'Anne Adı',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _babaAdi,
              decoration: const InputDecoration(
                labelText: 'Baba Adı',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _mezarlik,
                        hint: const Text('Mezarlık seçiniz'),
                        decoration: const InputDecoration(
                          labelText: 'Mezarlık',
                          border: OutlineInputBorder(),
                        ),
                        items: _mezarliklar
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _mezarlik = v),
                      ),
                      if (_mezarlik != null)
                        Positioned(
                          right: 25,
                          child: IconButton(
                            // buraya assetsden çağırılacak iconları ekledim beceremedim
                            icon: const Icon(Icons.close, size: 20),
                            color: Theme.of(context).colorScheme.primary,
                            tooltip: 'Seçimi temizle',
                            onPressed: () => setState(() => _mezarlik = null),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 56,
                  width: 56,
                  child: FilledButton(
                    onPressed: _search,
                    child: Icon(Icons.search_outlined),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Kayıtlı Mezar Sayısı: ${_result.length}',
              style: TextStyle(color: gl.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            ..._result.map((g) => _GraveCard(g)).toList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class _GraveCard extends StatelessWidget {
  const _GraveCard(this.g);
  final _Grave g;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: cs.outline,
          width: 3.0, // burayı değiştirerek kalınlığı artırabilirsin
        ),
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
                color: Theme.of(context).colorScheme.primary,
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
                _kv('Defin:', g.definTarihi),
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _kv('Anne Adı:', g.anneAdi),
                _kv('Baba Adı:', g.babaAdi),
              ],
            ),
          ],
        ),
      ),
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
