import 'package:ecommerece_app/core/constants/http_constants.dart';
import 'package:ecommerece_app/features/category/data/get_products_by_category_response_wrapper.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:ecommerece_app/main.dart';
import 'package:ecommerece_app/core/network/dio_api_services.dart';

class CategoryRepository {
  Future<List<Products>> getProductsByCategory(String category) async {
    final response = await getIt<DioApiServices>().getRequest(
      HttpConstants.productsByCategory + category,
    );
    return GetProductsByCategoryResponseWrapper.fromJson(response).products ??
        [];
  }
}
