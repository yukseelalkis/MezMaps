import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';
import 'package:mezmaps/product/mock/model/mock_model.dart';

final class GraveSearchState extends Equatable {
  // Controller'lar ctor'dan gelir; copyWith'te aynı instance korunur.
  final TextEditingController nameCtrl;
  final TextEditingController surnameCtrl;

  final List<Province> provinces;
  final List<District> districts;
  final List<Cemetery> cemeteries;

  final bool isLoading;
  final String? error;

  final String? selectedCemetery;
  final List<GraveResult> results;
  final String? selectedProvince;
  final String? selectedDistrict;

  final bool autovalidate;

  List<String> get provinceList => provinces.map((e) => e.name).toList();
  List<String> get districtList => districts.map((e) => e.name).toList();
  List<String> get cemeteryList => cemeteries.map((e) => e.name).toList();

  // INITIAL: controller'ları burada bir kez yarat
  GraveSearchState.initial()
    : this(
        nameCtrl: TextEditingController(),
        surnameCtrl: TextEditingController(),
        isLoading: false,
      );

  const GraveSearchState({
    required this.nameCtrl,
    required this.surnameCtrl,
    this.autovalidate = false,
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

  bool get hasAnyFilter =>
      nameCtrl.text.trim().isNotEmpty ||
      surnameCtrl.text.trim().isNotEmpty ||
      selectedProvince != null ||
      selectedDistrict != null;

  GraveSearchState copyWith({
    bool? isLoading,
    bool? autovalidate,
    String? error,
    String? selectedCemetery,
    String? selectedProvince,
    String? selectedDistrict,
    List<Province>? provinces,
    List<District>? districts,
    List<Cemetery>? cemeteries,
    List<GraveResult>? results,
    // NOT: controller değiştirmeye ihtiyaç yok; aynı instance kalsın
  }) {
    return GraveSearchState(
      nameCtrl: nameCtrl,
      surnameCtrl: surnameCtrl,
      autovalidate: autovalidate ?? this.autovalidate,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error, // <- önceki değeri koru
      provinces: provinces ?? this.provinces,
      districts: districts ?? this.districts,
      cemeteries: cemeteries ?? this.cemeteries,
      selectedCemetery: selectedCemetery ?? this.selectedCemetery,
      results: results ?? this.results,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }

  @override
  List<Object?> get props => [
    // Controller'ları props'a KATMAYALIM
    isLoading,
    autovalidate,
    error,
    provinces,
    districts,
    cemeteries,
    results,
    selectedProvince,
    selectedDistrict,
    selectedCemetery,
  ];

  GraveSearchState clearError() => copyWith(error: null);
}
