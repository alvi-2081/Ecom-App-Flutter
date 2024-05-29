import 'package:ecommerece_app/core/network/dio_api_services.dart';
import 'package:ecommerece_app/core/network/dio_client_network.dart';
import 'package:ecommerece_app/features/add_product/domain/repository/add_product_repository.dart';
import 'package:ecommerece_app/features/add_product/ui/cubit/add_product_cubit.dart';
import 'package:ecommerece_app/features/category/domain/repository/category_repository.dart';
import 'package:ecommerece_app/features/category/ui/cubit/category_cubit.dart';
import 'package:ecommerece_app/features/home/domain/repository/home_repository.dart';
import 'package:ecommerece_app/features/home/ui/cubit/home_cubit.dart';
import 'package:ecommerece_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProviderWidget extends StatelessWidget {
  const MultiBlocProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => AddProductCubit(getIt()),
        ),
      ],
      child: const MyApp(),
    );
  }
}

initRepos() {
  getIt
    ..registerLazySingleton<DioClientNetwork>(() => DioClientNetwork())
    ..registerLazySingleton<DioApiServices>(() => DioApiServices())
    ..registerLazySingleton<HomeRepository>(() => HomeRepository())
    ..registerLazySingleton<CategoryRepository>(() => CategoryRepository())
    ..registerLazySingleton<AddProductRepository>(() => AddProductRepository());
}
