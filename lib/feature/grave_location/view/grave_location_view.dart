import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';
import 'package:mezmaps/product/widgets/custom_app_bar.dart';

class GraveLocationView extends StatefulWidget {
  const GraveLocationView({super.key});

  @override
  State<GraveLocationView> createState() => _GraveLocationViewState();
}

class _GraveLocationViewState extends State<GraveLocationView> {
  @override
  Widget build(BuildContext context) {
    final gl = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppbar(
        text: ProjectString.cemeteryLocations, 
        widget: Assets.icons.mkLight.image(package: 'gen',width: 35)  
      ),
      
    );
  }
}
