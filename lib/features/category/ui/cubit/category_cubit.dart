import 'package:bloc/bloc.dart';
import 'package:ecommerece_app/features/category/domain/repository/category_repository.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryRepository categoryRepository;
  CategoryCubit(this.categoryRepository) : super(CategoryState.empty());

  Future<void> getProductsByCategory(String category) async {
    emit(state.copyWith(isLoading: true));
    final products = await categoryRepository.getProductsByCategory(category);
    emit(state.copyWith(products: products, isLoading: false));
  }
}
