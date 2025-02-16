import 'package:flutter/material.dart';

import '../model/product_detail_response_model.dart';
import '../model/product_variant_response_model.dart';

enum ProductStateStatus { initial, loading, completed, fail, addToCartLoading, addToCartCompleted }

class ProductState {
  ProductStateStatus productStateStatus;
  String? error;
  ProductDetailResponseModel? productDetail;
  List<Widget>? productInformationTiles;
  ProductVariantResponseModel? productVariantResponseModel;

  ProductState(
      {this.productStateStatus = ProductStateStatus.initial,
      this.error,
      this.productDetail,
      this.productInformationTiles = const [], this.productVariantResponseModel});

  ProductState copyWith(
      {ProductStateStatus? productStateStatus,
      String? error,
      ProductDetailResponseModel? productDetail,
       ProductVariantResponseModel? productVariantResponseModel,
      List<Widget>? productInformationTiles}) {
    return ProductState(
        productDetail: productDetail ?? this.productDetail,
        productStateStatus: productStateStatus ?? this.productStateStatus,
        productInformationTiles:
            productInformationTiles ?? this.productInformationTiles,
        productVariantResponseModel: productVariantResponseModel ?? this.productVariantResponseModel,
        error: error ?? this.error);
  }
}
