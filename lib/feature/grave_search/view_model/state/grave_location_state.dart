import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/product/mock/model/grave_result.dart';

final class GraveSearchState extends Equatable {
  final nameCtrl = TextEditingController();
  final surnameCtrl = TextEditingController();
  final String? selectedProvince;
  final String? selectedDistrict;
  final List<String> provinceList;
  final List<String> districtList;
  final List<String> cemeteryList;

  final bool isLoading;
  final String? selectedCemetery;
  final List<GraveResult> results;

  GraveSearchState({
    this.isLoading = false,
    this.selectedCemetery,
    this.selectedProvince,
    this.selectedDistrict,
    this.provinceList = const [],
    this.districtList = const [],
    this.cemeteryList = const [],
    this.results = const [],
  });

  GraveSearchState copyWith({
    bool? isLoading,
    String? selectedCemetery,
    String? selectedProvince,
    String? selectedDistrict,
    List<String>? provinceList,
    List<String>? districtList,
    List<String>? cemeteryList,
    List<GraveResult>? results,
  }) {
    return GraveSearchState(
      isLoading: isLoading ?? this.isLoading,
      selectedCemetery: selectedCemetery ?? this.selectedCemetery,
      results: results ?? this.results,
      provinceList: provinceList ?? this.provinceList,
      districtList: districtList ?? this.districtList,
      cemeteryList: cemeteryList ?? this.cemeteryList,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }

  // + props’a ekle
  @override
  List<Object?> get props => [
    isLoading,
    selectedProvince,
    selectedDistrict,
    selectedCemetery,
    provinceList,
    districtList,
    cemeteryList,
    results,
  ];
}
