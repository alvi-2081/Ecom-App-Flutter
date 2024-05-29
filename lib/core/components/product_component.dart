import 'package:ecommerece_app/core/components/network_image_component.dart';
import 'package:ecommerece_app/core/components/rating_bar_component.dart';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:flutter/material.dart';

class ProductComponent extends StatelessWidget {
  final Products? product;
  final Function()? onDelete;
  const ProductComponent({required this.product, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationUtil.push(
          context, RouteConstants.productsDetailsScreen,
          args: product),
      child: Container(
        height: 105,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: ColorConstants.background,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            FittedBox(
                fit: BoxFit.scaleDown,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  child: NetworkImageComponent(
                    url: product?.thumbnail,
                    width: 105,
                    height: 105,
                  ),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: TextComponent(
                        product?.title ?? '',
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextComponent(
                      product?.category ?? '',
                      style: const TextStyle(
                          fontSize: 11, color: ColorConstants.grey),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RatingsBarComponent(rating: product?.rating),
                        const TextComponent(
                          " (4) Reviews",
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                    TextComponent(
                      '${product?.price}\$',
                    ),
                  ],
                ),
              ),
            ),
            if (onDelete != null)
              InkWell(
                  onTap: onDelete,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: ColorConstants.grey,
                      size: 20,
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
