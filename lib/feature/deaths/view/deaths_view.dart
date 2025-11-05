import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/feature/grave_location/view/grave_location_view.dart';
import 'package:mezmaps/product/widgets/custom_app_bar.dart';
import 'package:mezmaps/feature/home/view/home_view.dart'; // BottomBar buradan geliyor

class DeathsPage extends StatefulWidget {
  const DeathsPage({super.key});

  @override
  State<DeathsPage> createState() => _DeathsPageState();
}

class _DeathsPageState extends State<DeathsPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<Grave> _filteredList;

  final List<Grave> _deceasedList = const [
    Grave(
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
    Grave(
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
    Grave(
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
    Grave(
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
  void initState() {
    super.initState();
    _filteredList = _deceasedList;
  }

  void _search() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredList = _deceasedList
          .where(
            (g) =>
                g.ad.toLowerCase().contains(query) ||
                g.soyad.toLowerCase().contains(query),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppbar(
        text: "Vefat Edenler",
        widget: Assets.icons.mkLight.image(package: 'gen', width: 35),
      ),
      body: Padding(
        padding: PaddingManager.normalPaddingAll(context),
        child: Column(
          children: [
            // 🔍 Arama Alanı + Buton
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "İsimle ara...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _search,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Mevcut Kart Listesi
            Expanded(
              child: ListView.builder(
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  final g = _filteredList[index];
                  return _buildGraveCard(context, g, cs);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _buildGraveCard(BuildContext context, Grave g, ColorScheme cs) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            const SizedBox(height: 8),
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
