part of 'category_cubit.dart';

class CategoryState {
  final List<Products> products;
  final bool isLoading;

  const CategoryState({
    required this.products,
    required this.isLoading,
  });

  factory CategoryState.empty() => const CategoryState(
        products: [],
        isLoading: false,
      );

  CategoryState copyWith({
    List<Products>? products,
    bool? isLoading,
  }) =>
      CategoryState(
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading,
      );
}
