import 'package:flutter/material.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';

class GraveSearchPage extends StatefulWidget {
  const GraveSearchPage({super.key});
  @override
  State<GraveSearchPage> createState() => _GraveSearchPageState();
}

class _GraveSearchPageState extends State<GraveSearchPage> {
  final _ad = TextEditingController();
  final _soyad = TextEditingController();
  final _mezarliklar = const ['Asri Mezarlık', 'Yeşilkent Mezarlığı'];
  String? _mezarlik = 'Asri Mezarlık';

  final List<_Grave> _all = const [
    _Grave(
      'Deniz',
      'Çelik',
      21,
      '13.05.2025',
      'K-1309',
      'Asri Mezarlık',
      "Esra",
      "BİLO BABA",
    ),
    _Grave(
      'Yüksel',
      'Alkış',
      24,
      '03.07.2011',
      'B-777',
      'Yeşilkent Mezarlığı',
      "Saliha",
      "Murat",
    ),
    _Grave(
      'Ayşe',
      'Yılmaz',
      68,
      '01.04.2020',
      'C-12',
      'Yeşilkent Mezarlığı',
      "Esma",
      "Ali",
    ),
    _Grave(
      "Eren",
      "Selli",
      31,
      "22.10.2024",
      "K-1910",
      "Asri Mezarlık",
      "Arzu",
      "Şükrü",
    ),
  ];
  late List<_Grave> _result = List.of(_all);

  void _search() {
    final a = _ad.text.trim().toLowerCase();
    final s = _soyad.text.trim().toLowerCase();
    final m = _mezarlik;
    setState(() {
      _result = _all.where((g) {
        final adOk = a.isEmpty || g.ad.toLowerCase().contains(a);
        final soOk = s.isEmpty || g.soyad.toLowerCase().contains(s);
        final meOk = m == null || g.mezarlik == m;
        return adOk && soOk && meOk;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('MEZAR KONUMU'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _ad,
            decoration: const InputDecoration(
              labelText: 'Ad Yazınız',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _soyad,
            decoration: const InputDecoration(
              labelText: 'Soyad Yazınız',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _mezarlik,
                  decoration: const InputDecoration(
                    labelText: 'Mezarlık',
                    border: OutlineInputBorder(),
                  ),
                  items: _mezarliklar
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _mezarlik = v),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 56,
                width: 56,
                child: FilledButton(
                  onPressed: _search,
                  child: const Icon(Icons.search),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Kayıtlı Mezar Sayısı: ${_result.length}',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          ..._result.map((g) => _GraveCard(g)).toList(),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class _GraveCard extends StatelessWidget {
  const _GraveCard(this.g, {super.key});
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
          width: 4.0, // burayı değiştirerek kalınlığı artırabilirsin
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${g.ad} ${g.soyad}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.green.shade800,
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
                _kv('Vefat Tarihi:', g.definTarihi),
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
  final String ad, soyad, definTarihi, definYeri, mezarlik, anneAdi, babaAdi;
  final int yas;
  const _Grave(
    this.ad,
    this.soyad,
    this.yas,
    this.definTarihi,
    this.definYeri,
    this.mezarlik,
    this.anneAdi,
    this.babaAdi,
  );
}
