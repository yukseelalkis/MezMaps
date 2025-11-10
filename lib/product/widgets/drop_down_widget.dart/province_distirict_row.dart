import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/product/utility/mixin/province_district_data.dart';

@immutable
final class ProvinceDistrictRow<T extends Object> extends StatelessWidget {
  const ProvinceDistrictRow({
    super.key,
    required this.province,
    required this.district,
    required this.dataManager,
  });
  final ProvinceDistrictData dataManager;
  final String province;
  final String district;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // İL
        Expanded(
          child: CustomDropdownField(
            labelText: province,
            items: dataManager.provinceList,
            value: dataManager.selectedProvince,
            onChanged: (v) {
              if (v != null) dataManager.onProvinceChanged(v);
            },
          ),
        ),

        // İLÇE
        Expanded(
          child: Padding(
            padding: PaddingManager.lessPaddingAll(context),
            child: CustomDropdownField(
              labelText: district,
              items: dataManager.districtList,
              value: dataManager.selectedDistrict,
              onChanged: (v) {
                if (v != null) dataManager.onDistrictChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}
