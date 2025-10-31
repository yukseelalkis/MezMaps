import 'package:flutter/material.dart';
import 'package:mezmaps/feature/home/view_model/mixin/home_mixin.dart';
import 'package:mezmaps/product/state/base/base_state.dart';
import 'package:common/common.dart';
import 'package:gen/gen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 100, // Yüksekliği azaltır, 30-40 genelde ideal olur
          child: Assets.images.logo.image(
            package: 'gen',
            fit: BoxFit.contain, // Taşmadan ölçeklensin
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
