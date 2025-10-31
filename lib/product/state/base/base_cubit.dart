import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T extends Object> extends Cubit<T> {
  BaseCubit(super.initialState);
  @override
  void emit(T state) {
    /// BURADAKI amac su biz simdi bu katmani yaptiktan sonraki kazancimiz su
    /// yeni bir sayfaya gecince
    ///
    /// iligli widget vs sayfa egerki giderse kaybolursa vs  buna geri donmesine
    /// gerek kalmicak
    if (isClosed) return;
    super.emit(state);
  }
}
