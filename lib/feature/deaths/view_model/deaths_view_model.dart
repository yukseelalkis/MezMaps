import 'package:mezmaps/feature/deaths/view_model/state/deaths_state.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';
import 'package:mezmaps/product/mock/data/mock_grave_result.dart'; // Mock veriyi import ediyoruz

final class DeathsViewModel extends BaseCubit<DeathsState> {
  // Veri çekmek için bir Repository'ye ihtiyacınız olabilir.
  // Şimdilik sadece mock veriyi kullanıyoruz.

  DeathsViewModel(super.initialState);

  Future<void> load() async {
    // 1. Yükleme başlangıcı: isLoading = true yap
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // 2. Veri Çekme Simülasyonu
      // Gerçek bir senaryoda burası Repository üzerinden API çağrısı olurdu.
      await Future.delayed(
        const Duration(seconds: 2),
      ); // 2 saniye bekleme simülasyonu

      final loadedResults = mockGraveResult; // Mock veriyi yüklüyoruz.

      // 3. Başarılı Sonuç: isLoading = false, results güncel
      emit(state.copyWith(isLoading: false, results: loadedResults));
    } catch (e) {
      // 4. Hata Durumu: isLoading = false, error mesajı göster
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Veriler yüklenirken bir hata oluştu: $e',
        ),
      );
    }
  }
}
