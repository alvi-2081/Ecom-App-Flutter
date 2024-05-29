part of 'add_product_cubit.dart';

class AddProductState {
  final Products? product;
  final bool isLoading;

  const AddProductState({
    required this.product,
    required this.isLoading,
  });

  factory AddProductState.empty() => const AddProductState(
        product: null,
        isLoading: false,
      );

  AddProductState copyWith({
    Products? product,
    bool? isLoading,
  }) =>
      AddProductState(
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
      );
}
