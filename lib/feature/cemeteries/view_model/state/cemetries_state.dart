import 'package:equatable/equatable.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';

final class CemetriesState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<Province> provinces;
  final List<District> districts;
  final List<Cemetery> cemeteries;
  final String? selectedProvince;
  final String? selectedDistrict;

  List<String> get provinceList => provinces.map((e) => e.name).toList();

  List<String> get districtList => districts.map((e) => e.name).toList();

  List<String> get cemeteryList => cemeteries.map((e) => e.name).toList();

  const CemetriesState.initial() : this(isLoading: false);
  const CemetriesState({
    required this.isLoading,
    this.error,
    this.provinces = const [],
    this.districts = const [],
    this.cemeteries = const [],
    this.selectedProvince,
    this.selectedDistrict,
  });

  @override
  List<Object?> get props => [
    isLoading,
    error,
    provinces,
    districts,
    cemeteries,
    selectedProvince,
    selectedDistrict,
  ];

  CemetriesState copyWith({
    bool? isLoading,
    String? error,
    List<Province>? provinces,
    List<District>? districts,
    List<Cemetery>? cemeteries,
    String? selectedProvince,
    String? selectedDistrict,
  }) {
    return CemetriesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      provinces: provinces ?? this.provinces,
      districts: districts ?? this.districts,
      cemeteries: cemeteries ?? this.cemeteries,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }

  CemetriesState clearError() => copyWith(error: null);
}
