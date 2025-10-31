import 'package:flutter/material.dart';
import 'package:mezmaps/feature/home/view_model/mixin/home_mixin.dart';
import 'package:mezmaps/product/state/base/base_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: ElevatedButton(onPressed: () {}, child: Text('deniz kamer')),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
