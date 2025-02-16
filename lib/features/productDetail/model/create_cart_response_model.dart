import '../../../core/model/base_model.dart';

class CreateCartResponseModel extends BaseModel {
  Data? data;

  CreateCartResponseModel({
    this.data,
  });

  factory CreateCartResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateCartResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return CreateCartResponseModel.fromJson(json);
  }
}

class Data {
  CartCreate? cartCreate;

  Data({
    this.cartCreate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cartCreate: json["cartCreate"] == null
            ? null
            : CartCreate.fromJson(json["cartCreate"]),
      );

  Map<String, dynamic> toJson() => {
        "cartCreate": cartCreate?.toJson(),
      };
}

class CartCreate {
  Cart? cart;

  CartCreate({
    this.cart,
  });

  factory CartCreate.fromJson(Map<String, dynamic> json) => CartCreate(
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "cart": cart?.toJson(),
      };
}

class Cart {
  String? id;

  Cart({
    this.id,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
