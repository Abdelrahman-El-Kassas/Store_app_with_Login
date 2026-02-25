import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/cubit/product_states.dart';
import 'package:store_app/features/home/data/models/product_model.dart';

class ProductsCubit extends Cubit<ProductStates> {
  ProductsCubit(this.dio) : super(InitialProduct());

  final Dio dio;
  List<ProductModel> products = [];
Future<void>  getproducts() async {
    emit(LoadingProduct());
    try {
      final res = await dio.get('https://dummyjson.com/products');
      if (res.statusCode == 200) {
        for (var product in res.data['products']) {
          products.add(ProductModel.fromJson(product));
        }
        emit(ProductSuccess(products: products));
      } else {
        emit(ProductFailed(errMsg: "Error Status Code!\n Please try Again"));
      }
    } catch (e) {
      emit(ProductFailed(errMsg: "Somehting Wrong! \n ${e.toString()} "));
    }
  }
}
