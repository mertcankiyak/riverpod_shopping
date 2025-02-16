import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';
import '../../features/productDetail/controller/product_detail_controller.dart';
import '../../features/productDetail/controller/product_state.dart';
import '../../features/productDetail/service/product_service.dart';
import '../network/network_manager.dart';
import '../network/repository_manager.dart';

final di = GetIt.instance;

Future<void> setupDi() async {
  //Dio Instance
  di.registerSingleton<Dio>(NetworkManager.instance.dio);

  //Network Instance
  di.registerSingleton<NetworkManager>(NetworkManager.instance);

  //RepositoryManager
  di.registerSingleton<RepositoryManager>(
      RepositoryManager(dio: di<NetworkManager>().dio));

  //SERVICES
  //ProductService
  di.registerSingleton<ProductService>(ProductService(di<RepositoryManager>()));

  //NOTIFIERS
  //ProductDetailNotifier
  di.registerSingleton(
      StateNotifierProvider<ProductDetailController, ProductState>((ref) =>
          ProductDetailController(productService: di<ProductService>())));
}
