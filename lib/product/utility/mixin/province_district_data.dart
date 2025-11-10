/// Bu mixin, iki seviyeli (il/ilçe gibi) hiyerarşik seçim bileşenleri için
/// gerekli olan veri okuma ve aksiyon tetikleme arayüzünü tanımlar.
///
/// ViewModel'lerin, ProvinceDistrictRow gibi UI bileşenlerine bağımlı olmadan
/// generic bir arayüz sunmasını sağlar.
mixin ProvinceDistrictData<T extends Object> {
  // Veriler

  /// Seçim yapılabilir tüm illerin (üst seviye birimlerin) listesi.
  List<String> get provinceList;

  /// Şu anda seçili olan ilin adıdır.
  String? get selectedProvince;

  /// Seçili ile bağlı olan tüm ilçelerin (alt seviye birimlerin) listesi.
  List<String> get districtList;

  /// Şu anda seçili olan ilçenin adıdır.
  String? get selectedDistrict;

  /// Kullanıcı bir il seçtiğinde veya seçimi temizlediğinde (null) çağrılır.
  /// ViewModel, ilçe listesini yeniden çekmeli ve state'i güncellemelidir.
  Future<void> onProvinceChanged(String? value);

  /// Kullanıcı bir ilçe seçtiğinde veya seçimi temizlediğinde (null) çağrılır.
  /// ViewModel, bu ilçe ile ilgili ana verileri (mezarlık/arama sonuçları vb.) çekmelidir.
  Future<void> onDistrictChanged(String? value);
}
