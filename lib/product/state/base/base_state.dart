import 'package:flutter/material.dart';
import 'package:mezmaps/product/state/container/produt_state_item.dart';
import 'package:mezmaps/product/state/view_model/product_view_model.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// Service entegrasyonu sonra olacak
  ///
  ///
  //DI dan cektigimiz yer
  // ProductServiceManager get productServiceManager =>
  //     ProductStateItem.productServiceManager;
  // // injection yaptigimiz kisimlar bunlar
  ProductViewModel get productViewModel => ProductStateItem.productViewModel;
}


//  ProdutStateItem.serviceManager.listenErrorState(
      //onErrorStatus: _errorManager.handle,
