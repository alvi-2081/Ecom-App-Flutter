import 'package:bloc/bloc.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:ecommerece_app/features/home/domain/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeState.empty());

  Future<void> getAllProducts() async {
    emit(state.copyWith(isLoading: true));
    final products = await homeRepository.getAllProducts();
    emit(state.copyWith(products: products, isLoading: false));
  }

  Future<void> getAllCategories() async {
    final categories = await homeRepository.getAlCategories();
    emit(state.copyWith(categories: categories));
  }

  Future<void> searchProducts(String query) async {
    emit(state.copyWith(isLoading: true, isSearched: true));
    final searchedProducts = await homeRepository.searchProducts(query);
    emit(state.copyWith(searchedProducts: searchedProducts, isLoading: false));
  }

  void clearSearch() {
    emit(state.copyWith(isSearched: false, searchedProducts: []));
  }

  void addProduct(Products product) {
    emit(state.copyWith(products: state.products..insert(0, product)));
  }

  void removeProduct(Products product) {
    state.products.remove(product);
    emit(state.copyWith(products: state.products));
  }
}
