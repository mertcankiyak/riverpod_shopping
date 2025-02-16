
import 'package:riverpod_shopping/product/extension/service_extension.dart';

import '../../../core/network/repository_manager.dart';
import '../../../product/constants/query_constants.dart';
import '../../../product/enums/service_enum.dart';
import '../model/add_to_cart_response_model.dart';
import '../model/create_cart_response_model.dart';
import '../model/product_detail_response_model.dart';
import '../model/product_variant_response_model.dart';

abstract class IProductService {
  RepositoryManager repositoryManager;
  IProductService(this.repositoryManager);
  Future<ProductDetailResponseModel?> fethProductDetail({required String id});
  Future<ProductVariantResponseModel?> fethProductVariant({required String id});
  Future<CreateCartResponseModel?> createCart();
  Future<AddToCartResponseModel?> addToCart(
      {required String cartId, required String variantId});
}

class ProductService extends IProductService {
  ProductService(super.repositoryManager);

  @override
  Future<ProductDetailResponseModel?> fethProductDetail({required String id}) async {
    final Map<String, dynamic> body = {
      "query": getProductDetailQuery,
      "variables": {
        "id": "$id",
      },
    };
    ProductDetailResponseModel? response =
        await repositoryManager.post<ProductDetailResponseModel>(
            data: body,
            path: ServiceEndpointEnum.getProductDetail.rawValue,
            model: ProductDetailResponseModel());
    return response;
  }

  @override
  Future<ProductVariantResponseModel?> fethProductVariant(
      {required String id}) async {
    final Map<String, dynamic> body = {
      "query": getVariantDetailQuery,
      "variables": {
        "id": "$id",
      },
    };
    ProductVariantResponseModel? response =
        await repositoryManager.post<ProductVariantResponseModel>(
            data: body,
            path: ServiceEndpointEnum.getProductDetail.rawValue,
            model: ProductVariantResponseModel());
    return response;
  }

  @override
  Future<CreateCartResponseModel?> createCart() async {
    final Map<String, dynamic> body = {
      "query": createCartQuery,
    };
    CreateCartResponseModel? response =
        await repositoryManager.post<CreateCartResponseModel>(
            data: body,
            path: ServiceEndpointEnum.getProductDetail.rawValue,
            model: CreateCartResponseModel());
    return response;
  }

  @override
  Future<AddToCartResponseModel?> addToCart(
      {required String cartId, required String variantId}) async {
    final Map<String, dynamic> body = {
      "query": addToCartMutation,
      "variables": {
        "cartId": "$cartId",
        "merchandiseId": "$variantId",
      },
    };
    AddToCartResponseModel? response =
        await repositoryManager.post<AddToCartResponseModel>(
            data: body,
            path: ServiceEndpointEnum.getProductDetail.rawValue,
            model: AddToCartResponseModel());
    return response;
  }
}
