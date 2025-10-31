/*
Dependency Injection, bir sınıfın ihtiyaç duyduğu bağımlılıkları (dependency)
kendi içinde oluşturmadan, dışarıdan alması prensibidir. Yani sınıf “ben şunu 
kullanacağım” demez, “bana şunu ver” der. Bu sayede:
Kod daha esnek olur.
Test etmesi kolaylaşır (mock/fake sınıf vermek kolay olur).
Bağımlılıklar gevşer (loose coupling).
*/
/*
get_it Flutter/Dart’ta bir service locator paketidir. Yani uygulamadaki 
servisleri, repository’leri, ViewModel’leri tek bir merkezden yönetmeni ve 
istediğin yerden çağırmanı sağlar. Dependency Injection gibi çalışır ama
 container yönetimini kolaylaştırır.
 */

import 'package:get_it/get_it.dart';
import 'package:mezmaps/product/state/view_model/product_view_model.dart';
// Globalde kullanmak istediklerimiz diyebilriz

final class ProductContainer {
  ProductContainer._();

  static final _instance = GetIt.I;

  static void setup() {
    _instance.registerSingleton<ProductViewModel>(ProductViewModel());
  }

  // Her yerden hızlı erişim için.
  static T read<T extends Object>() => _instance<T>();
}
