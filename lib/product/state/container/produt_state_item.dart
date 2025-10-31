import 'package:mezmaps/product/state/container/product_state_container.dart';
import 'package:mezmaps/product/state/view_model/product_view_model.dart';

// Glovbalde kullanacagimiz
final class ProductStateItem {
  const ProductStateItem._();
  // Projenin her yerinde kullancagimiz katmanlari vs buradas tanimlayabiliriz.
  // static ProductServiceManager get productServiceManager =>
  //     ProductContainer.read<ProductServiceManager>();

  /// ben burayi DI UYGUN YAPTIGIMDAN dolayi orada yaptigim degisikleri burada
  /// yapmam lazim
  ///
  /// productview modeli  product Containeri dinliyor
  static ProductViewModel get productViewModel =>
      ProductContainer.read<ProductViewModel>();

  /// Eklenecel
  /// Cache  islemlri icin DI yaptik
  // static ProductCache get productCache => ProductContainer.read<ProductCache>();
}
