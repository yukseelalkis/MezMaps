import 'package:mezmaps/feature/deaths/view/deaths_view.dart';
import 'package:mezmaps/feature/deaths/view_model/deaths_view_model.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
// State dosyasını import etmeyi unutmayın
import 'package:mezmaps/feature/deaths/view_model/state/deaths_state.dart';

mixin DeathsMixin on BaseState<DeathsView> {
  late final DeathsViewModel _viewModel;
  DeathsViewModel get viewModel => _viewModel;

  @override
  void initState() {
    super.initState();

    // 1. Başlangıç state'i oluşturuluyor (DeathsViewModel constructor'ı bunu bekler)
    const initialState = DeathsState();

    // 2. ViewModel, başlangıç state'i ile başlatılıyor
    _viewModel = DeathsViewModel(initialState);

    // 3. (Opsiyonel ama önerilen) View açılır açılmaz veri yükleme başlatılıyor
    // WidgetsBinding.instance.addPostFrameCallback((_) => _viewModel.load());
    // Veya direkt çağırılabilir, ViewModel'ın içinde setState yoksa sorun çıkmaz:
    _viewModel.load();
  }

  // 4. Bellek sızıntısını önlemek için Cubit/Bloc'u kapatıyoruz
  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }
}
