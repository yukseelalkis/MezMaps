import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//MountedMixin<T extends StatefulWidget> → Generic bir mixin. T tipi
//StatefulWidget’tan türemek zorunda.
//on State<T> → Bu mixin yalnızca State<T> sınıflarına eklenebilir.
//Yani StatefulWidget’ın State’i içinde kullanılmak üzere tasarlanmış.
mixin MountedMixin<T extends StatefulWidget> on State<T> {
  Future<void> safsafeOperatione(AsyncCallback callback) async {
    //  widget kaldırılmışsa hiçbir şey yapma, hatadan kurtul.
    if (!mounted) return;
    await callback.call();
  }
}
