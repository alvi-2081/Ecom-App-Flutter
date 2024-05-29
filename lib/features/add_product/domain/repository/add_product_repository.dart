import 'package:ecommerece_app/core/constants/http_constants.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:ecommerece_app/main.dart';
import 'package:ecommerece_app/core/network/dio_api_services.dart';

class AddProductRepository {
  Future<Products> addProduct(Map body) async {
    final response = await getIt<DioApiServices>()
        .postRequest(HttpConstants.addProduct, data: body);
    return Products.fromJson(response);
  }
}
