import '../../../core/model/base_model.dart';


class AddToCartResponseModel extends BaseModel {
  Data? data;

  AddToCartResponseModel({
    this.data,
  });

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) =>
      AddToCartResponseModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return AddToCartResponseModel.fromJson(json);
  }
}

class Data {
  CartLinesAdd? cartLinesAdd;

  Data({
    this.cartLinesAdd,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cartLinesAdd: json["cartLinesAdd"] == null
            ? null
            : CartLinesAdd.fromJson(json["cartLinesAdd"]),
      );

  Map<String, dynamic> toJson() => {
        "cartLinesAdd": cartLinesAdd?.toJson(),
      };
}

class CartLinesAdd {
  Cart? cart;

  CartLinesAdd({
    this.cart,
  });

  factory CartLinesAdd.fromJson(Map<String, dynamic> json) => CartLinesAdd(
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "cart": cart?.toJson(),
      };
}

class Cart {
  String? id;
  Lines? lines;

  Cart({
    this.id,
    this.lines,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        lines: json["lines"] == null ? null : Lines.fromJson(json["lines"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lines": lines?.toJson(),
      };
}

class Lines {
  List<Edge>? edges;

  Lines({
    this.edges,
  });

  factory Lines.fromJson(Map<String, dynamic> json) => Lines(
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
  Node? node;

  Edge({
    this.node,
  });

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: json["node"] == null ? null : Node.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node?.toJson(),
      };
}

class Node {
  String? id;
  int? quantity;
  Merchandise? merchandise;

  Node({
    this.id,
    this.quantity,
    this.merchandise,
  });

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        quantity: json["quantity"],
        merchandise: json["merchandise"] == null
            ? null
            : Merchandise.fromJson(json["merchandise"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "merchandise": merchandise?.toJson(),
      };
}

class Merchandise {
  String? id;
  String? title;

  Merchandise({
    this.id,
    this.title,
  });

  factory Merchandise.fromJson(Map<String, dynamic> json) => Merchandise(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
