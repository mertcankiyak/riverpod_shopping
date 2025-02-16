import 'package:flutter/material.dart';

import '../model/product_detail_response_model.dart';
import '../model/product_variant_response_model.dart';

enum HomeStateStatus { initial, loading, completed, fail, addToCartLoading, addToCartCompleted }

class HomeState {
  HomeStateStatus homeStateStatus;
  String? error;
  ProductDetailResponseModel? productDetail;
  List<Widget>? productInformationTiles;
  ProductVariantResponseModel? productVariantResponseModel;

  HomeState(
      {this.homeStateStatus = HomeStateStatus.initial,
      this.error,
      this.productDetail,
      this.productInformationTiles = const [], this.productVariantResponseModel});

  HomeState copyWith(
      {HomeStateStatus? homeStateStatus,
      String? error,
      ProductDetailResponseModel? productDetail,
       ProductVariantResponseModel? productVariantResponseModel,
      List<Widget>? productInformationTiles}) {
    return HomeState(
        productDetail: productDetail ?? this.productDetail,
        homeStateStatus: homeStateStatus ?? this.homeStateStatus,
        productInformationTiles:
            productInformationTiles ?? this.productInformationTiles,
        productVariantResponseModel: productVariantResponseModel ?? this.productVariantResponseModel,
        error: error ?? this.error);
  }
}
