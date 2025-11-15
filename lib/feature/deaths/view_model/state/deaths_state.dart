// package:mezmaps/feature/deaths/view_model/state/deaths_state.dart
import 'package:equatable/equatable.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';

final class DeathsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<GraveResult> results;

  const DeathsState({
    this.isLoading = false,
    this.error,
    this.results = const [],
  });

  DeathsState copyWith({
    bool? isLoading,
    String? error,
    List<GraveResult>? results,
  }) {
    return DeathsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, results];
}
