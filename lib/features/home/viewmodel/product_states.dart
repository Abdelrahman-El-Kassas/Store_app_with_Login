import 'package:store_app/features/home/data/models/product_model.dart';

abstract class ProductStates {}

class InitialProduct extends ProductStates {}

class LoadingProduct extends ProductStates {}

class ProductFailed extends ProductStates {
  final String errMsg;
  ProductFailed({required this.errMsg});
}

class ProductSuccess extends ProductStates {
  List<ProductModel> products = [];
  ProductSuccess({required this.products});
}
