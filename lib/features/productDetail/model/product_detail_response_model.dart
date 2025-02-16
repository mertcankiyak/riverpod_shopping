import '../../../core/model/base_model.dart';
class ProductDetailResponseModel  extends BaseModel{
  Data? data;

  ProductDetailResponseModel({
    this.data,
  });

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

@override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
      
        @override
        fromJson(Map<String, dynamic> json) {
        return ProductDetailResponseModel.fromJson(json);
        }
}

class Data {
  Product? product;

  Data({
    this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
      };
}

class Product {
  String? title;
  String? vendor;
  String? descriptionHtml;
  Images? images;
  Variants? variants;

  Product({
    this.title,
    this.vendor,
    this.descriptionHtml,
    this.images,
    this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"],
        vendor: json["vendor"],
        descriptionHtml: json["descriptionHtml"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        variants: json["variants"] == null
            ? null
            : Variants.fromJson(json["variants"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "vendor": vendor,
        "descriptionHtml": descriptionHtml,
        "images": images?.toJson(),
        "variants": variants?.toJson(),
      };
}

class Images {
  List<ImagesEdge>? edges;

  Images({
    this.edges,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        edges: json["edges"] == null
            ? []
            : List<ImagesEdge>.from(
                json["edges"]!.map((x) => ImagesEdge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": edges == null
            ? []
            : List<dynamic>.from(edges!.map((x) => x.toJson())),
      };
}

class ImagesEdge {
  ImageClass? node;

  ImagesEdge({
    this.node,
  });

  factory ImagesEdge.fromJson(Map<String, dynamic> json) => ImagesEdge(
        node: json["node"] == null ? null : ImageClass.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
      };
}

class ImageClass {
  String? originalSrc;

  ImageClass({
    this.originalSrc,
  });

  factory ImageClass.fromJson(Map<String, dynamic> json) => ImageClass(
        originalSrc: json["originalSrc"],
      );

  Map<String, dynamic> toJson() => {
        "originalSrc": originalSrc,
      };
}

class Variants {
  List<VariantsEdge>? edges;

  Variants({
    this.edges,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        edges: json["edges"] == null
            ? []
            : List<VariantsEdge>.from(
                json["edges"]!.map((x) => VariantsEdge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": edges == null
            ? []
            : List<dynamic>.from(edges!.map((x) => x.toJson())),
      };
}

class VariantsEdge {
  PurpleNode? node;

  VariantsEdge({
    this.node,
  });

  factory VariantsEdge.fromJson(Map<String, dynamic> json) => VariantsEdge(
        node: json["node"] == null ? null : PurpleNode.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
      };
}

class PurpleNode {
  String? id;
  String? title;
  String? sku;
  dynamic barcode;
  bool? availableForSale;
  Price? price;
  dynamic compareAtPrice;
  num? weight;
  String? weightUnit;
  List<SelectedOption>? selectedOptions;
  ImageClass? image;

  PurpleNode({
    this.id,
    this.title,
    this.sku,
    this.barcode,
    this.availableForSale,
    this.price,
    this.compareAtPrice,
    this.weight,
    this.weightUnit,
    this.selectedOptions,
    this.image,
  });

  factory PurpleNode.fromJson(Map<String, dynamic> json) => PurpleNode(
        id: json["id"],
        title: json["title"],
        sku: json["sku"],
        barcode: json["barcode"],
        availableForSale: json["availableForSale"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        compareAtPrice: json["compareAtPrice"],
        weight: json["weight"],
        weightUnit: json["weightUnit"],
        selectedOptions: json["selectedOptions"] == null
            ? []
            : List<SelectedOption>.from(json["selectedOptions"]!
                .map((x) => SelectedOption.fromJson(x))),
        image:
            json["image"] == null ? null : ImageClass.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sku": sku,
        "barcode": barcode,
        "availableForSale": availableForSale,
        "price": price?.toJson(),
        "compareAtPrice": compareAtPrice,
        "weight": weight,
        "weightUnit": weightUnit,
        "selectedOptions": selectedOptions == null
            ? []
            : List<dynamic>.from(selectedOptions!.map((x) => x.toJson())),
        "image": image?.toJson(),
      };
}

class Price {
  String? amount;
  String? currencyCode;

  Price({
    this.amount,
    this.currencyCode,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"],
        currencyCode: json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currencyCode": currencyCode,
      };
}

class SelectedOption {
  String? name;
  String? value;

  SelectedOption({
    this.name,
    this.value,
  });

  factory SelectedOption.fromJson(Map<String, dynamic> json) => SelectedOption(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
