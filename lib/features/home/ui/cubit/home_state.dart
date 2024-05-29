part of 'home_cubit.dart';

class HomeState {
  final List<Products> products;
  final List categories;
  final bool isLoading;
  final bool isSearched;
  final List<Products> searchedProducts;

  const HomeState(
      {required this.products,
      required this.categories,
      required this.isLoading,
      required this.isSearched,
      required this.searchedProducts});

  factory HomeState.empty() => const HomeState(
        products: [],
        categories: [],
        isLoading: false,
        isSearched: false,
        searchedProducts: [],
      );

  HomeState copyWith({
    List<Products>? products,
    List? categories,
    bool? isLoading,
    bool? isSearched,
    List<Products>? searchedProducts,
  }) =>
      HomeState(
        products: products ?? this.products,
        categories: categories ?? this.categories,
        isLoading: isLoading ?? this.isLoading,
        isSearched: isSearched ?? this.isSearched,
        searchedProducts: searchedProducts ?? this.searchedProducts,
      );
}
