import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:mezmaps/feature/home/view_model/mixin/home_mixin.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:gen/gen.dart';
import 'package:mezmaps/product/utility/constant/language/product_string.dart';

part '../widget/home_view_widget.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ProjectString.appName)),
      body: Column(
        children: [
          _logo(),

          /// Mezxarliklar
          _CustomButton(
            /// tekleyebiliriz bakacam cok tekrar ediyor
            logo: Assets.icons.mLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),
            text: ProjectString.cemeteries,
            onPressed: () {},
          ),

          ///Mezarlık Konumları"
          _CustomButton(
            /// tekleyebiliriz bakacam cok tekrar ediyor
            logo: Assets.icons.mkLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),
            text: ProjectString.cemeteryLocations,
            onPressed: () {},
          ),
          _CustomButton(
            logo: Assets.icons.vfLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),
            text: ProjectString.deceasedPeople,
            onPressed: () {},
          ),
          _CustomButton(
            logo: Assets.icons.infoLight.image(
              package: 'gen',
              height: 25,
              width: 25,
            ),
            text: ProjectString.about,
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }
}

// class _mkButton extends StatelessWidget {
//   const _mkButton();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusGeometry.circular(30),
//           ),
//           elevation: 10,
//           shadowColor: Colors.green.withValues(),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Assets.icons.mkLight.image(package: 'gen', height: 25, width: 25),
//             SizedBox(width: 20),
//             Expanded(child: Text("Mezarlık Konumları")),
//             Icon(Icons.arrow_forward_ios_rounded),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _vfButton extends StatelessWidget {
//   const _vfButton();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusGeometry.circular(30),
//           ),
//           elevation: 10,
//           shadowColor: Colors.green.withValues(),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Assets.icons.vfLight.image(package: 'gen', height: 25, width: 25),
//             SizedBox(width: 20),
//             Expanded(child: Text('Vefat Edenler')),
//             Icon(Icons.arrow_forward_ios_rounded),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _infoButton extends StatelessWidget {
//   const _infoButton();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusGeometry.circular(30),
//           ),
//           elevation: 10,
//           shadowColor: Colors.green.withValues(),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Assets.icons.infoLight.image(package: 'gen', height: 25, width: 25),
//             SizedBox(width: 20),
//             Expanded(child: Text("Hakkında")),
//             Icon(Icons.arrow_forward_ios_rounded),
//           ],
//         ),
//       ),
//     );
//   }
// }
