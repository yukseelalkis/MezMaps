import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';

final class GraveSearchState extends Equatable {
  final nameCtrl = TextEditingController();
  final surnameCtrl = TextEditingController();

  final List<Province> provinces;
  final List<District> districts;
  final List<Cemetery> cemeteries;
  final bool isLoading;
  final String? error;
  final String? selectedCemetery;
  final List<GraveResult> results;
  final String? selectedProvince;
  final String? selectedDistrict;

  List<String> get provinceList => provinces.map((e) => e.name).toList();

  List<String> get districtList => districts.map((e) => e.name).toList();

  List<String> get cemeteryList => cemeteries.map((e) => e.name).toList();

  GraveSearchState.initial() : this(isLoading: false);
  GraveSearchState({
    this.isLoading = false,
    this.selectedCemetery,
    this.provinces = const [],
    this.districts = const [],
    this.cemeteries = const [],
    this.results = const [],
    this.error,
    this.selectedProvince,
    this.selectedDistrict,
  });

  GraveSearchState copyWith({
    bool? isLoading,
    String? error,
    String? selectedCemetery, // Burası eksikti, ekledim
    String? selectedProvince,
    String? selectedDistrict,
    List<Province>? provinces,
    List<District>? districts,
    List<Cemetery>? cemeteries,
    List<GraveResult>? results,
  }) {
    return GraveSearchState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      provinces: provinces ?? this.provinces,
      districts: districts ?? this.districts,
      cemeteries: cemeteries ?? this.cemeteries,
      selectedCemetery:
          selectedCemetery ?? this.selectedCemetery, // Burası eklendi
      results: results ?? this.results,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }

  // + props’a ekle
  @override
  List<Object?> get props => [
    isLoading,
    error,
    provinces,
    districts,
    cemeteries,
    results,
    selectedProvince,
    selectedDistrict,
    selectedCemetery, // Burası eklendi
    // nameCtrl ve surnameCtrl, Equatable'ın doğru çalışması için burada olmamalı
    // çünkü TextEditingController'lar mutable nesnelerdir.
    // Ancak dışarıdan erişim için tutulmuşlar.
  ];

  GraveSearchState clearError() => copyWith(error: null);
}
