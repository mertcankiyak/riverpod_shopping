import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:riverpod/riverpod.dart';
import '../../../core/helper/shared_preferences_manager.dart';
import '../../../product/components/expansion_tile_widget.dart';
import '../../../product/enums/shared_pref_enum.dart';
import '../model/add_to_cart_response_model.dart';
import '../model/create_cart_response_model.dart';
import '../model/product_detail_response_model.dart';
import '../model/product_variant_response_model.dart';
import '../service/product_service.dart';
import 'product_state.dart';

class ProductDetailController extends StateNotifier<ProductState> {
  ProductDetailController({required this.productService})
      : super(ProductState()) {
    fethProductDetail();
  }

  ProductService productService;
  List<Widget> productInformationTiles = [];
  ProductVariantResponseModel? selectedVariant;

  Future<void> fethProductDetail() async {
    try {
      state = state.copyWith(productStateStatus: ProductStateStatus.loading);
      ProductDetailResponseModel? data = await productService.fethProductDetail(
          id: "gid://shopify/Product/8740231577837");
      if (data?.error == null) {
        setupProductInformationTile(data);
        state = state.copyWith(
            productStateStatus: ProductStateStatus.completed,
            productDetail: data,
            productInformationTiles: productInformationTiles);
      } else {
        state = state.copyWith(
            productStateStatus: ProductStateStatus.fail,
            error: data?.error?.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(
          productStateStatus: ProductStateStatus.fail, error: e.toString());
    }
  }

  Future<void> fetchVariantDetail({required String id}) async {
    try {
      state = state.copyWith(productStateStatus: ProductStateStatus.loading);
      ProductVariantResponseModel? data =
          await productService.fethProductVariant(id: id);
      selectedVariant = data;
      if (data?.error == null) {
        setupProductVariantInformationTile(data);
        state = state.copyWith(
            productStateStatus: ProductStateStatus.completed,
            productVariantResponseModel: data);
      } else {
        state = state.copyWith(
            productStateStatus: ProductStateStatus.fail,
            error: data?.error?.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(
          productStateStatus: ProductStateStatus.fail, error: e.toString());
    }
  }

  Future<void> addToCart() async {
    try {
      state =
          state.copyWith(productStateStatus: ProductStateStatus.addToCartLoading);
      String? cartId = await SharedPreferencesManager.instance
          .getCart(key: SharedPreferencesEnum.cart);
      if (cartId == null) {
        CreateCartResponseModel? cartResponse =
            await productService.createCart();
        await SharedPreferencesManager.instance.saveCart(
            key: SharedPreferencesEnum.cart,
            value: cartResponse?.data?.cartCreate?.cart?.id ?? "");
        if (cartResponse?.error == null) {
          AddToCartResponseModel? addToCartResponse =
              await productService.addToCart(
                  cartId: cartResponse?.data?.cartCreate?.cart?.id ?? "",
                  variantId: selectedVariant != null
                      ? (selectedVariant?.data?.node?.id ?? "")
                      : (state.productDetail?.data?.product?.variants?.edges
                              ?.first.node?.id ??
                          ""));
          if (addToCartResponse?.error == null) {
            state = state.copyWith(
                productStateStatus: ProductStateStatus.addToCartCompleted);
          } else {
            state = state.copyWith(productStateStatus: ProductStateStatus.fail);
          }
        } else {
          state = state.copyWith(productStateStatus: ProductStateStatus.fail);
        }
      } else {
        String? cartId = await SharedPreferencesManager.instance
            .getCart(key: SharedPreferencesEnum.cart);
        AddToCartResponseModel? addToCartResponse =
            await productService.addToCart(
                cartId: cartId ?? "",
                variantId: selectedVariant != null
                    ? (selectedVariant?.data?.node?.id ?? "")
                    : (state.productDetail?.data?.product?.variants?.edges
                            ?.first.node?.id ??
                        ""));
        if (addToCartResponse?.error == null) {
          state = state.copyWith(
              productStateStatus: ProductStateStatus.addToCartCompleted);
        } else {
          state = state.copyWith(productStateStatus: ProductStateStatus.fail);
        }
      }
    } catch (e) {
      state = state.copyWith(
          productStateStatus: ProductStateStatus.fail, error: e.toString());
    }
  }

  void setupProductInformationTile(ProductDetailResponseModel? productDetail) {
    productInformationTiles = [
      ExpansionTileWidget(
        title: "Ürün Bilgileri",
        child: HtmlWidget(
          " ${productDetail?.data?.product?.descriptionHtml}",
        ),
      ),
      ExpansionTileWidget(
        title: "Taksit Seçenekleri",
        child: const Text("Tüm taksit seçeneklerini görüntüleyebilirsiniz."),
      ),
      ExpansionTileWidget(
        title: "İade, İptal ve Teslimat Koşulları",
        child: const Text("İade işlemlerini saglayabilirsiniz."),
      ),
      ExpansionTileWidget(
        title: "Paylaş",
        child: const Text(
            "Bu kısımda sosyal medya hesaplarında veya direkt link olarak paylaşılabilir bir yapı olabilir."),
      ),
    ];
  }

  void setupProductVariantInformationTile(
      ProductVariantResponseModel? variantResponseModel) {
    productInformationTiles = [
      ExpansionTileWidget(
        title: "Ürün Bilgileri",
        child: HtmlWidget(
          " ${variantResponseModel?.data?.node?.product?.descriptionHtml}",
        ),
      ),
      ExpansionTileWidget(
        title: "Taksit Seçenekleri",
        child: const Text("Tüm taksit seçeneklerini görüntüleyebilirsiniz."),
      ),
      ExpansionTileWidget(
        title: "İade, İptal ve Teslimat Koşulları",
        child: const Text("İade işlemlerini saglayabilirsiniz."),
      ),
      ExpansionTileWidget(
        title: "Paylaş",
        child: const Text("Paylaşımlar"),
      ),
    ];
  }
}
