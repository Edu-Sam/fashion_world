import 'package:fashion_world/pages/categories_dashboard.dart';
import 'package:fashion_world/pages/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fashion_world/pages/product_dashboard.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fashion_world/pages/cart_details.dart';
import 'package:fashion_world/pages/users_container.dart';
import 'package:badges/badges.dart';
import 'package:fashion_world/pages/categories.dart';
import 'package:fashion_world/services/product_repository.dart';
import 'package:fashion_world/models/cart.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import  'package:fashion_world/models/categories.dart';
import  'package:fashion_world/models/products.dart';
import  'package:fashion_world/models/orders.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:fashion_world/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_world/services/product_repository.dart';
import 'package:fashion_world/models/products.dart';
import 'package:fashion_world/pages/order_summary.dart';
import 'package:fashion_world/widgets/product_dashboard_items.dart';
import 'package:fashion_world/services/order_repository.dart';

void main() {
  MpesaFlutterPlugin.setConsumerKey('RYquD2W98k6miqYQQUT4xd1j9m2OuV1v');
  MpesaFlutterPlugin.setConsumerSecret('M3Mjx92LHteknxBS');

  runApp(
      MyApp(),
     // PushMessagingExample()
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=> Cart(cart_id: 0,cart_size: 0,total_amount: 0,cart_items_data: []),),
       ChangeNotifierProvider(create: (_)=>User.setup(username: '',credit: '',fname: '',lname: '',phone: '',
          location: '',email: '',logged: '')),
        ChangeNotifierProvider(create: (_)=>Orders.setup(bill_no: '',customer_name: '',customer_address: '',
        customer_phone: '',gross_amount: '',service_charge:'',vat_charge_rate:'16%',net_amount: '',discount: '0%',type: '',invoice_no: '',
        receipt_no: '',paid_status: '1',user_id: '1')),
        ChangeNotifierProvider(create: (_)=>Categories(name: '',description: ''))
    ],
    child: MaterialApp(
      title: 'Fashion World',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Color.fromRGBO(214,24,195,1)),

      ),
      home: MyHomePage(title: 'Fashion World'),
    ),);

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottom_navigation_page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final _navigatorKey = GlobalKey<NavigatorState>();
  int value = 0;
  Cart cart;
  var button_status,button_status1;
  int getListno=0,getListno1=0;
  bool searchPanelClosed = true;
  TextEditingController searchController=new TextEditingController();
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  Future<List<Categories>> future_categories;
  Future<List<Product>> future_product_by_category;
  List<Product> _searchResult = [];
  List<Product>  all_products = [],products_by_categories=[];
  Future<List<Product>> future_product;
  ProductRepository productRepository = new ProductRepository();
  String search_name = "%";
  OrderRepository orderRepository=new OrderRepository();
  List<Orders> list_orders;
  String error_message='';
  SharedPreferences pref;


  @override
  void initState() {
   /* cart =
    new Cart(cart_id: 0, cart_size: 1, total_amount: 0, cart_items_data: []);*/
    setUserPreferences();
    super.initState();
    future_product = this.getProducts();
    future_categories=this.getCategories();

  }

  Future<void> setUserPreferences() async{
    pref=await _prefs;
    if(!pref.containsKey('username')){
      pref.setString('username','');
      pref.setString('email','');
      pref.setString('phone','');

    }
    else if(pref.containsKey('username')){
      if(pref.getString('username').isNotEmpty){
        Provider.of<User>(context,listen: false).username=pref.getString('username');
        Provider.of<User>(context,listen: false).email=pref.getString('email');
        Provider.of<User>(context,listen:false).phone=pref.getString('phone');
      }
    }

    if(!pref.containsKey('address')){
      pref.setString('address','');
      pref.setString('amount', '');
    }
    else if(pref.containsKey('address')){
      Provider.of<Orders>(context,listen: false).customer_address=pref.getString('address');
      Provider.of<Orders>(context,listen: false).service_charge=pref.getString('amount');
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: future_categories,
        builder: (context,snapshot){
        //  print(snapshot.stacktrace);
          if(snapshot.hasData){
            List<Categories> userCategories = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(220, 153, 89, 0.1),
                  title:
                  Column(children: [


                  ],),
                  centerTitle: true,
                  iconTheme: IconThemeData(
                      color: Color.fromRGBO(214, 24, 195, 1)),
                ),
                endDrawer: Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: Color.fromRGBO(66, 7, 91, 0.4)
                    ),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Drawer(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 0.0),
                            child: CategoriesPage(
                              userCategories: userCategories,button_status: button_status,future_product: future_product,),
                          )
                      ),
                    )
                ),

                bottomNavigationBar: CurvedNavigationBar(
                  key: _bottomNavigationKey,

                  index: bottom_navigation_page,
                  items: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _navigatorKey.currentState.pushReplacementNamed('/');
                        });
                      },
                      icon: Icon(Icons.home_outlined,
                        color: bottom_navigation_page == 0
                            ? Colors.white
                            : Colors.black45,
                        size: bottom_navigation_page == 0 ? 35 : 30,),
                      tooltip: 'Home',

                    ),
               //     Provider.of<Cart>(context).cart_size > 0 ?
                    Stack(
                      children: <Widget>[
                        new IconButton(icon: Icon(
                          Icons.add_shopping_cart_outlined,
                          color: bottom_navigation_page == 1
                              ? Colors.white
                              : Colors.black45,
                          size: bottom_navigation_page == 1 ? 35 : 30,),
                          onPressed: () {
                            // bottom_navigation_page=1;
                            setState(() {
                              _navigatorKey.currentState.pushReplacementNamed('/cart_nav');
                            });
                          },),
                        bottom_navigation_page != 1 && Provider.of<Cart>(context).cart_size > 0?
                        new Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: new Stack(
                            children: <Widget>[
                              new Container(width: 30, height: 30,),
                              //   new Icon(Icons.brightness_1,size: 20.0,color: Colors.red,),
                              new Positioned(
                                  top: 3.0,
                                  left: 6.0,
                                  child: Badge(
                                    position: BadgePosition.topEnd(
                                        top: 0, end: 3),
                                    badgeColor: Color.fromRGBO(214, 24, 195, 1),
                                    animationDuration: Duration(
                                        milliseconds: 300),
                                    animationType: BadgeAnimationType.slide,
                                    badgeContent: Text('' + Provider
                                        .of<Cart>(context)
                                        .cart_size
                                        .toString(),
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ) : SizedBox(width: 0, height: 0,)
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.inventory,
                        color: bottom_navigation_page == 2
                            ? Colors.white
                            : Colors.black45,
                        size: bottom_navigation_page == 2 ? 35 : 30,),
                      tooltip: 'Cart Summary',
                      onPressed: () {
                        setState(() {
                          _navigatorKey.currentState.pushReplacementNamed('/order_summary');
                        });
                      },

                    ),

                  ],
                  color: Colors.white,
                  buttonBackgroundColor: Color.fromRGBO(214, 24, 195, 1),
                  backgroundColor: Color.fromRGBO(220, 153, 89, 0.1),
                  animationCurve: Curves.easeInOut,
                  //   height: value==1 ? 0 : 100,
                  animationDuration: Duration(milliseconds: 600),
                  onTap: (index) {
                    setState(() {
                      bottom_navigation_page = index;
                    });

                    if (bottom_navigation_page == 0) {
                      _navigatorKey.currentState.pushReplacementNamed('/');
                    }
                    else if (bottom_navigation_page == 1) {
                      _navigatorKey.currentState.pushReplacementNamed('/cart_nav');
                    }

                    else if (bottom_navigation_page == 2) {
                        _navigatorKey.currentState.pushReplacementNamed('/order_summary');
                    }
                  },
                ),
                body: WillPopScope(
                  onWillPop: () async {
                    if (_navigatorKey.currentState.canPop()) {
                      _navigatorKey.currentState.pop();
                      return false;
                    }

                    return true;
                  },
                  child: Navigator(
                    key: _navigatorKey,
                    initialRoute: '/',
                    onGenerateRoute: (RouteSettings settings) {
                      WidgetBuilder builder;

                      switch (settings.name) {
                        case '/':
                          bottom_navigation_page = 0;
                          builder = (BuildContext context) =>
                              productDashboardContainer();
                          //ProductDashBoard(future_product: future_product,button_status: button_status,);
                          break;
                        case '/cart_nav':
                          bottom_navigation_page = 1;
                          builder = (BuildContext context) => CartPage();
                          break;

                        case '/order_summary':
                          bottom_navigation_page = 2;
                          builder = (BuildContext context) => PreviousOrders(list_orders: list_orders,button_status: button_status1,);
                          break;


                        default:
                          throw Exception('Invalid route: ${settings.name}');
                      }

                      return MaterialPageRoute(
                        builder: builder,
                        settings: settings,
                      );
                    },
                  ),
                )


            );
          }
          else if (snapshot.hasError){
            print(snapshot.error);
            return Material(
              color: Colors.white,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                color: Color.fromRGBO(220, 153, 89, 0.1),
                child: Center(
                  child: Wrap(
                    children: [
                      Text('Network error.Check your internet connection ' ,
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Color.fromRGBO(214,24,195,1)),)
                    ],
                  )
                ),
              ),
            );
          }
          else{
            return  Material(
              color: Colors.white,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                color: Color.fromRGBO(220, 153, 89, 0.1),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(214, 24, 195, 1)),
                    strokeWidth: 5,),
                ),
              ),
            );
          }
        });
  }

