import 'package:ecommerece_app/core/components/category_chip_component.dart';
import 'package:ecommerece_app/core/components/product_component.dart';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/searchfield_component.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/constants/sizedbox_constants.dart';
import 'package:ecommerece_app/core/constants/string_constants.dart';
import 'package:ecommerece_app/core/network/dio_client_network.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/core/utils/sharedpreference_utils.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:ecommerece_app/features/home/ui/cubit/home_cubit.dart';
import 'package:ecommerece_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_debounce/easy_debounce.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TextEditingController searchController;
  late GlobalKey<AnimatedListState> productListKey;
  late GlobalKey<AnimatedListState> searchedProductListKey;

  List<Widget> productTiles = [];
  final List<Widget> searchedProductTiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>()
        ..getAllProducts()
        ..getAllCategories();
    });
    searchController = TextEditingController();
    productListKey = GlobalKey<AnimatedListState>();
    searchedProductListKey = GlobalKey<AnimatedListState>();
  }

  void _addProducts(List<Products> products) {
    Future future = Future(() {});
    for (int i = 0; i < products.length; i++) {
      future = future.then((data) {
        return Future.delayed(const Duration(milliseconds: 200), () {
          productTiles.add(ProductComponent(
              product: products[i],
              onDelete: () =>
                  context.read<HomeCubit>().removeProduct(products[i])));
          productListKey.currentState?.insertItem(productTiles.length - 1);
        });
      });
    }
  }

  void _addSearchedProducts(List<Products> products) {
    Future future = Future(() {});
    for (Products product in products) {
      future = future.then((data) {
        return Future.delayed(const Duration(milliseconds: 200), () {
          searchedProductTiles.add(ProductComponent(product: product));
          searchedProductListKey.currentState
              ?.insertItem(searchedProductTiles.length - 1);
        });
      });
    }
  }

  final Tween<Offset> offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        appBar: AppBar(
          title: const TextComponent(
            StringConstants.ecommerceApp,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  getIt<SharedPreferencesUtil>().removeValue('user');
                  getIt<DioClientNetwork>().changeAuthBaseUrl();
                  NavigationUtil.popAllAndPush(
                      context, RouteConstants.loginScreen);
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ))
          ],
          backgroundColor: ColorConstants.main,
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.isSearched) {
              searchedProductTiles.clear();
              _addSearchedProducts(state.searchedProducts);
            } else {
              searchedProductTiles.clear();
              if (productTiles.isEmpty) {
                _addProducts(state.products);
              } else {
                productListKey = GlobalKey<AnimatedListState>();
                productTiles.clear();
                productTiles = state.products
                    .map((p) => ProductComponent(
                        product: p,
                        onDelete: () =>
                            context.read<HomeCubit>().removeProduct(p)))
                    .toList();
                // _addProducts();
              }
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SearchFieldComponent(
                    searchController,
                    onChanged: (value) {
                      EasyDebounce.debounce(
                          'my-debouncer', const Duration(milliseconds: 500),
                          () {
                        if (value.isNotEmpty) {
                          context.read<HomeCubit>().searchProducts(value);
                        } else {
                          context.read<HomeCubit>().clearSearch();
                        }
                      });
                    },
                  ),
                  SizedBoxConstants.tenH(),
                  if (state.categories.isNotEmpty)
                    Container(
                      height: 40,
                      color: ColorConstants.white,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return CategoryChipComponent(
                              title: state.categories[index],
                            );
                          }),
                    ),
                  SizedBoxConstants.tenH(),
                  if (state.isLoading)
                    const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))
                  else if (state.isSearched &&
                      state.searchedProducts.isNotEmpty)
                    Expanded(
                        child: AnimatedList(
                            key: searchedProductListKey,
                            initialItemCount: searchedProductTiles.length,
                            itemBuilder: (context, index, animation) =>
                                SlideTransition(
                                  position: animation.drive(offset),
                                  child: searchedProductTiles[index],
                                )))
                  else if (!state.isSearched && state.products.isNotEmpty)
                    Expanded(
                        child: AnimatedList(
                            key: productListKey,
                            initialItemCount: productTiles.length,
                            itemBuilder: (context, index, animation) =>
                                SlideTransition(
                                  position: animation.drive(offset),
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
        floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: ColorConstants.main,
            onPressed: () =>
                NavigationUtil.push(context, RouteConstants.addProductScreen),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
    );
  }
}
