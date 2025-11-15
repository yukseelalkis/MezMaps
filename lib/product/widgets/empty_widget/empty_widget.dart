import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';

@immutable
final class EmptyResults extends StatelessWidget {
  const EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingManager.morePaddingAll(context),
      child: Text(ProjectString.errorMessage, textAlign: TextAlign.center),
    );
  }
}
