import 'package:mezmaps/feature/home/view_model/state/home_state.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';

final class HomeViewModel extends BaseCubit<HomeState> {
  HomeViewModel() : super(HomeState(isLoading: false));
  
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }
}
