import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';


Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.name,
    this.sku,
    this.price,
    this.image,
    this.desc,
    this.quantity,
    this.color,
    this.colors,
  });

  String id;
  String name;
  String sku;
  String price;
  String image;
  String desc;
  String quantity;
  String color;
  List<ProductColors> colors;

  factory Product.fromJson(Map<String, dynamic> json) {
    if (json['colors'] != null) {
      var colorObject = json['colors'] as List;
      List<ProductColors> _productColors = colorObject
          .map((colorJson) => ProductColors.fromJson(colorJson))
          .toList();

      return Product(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"],
        image: json["image"],
        desc: json["desc"],
        quantity: json["quantity"],
        color: json["color"],
        colors: _productColors,
      );
    } else {
      return Product(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"],
        image: json["image"],
        desc: json["desc"],
        quantity: json["quantity"],
        color: json["color"],
        colors: [],
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sku": sku,
    "price": price,
    "image": image,
    "desc": desc,
    "quantity": quantity,
    "color": color,
    "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
  };
}

ProductColors productColorsFromJson(String str) => ProductColors.fromJson(json.decode(str));

String productColorsToJson(ProductColors data) => json.encode(data.toJson());

class ProductColors {
  ProductColors({
    this.colors,
    this.size,
    this.quantity,
    this.quantity1,
    this.quantity2,
    this.quantity3,
  });

  String colors;
  List<Sizes> size;
  String quantity;
  String quantity1;
  String quantity2;
  String quantity3;

  factory ProductColors.fromJson(Map<String, dynamic> json) {
    if(json['sizes']  != null){
      var sizesObject = json['sizes'] as List;
      List<Sizes> _productColorSizes = sizesObject
          .map((colorSizesJson) => Sizes.fromJson(colorSizesJson))
          .toList();
      return ProductColors(
        colors: json["color"],
        size: _productColorSizes,
        quantity: json["quantity"],
        quantity1: json["quantity1"],
        quantity2: json["quantity2"],
        quantity3: json["quantity3"],
      );
    }else
      return ProductColors(
        colors: json["color"],
        size: [],
        quantity: json["quantity"],
        quantity1: json["quantity1"],
        quantity2: json["quantity2"],
        quantity3: json["quantity3"],
      );
  }

  Map<String, dynamic> toJson() => {
    "color": colors,
    "sizes": size,
    "quantity": quantity,
    "quantity1": quantity1,
    "quantity2": quantity2,
    "quantity3": quantity3,
  };
}

Sizes sizesFromJson(String str) => Sizes.fromJson(json.decode(str));

String sizesToJson(Sizes data) => json.encode(data.toJson());

class Sizes {
  Sizes({
    this.size,
  });

  String size;

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
  };
}
