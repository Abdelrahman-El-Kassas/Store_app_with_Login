import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/cubit/product_cubit.dart';
import 'package:store_app/features/home/cubit/product_states.dart';
import 'package:store_app/features/home/presentation/widgets/product_widget.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(Dio())..getproducts(),

      child: BlocConsumer<ProductsCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<ProductsCubit>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Products",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              centerTitle: true,
              elevation: 0,
            ),

            body: SafeArea(
              child: state is LoadingProduct
                  ? Center(child: CircularProgressIndicator())
                  : state is ProductFailed
                  ? Text(state.errMsg)
                  : state is ProductSuccess
                  ? state.products.isEmpty
                        ? Center(child: Text("No Products yet"))
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11,
                              vertical: 10,
                            ),
                            itemCount: state.products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                  mainAxisExtent: 350,
                                ),
                            itemBuilder: (BuildContext context, int index) {
                              return ProductWidget(
                                productitem: state.products[index],
                              );
                            },
                          )
                  : SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
