import 'package:bloc/bloc.dart';
import 'package:ecommerece_app/core/components/toast_component.dart';
import 'package:ecommerece_app/core/constants/string_constants.dart';
import 'package:ecommerece_app/features/add_product/domain/repository/add_product_repository.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:ecommerece_app/features/home/ui/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductRepository addproductRepository;
  AddProductCubit(this.addproductRepository) : super(AddProductState.empty());

  Future<void> addProduct(Map body, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    final product = await addproductRepository.addProduct(body);
    context.read<HomeCubit>().addProduct(
          product.copyWith(
              rating: 4.5,
              stock: 50,
              category: "smartphones",
              thumbnail:
                  "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
              images: [
                "https://cdn.dummyjson.com/product-images/1/1.jpg",
                "https://cdn.dummyjson.com/product-images/1/2.jpg",
                "https://cdn.dummyjson.com/product-images/1/3.jpg",
                "https://cdn.dummyjson.com/product-images/1/4.jpg",
                "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
              ]),
        );
    ToastComponent.show(StringConstants.productAddedSuccessfully);
    emit(state.copyWith(product: product, isLoading: false));
  }
}
