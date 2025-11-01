import 'package:mezmaps/product/mock/model/mock_model.dart';

const provincesMock = <Province>[
  Province(
    name: 'Hatay',
    districts: [
      District(
        name: 'İskenderun',
        cemeteries: [
          Cemetery('Asri Mezarlık'),
          Cemetery('Asri Mezarlık Eski Kısım'),
          Cemetery('İskenderun Şehitliği'),
          Cemetery('Denizciler Mezarlığı'),
          Cemetery('Modern Evler Mezarlığı'),
        ],
      ),
      District(name: 'Antakya', cemeteries: [Cemetery('Narlıca Mezarlığı')]),
      District(name: 'Defne', cemeteries: [Cemetery('Harbiye Mezarlığı')]),
      District(name: 'Arsuz', cemeteries:  [Cemetery('Arsuz Mezarlığı')]),
      District(name: 'Payas', cemeteries:  [Cemetery('Payas Mezarlığı')]),
      District(name: 'Dörtyol', cemeteries: [Cemetery('Dörtyol Mezarlığı')]),
      District(name: 'Kırıkhan', cemeteries: [Cemetery('Kırıkhan Mezarlığı')]),
    ],
  ),
  Province(
    name: 'Gaziantep',
    districts: [
      District(name: 'Şahinbey'),
      District(name: 'Şehitkamil'),
      District(name: 'Nizip'),
      District(name: 'İslahiye'),
      District(name: 'Oğuzeli'),
    ],
  ),
  Province(
    name: 'Adana',
    districts: [
      District(name: 'Seyhan'),
      District(name: 'Yüreğir'),
      District(name: 'Çukurova'),
      District(name: 'Sarıçam'),
      District(name: 'Ceyhan'),
    ],
  ),
  Province(
    name: 'Kilis',
    districts: [
      District(name: 'Merkez'),
      District(name: 'Elbeyli'),
      District(name: 'Musabeyli'),
      District(name: 'Polateli'),
    ],
  ),
];
