import 'package:equatable/equatable.dart';

// burayi guncellemezsek sayfa guncellenmezfinal class HomeState extends Equatable {
final class HomeState extends Equatable {
  const HomeState({required this.isLoading});

  final bool isLoading;

  // Sayfalasrin dinlemesini istedigimiz proplar

  @override
  List<Object?> get props => [isLoading];

  HomeState copyWith({bool? isLoading}) {
    return HomeState(isLoading: isLoading ?? this.isLoading);
  }
}
