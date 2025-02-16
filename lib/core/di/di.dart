import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';
import '../../features/home/controller/product_detail_controller.dart';
import '../../features/home/controller/home_state.dart';
import '../../features/home/service/product_service.dart';
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
  //HomeService
  di.registerSingleton<ProductService>(ProductService(di<RepositoryManager>()));

  //NOTIFIERS
  //HomeStateNotifier
  di.registerSingleton(
      StateNotifierProvider<ProductDetailController, HomeState>((ref) =>
          ProductDetailController(productService: di<ProductService>())));
}
