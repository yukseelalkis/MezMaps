import 'package:mezmaps/product/mock/model/grave_result.dart';

final mockGraveResult = <GraveResult>[
  // Hatay / İskenderun / Asri Mezarlık (listede var)
  const GraveResult(
    name: 'Yüksel ',
    surname: 'Alkış',
    age: 26,
    burialPlace: 'K-1309',
    deathDate: '13.05.2025',
    burialDate: '13.05.2025',
    city: 'Hatay',
    district: 'İskenderun',
    cemeteriesName: 'Asri Mezarlık',
  ),

  // Gaziantep / Şahinbey / Yeşilkent Mezarlığı (listede var)
  const GraveResult(
    name: 'Deniz',
    surname: 'Çelik',
    age: 21,
    burialPlace: 'B-777',
    deathDate: '03.07.2011',
    burialDate: '03.07.2011',
    city: 'Gaziantep',
    district: 'Şahinbey',
    cemeteriesName: 'Yeşilkent Mezarlığı',
  ),
];
