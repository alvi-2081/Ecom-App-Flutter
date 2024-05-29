import 'package:ecommerece_app/core/components/product_component.dart';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/features/category/ui/cubit/category_cubit.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  const CategoryScreen({required this.category, super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late GlobalKey<AnimatedListState> productListKey;
  final List<Widget> productTiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryCubit>().getProductsByCategory(widget.category);
    });
    productListKey = GlobalKey<AnimatedListState>();
  }

  void _addProducts(List<Products> products) {
    Future future = Future(() {});
    for (Products product in products) {
      future = future.then((data) {
        return Future.delayed(const Duration(milliseconds: 200), () {
          productTiles.add(ProductComponent(product: product));
          productListKey.currentState?.insertItem(productTiles.length - 1);
        });
      });
    }
  }

  final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        appBar: AppBar(
          backgroundColor: ColorConstants.main,
          title: TextComponent(
            widget.category,
            style: const TextStyle(color: Colors.white),
          ),
          leading: InkWell(
              onTap: () => NavigationUtil.pop(context,
                  previousScreen: RouteConstants.categoryScreen),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            productTiles.clear();
            _addProducts(state.products);
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state.isLoading)
                    const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))
                  else if (state.products.isNotEmpty)
                    Expanded(
                        child: AnimatedList(
                            key: productListKey,
                            initialItemCount: productTiles.length,
                            itemBuilder: (context, index, animation) =>
                                SlideTransition(
                                  position: animation.drive(_offset),
                                  child: productTiles[index],
                                )))
                  else
                    const SizedBox(
                        height: 200,
                        child: Center(
                            child: TextComponent('No products Available')))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
