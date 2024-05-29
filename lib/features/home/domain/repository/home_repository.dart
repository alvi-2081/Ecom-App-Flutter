import 'package:ecommerece_app/core/constants/http_constants.dart';
import 'package:ecommerece_app/features/home/data/get_products_response_wrapper.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:ecommerece_app/main.dart';
import 'package:ecommerece_app/core/network/dio_api_services.dart';

class HomeRepository {
  Future<List<Products>> getAllProducts() async {
    final response = await getIt<DioApiServices>().getRequest(
      HttpConstants.allProducts,
    );
    return GetProductsResponseWrapper.fromJson(response).products ?? [];
  }

  Future<List> getAlCategories() async {
    final response = await getIt<DioApiServices>().getRequest(
      HttpConstants.allCategories,
    );

    return response.map((e) => e['slug']).toList() as List;
  }

  Future<List<Products>> searchProducts(String query) async {
    final response = await getIt<DioApiServices>().getRequest(
        HttpConstants.searchProducts,
        queryParameters: {'q': query});

    return GetProductsResponseWrapper.fromJson(response).products ?? [];
  }
}
