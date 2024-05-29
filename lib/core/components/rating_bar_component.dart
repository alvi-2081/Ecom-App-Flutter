import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class RatingsBarComponent extends StatelessWidget {
  final double? rating;
  final double? size;
  const RatingsBarComponent({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    int integerRating = rating != null ? rating!.round() : 0;
    return Row(
        children: List.generate(5, (index) {
      if (index < integerRating) {
        return Icon(
          Icons.star,
          color: Colors.orange,
          size: size,
        );
      } else {
        return Icon(
          Icons.star_border,
          color: ColorConstants.grey,
          size: size,
        );
      }
    }));
  }
}
