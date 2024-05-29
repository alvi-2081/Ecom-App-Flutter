import 'package:ecommerece_app/features/home/domain/entities/products.dart';

class GetProductsByCategoryResponseWrapper {
  GetProductsByCategoryResponseWrapper({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  GetProductsByCategoryResponseWrapper.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v).toDomain());
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;
  GetProductsByCategoryResponseWrapper copyWith({
    List<Products>? products,
    int? total,
    int? skip,
    int? limit,
  }) =>
      GetProductsByCategoryResponseWrapper(
        products: products ?? this.products,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }
}
