import 'package:mezmaps/product/mock/model/mock_model.dart';

const provincesMock = <Province>[
  // =========================
  // HATAY
  // =========================
  Province(
    name: 'Hatay',
    centerLat: 36.2028,
    centerLng: 36.1600,
    districts: [
      District(
        name: 'İskenderun',
        centerLat: 36.5873,
        centerLng: 36.1735,
        cemeteries: [
          Cemetery(name: 'Asri Mezarlık', lat: 36.6032, lng: 36.1751),
          Cemetery(
            name: 'Asri Mezarlık Eski Kısım',
            lat: 36.6022,
            lng: 36.1741,
          ),
          Cemetery(name: 'İskenderun Şehitliği', lat: 36.5850, lng: 36.1780),
          Cemetery(name: 'Denizciler Mezarlığı', lat: 36.6290, lng: 36.1645),
          Cemetery(name: 'Modern Evler Mezarlığı', lat: 36.5905, lng: 36.2001),
        ],
      ),
      District(
        name: 'Antakya',
        centerLat: 36.2066,
        centerLng: 36.1572,
        cemeteries: [
          Cemetery(name: 'Narlıca Mezarlığı', lat: 36.2102, lng: 36.1730),
          Cemetery(name: 'Antakya Asri Mezarlığı', lat: 36.2140, lng: 36.1540),
        ],
      ),
      District(
        name: 'Defne',
        centerLat: 36.1881,
        centerLng: 36.1457,
        cemeteries: [
          Cemetery(name: 'Harbiye Mezarlığı', lat: 36.1749, lng: 36.1434),
        ],
      ),
      District(
        name: 'Arsuz',
        centerLat: 36.3979,
        centerLng: 35.9020,
        cemeteries: [
          Cemetery(name: 'Arsuz Mezarlığı', lat: 36.3985, lng: 35.9054),
        ],
      ),
      District(
        name: 'Payas',
        centerLat: 36.7561,
        centerLng: 36.2033,
        cemeteries: [
          Cemetery(name: 'Payas Mezarlığı', lat: 36.7565, lng: 36.2059),
        ],
      ),
      District(
        name: 'Dörtyol',
        centerLat: 36.8398,
        centerLng: 36.2293,
        cemeteries: [
          Cemetery(name: 'Dörtyol Mezarlığı', lat: 36.8401, lng: 36.2311),
        ],
      ),
      District(
        name: 'Kırıkhan',
        centerLat: 36.4986,
        centerLng: 36.3575,
        cemeteries: [
          Cemetery(name: 'Kırıkhan Mezarlığı', lat: 36.4967, lng: 36.3602),
        ],
      ),
    ],
  ),

  // =========================
  // GAZİANTEP
  // =========================
  Province(
    name: 'Gaziantep',
    centerLat: 37.0662,
    centerLng: 37.3833,
    districts: [
      District(
        name: 'Şehitkamil',
        centerLat: 37.0900,
        centerLng: 37.3950,
        cemeteries: [
          Cemetery(name: 'Asri Mezarlık', lat: 37.089973, lng: 37.403481),
        ],
      ),
      District(
        name: 'Şahinbey',
        centerLat: 37.0100,
        centerLng: 37.4200,
        cemeteries: [
          Cemetery(name: 'Yeşilkent Mezarlığı', lat: 37.011166, lng: 37.416100),
        ],
      ),
      District(
        name: 'Nizip',
        centerLat: 37.0090,
        centerLng: 37.7950,
        cemeteries: [
          Cemetery(name: 'Nizip Mezarlığı', lat: 37.0099, lng: 37.7877),
        ],
      ),
      District(
        name: 'İslahiye',
        centerLat: 37.0250,
        centerLng: 36.6339,
        cemeteries: [
          Cemetery(name: 'İslahiye Mezarlığı', lat: 37.0333, lng: 36.6290),
        ],
      ),
      District(
        name: 'Oğuzeli',
        centerLat: 36.9636,
        centerLng: 37.5142,
        cemeteries: [
          Cemetery(name: 'Oğuzeli Mezarlığı', lat: 36.9621, lng: 37.5159),
        ],
      ),
    ],
  ),

  // =========================
  // ADANA
  // =========================
  Province(
    name: 'Adana',
    centerLat: 37.0000,
    centerLng: 35.3213,
    districts: [
      District(
        name: 'Seyhan',
        centerLat: 36.9900,
        centerLng: 35.3200,
        cemeteries: [
          Cemetery(
            name: 'Akkapı (Asri) Mezarlığı',
            lat: 36.95389,
            lng: 35.30611,
          ),
        ],
      ),
      District(
        name: 'Sarıçam',
        centerLat: 37.0700,
        centerLng: 35.4000,
        cemeteries: [
          Cemetery(name: 'Buruk Mezarlığı', lat: 37.04111, lng: 35.43556),
        ],
      ),
      District(
        name: 'Çukurova',
        centerLat: 37.0550,
        centerLng: 35.3000,
        cemeteries: [
          Cemetery(name: 'Kabasakal Mezarlığı', lat: 37.05583, lng: 35.20583),
        ],
      ),
      District(
        name: 'Yüreğir',
        centerLat: 37.0050,
        centerLng: 35.3600,
        cemeteries: [
          Cemetery(name: 'Yakapınar Mezarlığı', lat: 37.0195, lng: 35.4990),
        ],
      ),
      District(
        name: 'Ceyhan',
        centerLat: 37.0220,
        centerLng: 35.8100,
        cemeteries: [
          Cemetery(name: 'Ceyhan Asri Mezarlığı', lat: 37.0266, lng: 35.8267),
        ],
      ),
    ],
  ),

  // =========================
  // KİLİS
  // =========================
  Province(
    name: 'Kilis',
    centerLat: 36.7165,
    centerLng: 37.1150,
    districts: [
      District(
        name: 'Merkez',
        centerLat: 36.7165,
        centerLng: 37.1150,
        cemeteries: [
          Cemetery(
            name: 'Kilis Asri Mezarlığı',
            lat: 36.718288,
            lng: 37.130402,
          ),
        ],
      ),
      District(
        name: 'Polateli',
        centerLat: 36.8395,
        centerLng: 37.1030,
        cemeteries: [
          Cemetery(name: 'Polateli Mezarlığı', lat: 36.8395, lng: 37.1030),
        ],
      ),
      District(
        name: 'Elbeyli',
        centerLat: 36.6500,
        centerLng: 37.2500,
        cemeteries: [
          Cemetery(name: 'Elbeyli Mezarlığı', lat: 36.6500, lng: 37.2525),
        ],
      ),
      District(
        name: 'Musabeyli',
        centerLat: 36.7800,
        centerLng: 37.1500,
        cemeteries: [
          Cemetery(name: 'Musabeyli Mezarlığı', lat: 36.7830, lng: 37.1570),
        ],
      ),
    ],
  ),
];
