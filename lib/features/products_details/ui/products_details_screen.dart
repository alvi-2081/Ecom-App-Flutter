import 'package:ecommerece_app/core/components/network_image_component.dart';
import 'package:ecommerece_app/core/components/rating_bar_component.dart';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/constants/sizedbox_constants.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_constant.dart';

class ProductsDetailsScreen extends StatefulWidget {
  final Products product;
  const ProductsDetailsScreen({required this.product, super.key});

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetailsScreenState();
}

class _ProductsDetailsScreenState extends State<ProductsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.main,
        title: TextComponent(
          widget.product.brand,
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
            onTap: () => NavigationUtil.pop(context,
                previousScreen: RouteConstants.categoryScreen),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 340,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.images?.length,
                itemBuilder: (BuildContext context, int index) {
                  return NetworkImageComponent(
                    url: widget.product.images?[index],
                    width: MediaQuery.of(context).size.width,
                    height: 340,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                      widget.product.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    TextComponent(
                      ' \$${widget.product.price}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                  ],
                ),
                RatingsBarComponent(
                  rating: widget.product.rating,
                  size: 18,
                ),
                SizedBoxConstants.tenH(),
                TextComponent("Stock : ${widget.product.stock}"),
                SizedBoxConstants.twentyH(),
                TextComponent(
                  widget.product.description,
                  maxLines: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
