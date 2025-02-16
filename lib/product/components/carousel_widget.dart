import 'package:flutter/material.dart';

import '../../features/home/model/product_detail_response_model.dart';
import '../../features/home/model/product_variant_response_model.dart';

class CarouselWidget extends StatefulWidget {
  CarouselWidget(
      {super.key,
      required this.productDetailResponseModel,
      required this.productVariantResponseModel});
  ProductDetailResponseModel? productDetailResponseModel;
  ProductVariantResponseModel? productVariantResponseModel;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: PageView.builder(
            controller: _pageController,
            itemCount: widget.productVariantResponseModel != null
                ? widget.productVariantResponseModel?.data?.node?.product
                    ?.images?.edges?.length
                : widget.productDetailResponseModel?.data?.product?.images
                    ?.edges?.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.productVariantResponseModel != null
                    ? (widget.productVariantResponseModel?.data?.node?.product
                            ?.images?.edges?[index].node?.originalSrc ??
                        "")
                    : widget.productDetailResponseModel?.data?.product?.images
                            ?.edges?[index].node?.originalSrc ??
                        "",
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(bottom: 16, left: 0, right: 0, child: _buildIndicators())
      ],
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          widget.productVariantResponseModel != null
              ? (widget.productVariantResponseModel?.data?.node?.product?.images
                      ?.edges?.length ??
                  0)
              : (widget.productDetailResponseModel?.data?.product?.images?.edges
                      ?.length ??
                  0), (index) {
        final bool isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            color: isActive ? Colors.grey[800] : Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
