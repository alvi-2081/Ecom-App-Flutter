import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/app_core.dart';
import 'package:ecommerece_app/core/network/dio_client_network.dart';
import 'package:ecommerece_app/core/routes/generate_route.dart';
import 'package:ecommerece_app/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initRepos();
  getIt<DioClientNetwork>().initializeDioClientNetwork();
  runApp(const MultiBlocProviderWidget());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecom App',
      theme: ThemeData(
        fontFamily: 'Metropolis',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.main),
        useMaterial3: true,
      ),
      onGenerateRoute: onGenerateRoute,
      home: const HomeScreen(),
    );
  }
}
