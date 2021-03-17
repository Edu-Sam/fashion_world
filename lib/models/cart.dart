import 'package:flutter/foundation.dart';
import 'dart:convert';

CartItemsData cartItemsDataFromJson(String str) => CartItemsData.fromJson(json.decode(str));

String cartItemsDataToJson(CartItemsData data) => json.encode(data.toJson());
class Cart with ChangeNotifier{
  int cart_id;
  int total_amount=0;
  List<CartItemsData> cart_items_data=[];

  int cart_size=0;
  Cart({this.cart_id,this.cart_size,this.total_amount,this.cart_items_data});

  Map<String,dynamic> toJson()=>{
    'cart_size':this.cart_size,
    'total_amount':this.total_amount,
    'cart_items_data':List<dynamic>.from(this.cart_items_data.map((e)=> e.toJson()))
  };

  factory Cart.fromJson(Map<String,dynamic> json){
    if(json['cart_items_data']!=null){
      var cartItemsObject=json['cart_items_data'] as List;
      List<CartItemsData> _cart_items_data=cartItemsObject.map((e) => CartItemsData.fromJson(e)).toList();

      return Cart(
        cart_id: json['id'],
        cart_size: json['cart_size'],
        total_amount: json['total_amount'],
        cart_items_data:_cart_items_data
      );
    }

    else{
      return Cart(
          cart_id: json['id'],
          cart_size: json['cart_size'],
          total_amount: json['total_amount'],
          cart_items_data:[]
      );
    }

  }

  void increaseCartSize(CartItemsData data){
    cart_items_data.add(data);
    this.cart_size++;
    notifyListeners();
  }

  int calculateLineTotal(CartItemsData data){

      data.line_total=0;
      int new_price=int.parse(data.price);
      int new_quantity=int.parse(data.quantity);
      data.line_total=new_price * new_quantity;
    //notifyListeners();

    return data.line_total;
  }

  int calculateTotal(){
    total_amount=0;
    for(int i=0;i<cart_items_data.length;i++){
  //    int temp_line_total=int.parse(cart_items_data.elementAt(i).line_total);
      int temp_price=int.parse(cart_items_data.elementAt(i).price);
      int init_price=int.parse(cart_items_data.elementAt(i).price);
      int init_quantity=int.parse(cart_items_data.elementAt(i).quantity);
      int init_total=init_price * init_quantity;
      total_amount=total_amount + init_total;
    //  total_amount=total_amount + temp_price;
    }
    //notifyListeners();
    return total_amount;
  }

  removeItem(int index){
    cart_items_data.removeAt(index);
    notifyListeners();
  }

  resetCart(){
    cart_size=0;
    total_amount=0;
    cart_items_data=[];
    notifyListeners();
  }

  int calculate_gross_total(String delivery_fee){

    double temp_total=total_amount.toDouble();
    double temp_delivery_fee=int.parse(delivery_fee).toDouble();
    double final_amount=total_amount + temp_delivery_fee;
   // double final_amount=temp_total + temp_delivery_fee;
    int gross_amount=final_amount.toInt();
    //notifyListeners();
    return gross_amount;
  }

}

class CartItemsData {
  CartItemsData({
    this.orderNo,
    this.pId,
    this.pName,
    this.price,
    this.size,
    this.color,
    this.quantity,
    this.line_total
  });

  String orderNo;
  String pId;
  String pName;
  String price;
  String size;
  String color;
  String quantity;
  int line_total=0;

  factory CartItemsData.fromJson(Map<String, dynamic> json) => CartItemsData(
    orderNo: json["order_no"],
    pId: json["p_id"],
    pName: json["p_name"],
    price: json["price"],
    size: json["size"],
    color: json["color"],
    quantity: json["quantity"],
    line_total: json['line_total']
  );

  Map<String, dynamic> toJson() => {
    "order_no": orderNo,
    "p_id": pId,
    "p_name": pName,
    "price": price,
    "size": size,
    "color": color,
    "quantity": quantity,
    'line_total':line_total
  };
}

