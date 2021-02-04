import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_world/pages/product_details.dart';
import 'package:fashion_world/widgets/product_dashboard_items.dart';
import 'package:fashion_world/pages/categories.dart';
import 'package:fashion_world/models/cart.dart';
import 'package:fashion_world/models/products.dart';
import 'package:fashion_world/services/product_repository.dart';
import 'package:fashion_world/models/categories.dart';

class ProductDashBoard extends StatefulWidget {


  Future<List<Product>> future_product;
  var button_status;
  ProductDashBoard({Key key,@required this.future_product,@required this.button_status}) : super(key: key);

  @override
  ProductDashBoardState createState() => ProductDashBoardState(future_product,button_status);
}

class ProductDashBoardState extends State<ProductDashBoard> {
  Future<List<Product>> future_product;
  BuildContext context;
  ProductRepository productRepository = new ProductRepository();
  Future<List<Categories>> fetchCategories;
  bool searchPanelClosed = true;
  List<Product> _searchResult = [], all_products = [];
  TextEditingController searchController=new TextEditingController();
  String search_name = "%";
  var button_status;
  ProductDashBoardState(this.future_product,this.button_status);

  @override
  void initState() {
   // fetchCategories = productRepository.getCategories();
    /*future_product = this.getProducts();*/
    searchController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(220, 153, 89, 0.1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 1 / 8,
                      vertical: 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    height: 40,
                    child: TextField(
                      style: TextStyle(fontSize: 14.0),
                      autofocus: false,
                      controller: searchController,
                      onChanged: (text) {
                        if (text.length > 0) {
                          setState(() {
                            searchPanelClosed = false;
                            search_name = text + "%";
                            print('The text is ' + search_name);
                                this.fetchProductsLikeName(text + "%");
                            print('The search list is  ' +
                                _searchResult.length.toString());
                            print('And the searchPanelClosed is ' +
                                searchPanelClosed.toString());
                          });
                        } else if (text.length == 0) {
                          setState(() {
                            searchPanelClosed = true;
                            search_name = "";
                            //updateFutureProduct(future_product, search_name);
                            future_product = this.getProducts();
                            _searchResult = [];
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(start: 0.0),
                          child: Icon(
                            Icons.search,
                            color: Color.fromRGBO(214, 24, 195, 1),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(214, 24, 195, 1)),
                            borderRadius: BorderRadius.circular(20.0)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  )),
              _searchResult.length > 0 && searchPanelClosed == false
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 1 / 8,
                          vertical: 0.0),
                      child: Stack(
                        children: [
                          new SizedBox(
                            height: 200,
                            width: (MediaQuery.of(context).orientation) ==
                                    Orientation.portrait
                                ? (MediaQuery.of(context).size.width) * 3 / 4
                                : (MediaQuery.of(context).size.width) * 3 / 5,
                            child: _searchResult.length != 0
                                ? new ListView.builder(
                                    itemCount: _searchResult.length,
                                    itemBuilder: (context, i) {
                                      return new Card(
                                        child: new ListTile(
                                          leading: new Icon(
                                            Icons.shopping_bag,
                                            color:
                                                Color.fromRGBO(214, 24, 195, 1),
                                            size: 24,
                                          ),
                                          title:
                                              new Text(_searchResult[i].name),
                                          subtitle: new Text(
                                            'Ksh ' + _searchResult[i].price,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    214, 24, 195, 0.5),
                                                fontFamily: 'Open Sans',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              searchPanelClosed = true;
                                              searchController.text = _searchResult[i].name;
                                              search_name = searchController.text;
                                              future_product = this.fetchProductsLikeName(search_name);
                                            });
                                         //   updateProductUi(i);
                                          },
                                        ),
                                        margin: const EdgeInsets.all(0.0),
                                      );
                                    })
                                : new Card(),
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: ProductDashBoardItem(context: context,future_product: future_product),
              )
            ],
          ),
        ));

  }

  Future<List<Product>> fetchProductsLikeName(String name) async {
    print('The search String is ' + name);
    _searchResult = await this.productRepository.getProductsLikeName(name);
    print('The length of search result is ' + _searchResult.length.toString());
    return _searchResult;
  }

  Future<List<Product>> getProducts() async {
    all_products = await this.productRepository.getProducts();
    return all_products;
  }

  Future<List<Product>> updateFutureProduct(
      Future<List<Product>> user_product, String name) {
    setState(() {
      user_product = this.fetchProductsLikeName(name);
    });
    return user_product;
  }

  updateProductUi(int index) {
    setState(() {
      searchPanelClosed = true;
      searchController.text = _searchResult[index].name;
      search_name = searchController.text;
      future_product = this.fetchProductsLikeName(search_name);
    });
  }
}
