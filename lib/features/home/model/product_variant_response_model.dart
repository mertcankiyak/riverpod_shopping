
import '../../../core/model/base_model.dart';

class ProductVariantResponseModel  extends BaseModel{
  Data? data;

  ProductVariantResponseModel({
    this.data,
  });

  factory ProductVariantResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductVariantResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

@override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
      
        @override
        fromJson(Map<String, dynamic> json) {
          return ProductVariantResponseModel.fromJson(json);
        }
}

class Data {
  Node? node;

  Data({
    this.node,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        node: json["node"] == null ? null : Node.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
      };
}

class Node {
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
  ImageData? image;
  Product? product;

  Node({
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
    this.product,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
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
        image: json["image"] == null ? null : ImageData.fromJson(json["image"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
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
        "product": product?.toJson(),
      };
}

class ImageData {
  String? originalSrc;
  String? altText;

  ImageData({
    this.originalSrc,
    this.altText,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        originalSrc: json["originalSrc"],
        altText: json["altText"],
      );

  Map<String, dynamic> toJson() => {
        "originalSrc": originalSrc,
        "altText": altText,
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

class Product {
  String? title;
  String? vendor;
  String? descriptionHtml;
  Images? images;

  Product({
    this.title,
    this.vendor,
    this.descriptionHtml,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"],
        vendor: json["vendor"],
        descriptionHtml: json["descriptionHtml"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "vendor": vendor,
        "descriptionHtml": descriptionHtml,
        "images": images?.toJson(),
      };
}

class Images {
  List<Edge>? edges;

  Images({
    this.edges,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        edges: json["edges"] == null
            ? []
            : List<Edge>.from(json["edges"]!.map((x) => Edge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": edges == null
            ? []
            : List<dynamic>.from(edges!.map((x) => x.toJson())),
      };
}

class Edge {
  ImageData? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : ImageData.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
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