Future<List<Categories>> getCategories() async{
  List<Categories> userCategories=await this.productRepository.getCategories().then((value) async{
    getListno=value.length;
    button_status=new List(getListno);
    for(int i=0;i<getListno;i++){
      button_status[i]=false;
      print("The value of i is " + button_status[i].toString());
    }
    return value;
  });

  if(pref.getString('phone').isNotEmpty) {
    list_orders = await this.getOrders(pref.getString('phone')).then((value){
      getListno1=value.length;
      button_status1=new List(getListno1);
      for(int i=0;i<getListno1;i++){
        button_status1[i]=false;
        print("The value of i is " + button_status1[i].toString());
      }
      return value;
    });
  }

  else{
    list_orders=[];
  }
  return userCategories;
}

  Future<List<Product>> getProducts() async {
    all_products = await this.productRepository.getProducts().then((value){
      getListno=value.length;
      button_status=new List(getListno);
      for(int i=0;i<getListno;i++){
        button_status[i]=false;
        print("The value of i is " + button_status[i].toString());
      }


      return value;
    });
    return all_products;
  }

  Future<List<Product>> getProductByCategory(String category) async{
    products_by_categories=await this.productRepository.getProductByCategories(category);/*.then((value){
      getListno=value.length;
      button_status=new List(getListno);
      for(int i=0;i<getListno;i++){
        button_status[i]=false;
        print("The value of i is " + button_status[i].toString());
      }

      return value;
    });*/
    return products_by_categories;
  }

  Widget productDashboardContainer(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(220, 153, 89, 0.1),
       // margin: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
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
                                    print('The future set is a new future');
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
                child: ProductDashBoardItem(context: context,
                    future_product: Provider.of<Categories>(context).name.isEmpty ? future_product :
                    this.getProductByCategory(Provider.of<Categories>(context).name)),
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

  Future<List<Orders>> getOrders(String phone_number) async{
    if(phone_number.isNotEmpty){
      list_orders=await orderRepository.getOrders(phone_number);
      return list_orders;
    }

    else{
      list_orders=[];
      setState(() {
        error_message='No transactions available';
      });
      return list_orders;
    }

  }

}


//#dc9959

/*
* return
* */