import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import '../../../core/di/di.dart';
import '../../../product/components/carousel_widget.dart';
import '../controller/product_detail_controller.dart';
import '../controller/product_state.dart';
import '../model/product_detail_response_model.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  var stateReference =
      di<StateNotifierProvider<ProductDetailController, HomeState>>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stateReference);
    ref.listen<HomeState>(stateReference, (previous, next) {
      if (next.homeStateStatus == HomeStateStatus.addToCartLoading) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => loadingAlertDialog(),
        );
      } else if (next.homeStateStatus == HomeStateStatus.addToCartCompleted) {
        Navigator.pop(context);
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => successAlertDialog(context, state),
        );
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        switch (state.homeStateStatus) {
          case HomeStateStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case HomeStateStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HomeStateStatus.completed:
            return _buildBody(state, ref);
          case HomeStateStatus.fail:
            return Center(child: Text(state.error ?? ""));
          default:
            return _buildBody(state, ref);
        }
      }),
    );
  }

  AlertDialog loadingAlertDialog() {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CircleAvatar(
          radius: 100,
          backgroundColor: Colors.white,
          child: Lottie.asset('assets/cart_lottie.json')),
    );
  }

  AlertDialog successAlertDialog(BuildContext context, HomeState state) {
    return AlertDialog(
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Alışverişe Devam Et")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Sepete Git")),
      ],
      title: const Text("Ürün Sepetinizde"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Image.network(
              state.productVariantResponseModel != null
                  ? (state.productVariantResponseModel?.data?.node?.product
                          ?.images?.edges?.first.node?.originalSrc ??
                      "")
                  : (state.productDetail?.data?.product?.images?.edges?.first
                          .node?.originalSrc ??
                      ""),
              width: 50,
              height: 50,
            ),
            Text(state.productVariantResponseModel != null
                ? (state.productVariantResponseModel?.data?.node?.title ?? "")
                : (state.productDetail?.data?.product?.title ?? ""))
          ],
        ),
      ),
    );
  }

  Widget _buildBody(HomeState state, WidgetRef ref) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            _buildSliverAppBar(state),
            _buildBodyContent(state, ref),
            SliverToBoxAdapter(
              child: SizedBox(height: context.sized.dynamicHeight(0.12)),
            ),
          ],
        ),
        _buildFooter(state, ref)
      ],
    );
  }

  SliverList _buildBodyContent(HomeState state, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductTitle(state),
                context.sized.emptySizedHeightBoxLow,
                _buildFavorite(state),
                context.sized.emptySizedHeightBoxLow3x,
                _buildVariantList(state, ref),
                context.sized.emptySizedHeightBoxLow3x,
                _buildCargoText(),
                context.sized.emptySizedHeightBoxLow,
                _buildRefundText()
              ],
            ),
          ),
          context.sized.emptySizedHeightBoxLow,
          const Divider(color: Colors.black12),
          _buildProductInfo(state),
          const Divider(color: Colors.black12),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(HomeState state) {
    return SliverAppBar(
        pinned: false,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        expandedHeight: context.sized.dynamicHeight(0.4),
        flexibleSpace: CarouselWidget(
          productDetailResponseModel: state.productDetail,
          productVariantResponseModel: state.productVariantResponseModel,
        ));
  }

  Text _buildProductTitle(HomeState state) {
    return Text("${state.productDetail?.data?.product?.vendor}",
        style: context.general.textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.bold));
  }

  Row _buildFavorite(HomeState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${state.productDetail?.data?.product?.title}",
            style: context.general.textTheme.titleMedium),
        const Column(
          children: [Icon(Icons.favorite_border), Text("1")],
        )
      ],
    );
  }

  SingleChildScrollView _buildVariantList(HomeState state, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
          children: (state.productDetail?.data?.product?.variants?.edges ?? [])
              .asMap()
              .map((key, value) =>
                  MapEntry(key, _buildVariantItem(ref, value, key)))
              .values
              .toList()),
    );
  }

  InkWell _buildVariantItem(WidgetRef ref, VariantsEdge value, int key) {
    return InkWell(
      onTap: () {
        ref
            .read(stateReference.notifier)
            .fetchVariantDetail(id: value.node?.id ?? "");
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                    color: (ref.read(stateReference.notifier).selectedVariant ==
                                null &&
                            key == 0)
                        ? Colors.black
                        : ref
                                    .read(stateReference.notifier)
                                    .selectedVariant
                                    ?.data
                                    ?.node
                                    ?.id ==
                                value.node?.id
                            ? Colors.black
                            : Colors.transparent),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network("${value.node?.image?.originalSrc}"),
              ),
            ),
            context.sized.emptySizedHeightBoxLow,
            Text("${value.node?.title}")
          ],
        ),
      ),
    );
  }

  Row _buildCargoText() {
    return Row(
      children: [
        const Icon(Icons.card_giftcard),
        context.sized.emptySizedWidthBoxLow,
        Text("22-25 Ağustos Kargoda",
            style: context.general.textTheme.titleMedium)
      ],
    );
  }

  Row _buildRefundText() {
    return Row(
      children: [
        const Icon(Icons.card_membership_rounded),
        context.sized.emptySizedWidthBoxLow,
        Text("14 Gün Koşulsuz İade",
            style: context.general.textTheme.titleMedium)
      ],
    );
  }

  ListView _buildProductInfo(HomeState state) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: state.productInformationTiles?.length ?? 0,
        separatorBuilder: (context, index) => const Divider(
              color: Colors.black26,
            ),
        itemBuilder: (context, index) {
          return state.productInformationTiles?[index];
        });
  }

  Align _buildFooter(HomeState state, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: context.sized.dynamicHeight(0.12),
        width: context.sized.width,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [_buildPriceText(state), _buildAddToCartButton(ref)],
          ),
        ),
      ),
    );
  }

  Expanded _buildPriceText(HomeState state) {
    return Expanded(
      child: state.productVariantResponseModel != null
          ? Text(
              "${state.productVariantResponseModel?.data?.node?.price?.amount} ${state.productVariantResponseModel?.data?.node?.price?.currencyCode}",
              style: context.general.textTheme.titleLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            )
          : Text(
              "${state.productDetail?.data?.product?.variants?.edges?.first.node?.price?.amount} ${state.productDetail?.data?.product?.variants?.edges?.first.node?.price?.currencyCode}",
              style: context.general.textTheme.titleLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
    );
  }

  Expanded _buildAddToCartButton(WidgetRef ref) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            )),
        onPressed: () {
          ref.read(stateReference.notifier).addToCart();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Sepete Ekle",
            style: context.general.textTheme.titleMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
