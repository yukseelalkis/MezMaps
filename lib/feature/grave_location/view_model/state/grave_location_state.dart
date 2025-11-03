import 'package:equatable/equatable.dart';

final class GraveLocationState extends Equatable {
  final bool isLoading;
  final String? selectedCemetery;
  final List<GraveResult> results;

  const GraveLocationState({
    this.isLoading = false,
    this.selectedCemetery,
    this.results = const [],
  });

  GraveLocationState copyWith({
    bool? isLoading,
    String? selectedCemetery,
    List<GraveResult>? results,
  }) {
    return GraveLocationState(
      isLoading: isLoading ?? this.isLoading,
      selectedCemetery: selectedCemetery ?? this.selectedCemetery,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [isLoading, selectedCemetery, results];
}

final class GraveResult {
  final String name;
  final int age;
  final String burialPlace;   // K-1309 gibi
  final String deathDate;     // 13.05.2025
  final String burialDate;    // 13.05.2025

  const GraveResult({
    required this.name,
    required this.age,
    required this.burialPlace,
    required this.deathDate,
    required this.burialDate,
  });
}
