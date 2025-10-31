import 'package:mezmaps/feature/home/home_view.dart';
import 'package:mezmaps/feature/home/view_model/home_view_model.dart';
import 'package:mezmaps/product/state/base/base_state.dart';

mixin HomeViewMixin on BaseState<HomeView> {
  late final HomeViewModel _homeViewModel;
  HomeViewModel get homeViewModel => _homeViewModel;
  @override
  void initState() {
    super.initState();

    // önce errorManager'ı initialize et

    // _homeViewModel = HomeViewModel(
    //   authoperation: LoginService(ProdutStateItem.serviceManager),
    // );
    // abstaract olarak kurdugumuz yapidasn cagirdik kardes DI ya uygun oldu
    _homeViewModel = HomeViewModel();
    // en son error listener'ı bağla
    // Bu durum genellikle her zxaman kullanabiliriz her seyde tekrar tekrar
    /// uretmek yerine biz bunun yerine base state olusuturo oradan cekecez.
    // ProductStateItem.productServiceManager.listenErrorState(
    //   onErrorStatus: _errorManager.handle,
    // );
  }
}
