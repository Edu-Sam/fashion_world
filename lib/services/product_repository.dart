import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fashion_world/models/products.dart';
import 'package:fashion_world/models/domain_server.dart';
import 'package:fashion_world/models/categories.dart';

class ProductRepository {
  final String url = "${DomainServer.name}androidfashion/productfetch.php";
  final String url_categories =
      "${DomainServer.name}androidfashion/fetchcategories.php";
  final String url_product_like_name =
      "${DomainServer.name}androidfashion/product_like_name.php";
  final String url_product_by_name =
      "${DomainServer.name}androidfashion/product_by_name.php";
  final String url_product_by_category =
      "${DomainServer.name}androidfashion/product_by_category.php";

  ProductRepository() {}
  Future<List<Product>> getProducts() async {
    final http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});

    var products = jsonDecode(response.body);
    var list_products = products["products"] as List;
    List<Product> user_products =
        list_products.map<Product>((json) => Product.fromJson(json)).toList();
    print('the children are ${user_products[0].colors}');
    return user_products;
  }

  Future<List<Categories>> getCategories() async {
    final http.Response response =
        await http.get(url_categories, headers: {"Accept": "application/json"});

    var categories = jsonDecode(response.body);
    var list_categories = categories["categories"] as List;
    List<Categories> user_categories = list_categories
        .map<Categories>((json) => Categories.fromJson(json))
        .toList();
    print('The product is ${user_categories[0].name}');

    return user_categories;
  }

  Future<List<Product>> getProductsLikeName(String name) async {
    print('The search String is ' + name);
    final http.Response response = await http.post(url_product_like_name,
        headers: {"Accept": "application/json"}, body: {'name': name});
    //  print(response.body);
    if (response.body.isNotEmpty) {
      var products = jsonDecode(response.body);
      var list_products = products["products"] as List;
      List<Product> user_products =
          list_products.map<Product>((json) => Product.fromJson(json)).toList();
      return user_products;
    } else {
      List<Product> user_product = [];
      return user_product;
    }
  }

  Future<List<Product>> getProductsByName(String name) async {
    final http.Response response = await http.post(url_product_by_name,
        headers: {"Accept": "application/json"}, body: {'name': name});
    var products = jsonDecode(response.body);
    var list_products = products["products"] as List;
    List<Product> user_products =
        list_products.map<Product>((json) => Product.fromJson(json)).toList();
    print('the children are ${user_products[0].colors}');
    return user_products;
  }

  Future<List<Product>> getProductByCategories(String name) async{
    final http.Response response = await http.post(url_product_by_category,
        headers: {"Accept": "application/json"}, body: {'name': name});
    var products = jsonDecode(response.body);
    var list_products = products["products"] as List;
    List<Product> user_products =
    list_products.map<Product>((json) => Product.fromJson(json)).toList();
  //  print('the children are ${user_products[0].colors}');
    return user_products;
  }
}
