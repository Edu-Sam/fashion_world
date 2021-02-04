import 'dart:convert';
import  'package:flutter/foundation.dart';
import 'package:fashion_world/models/products.dart';

class Orders with ChangeNotifier{
  String id='';
  String bill_no='Mpesa no',customer_name='Edwin Ngugi', customer_address='Eldoret', customer_phone='0702181403',
      gross_amount='2000',service_charge='250',vat_charge_rate='16%',net_amount='2250', discount='0', type='mpesa', invoice_no='0000001',
      receipt_no='0000001';
  String paid_status='1',
  qty='0',
  added_date='',
      user_id='1';
  List<OrderItems> orderItems;

  Orders({this.id, this.bill_no,
    this.customer_name,
    this.customer_address,
    this.customer_phone,
    this.gross_amount,
    this.qty,
    this.added_date,
    this.service_charge,
    this.vat_charge_rate,
    this.net_amount,this.discount,
    this.type,this.invoice_no,
    this.receipt_no,
    this.paid_status,
    this.user_id,
     this.orderItems});
  Orders.setup({this.bill_no,this.customer_name,this.customer_address,this.customer_phone,this.gross_amount,
    this.qty, this.added_date, this.service_charge,this.vat_charge_rate,
    this.net_amount,this.discount,this.type,this.invoice_no,this.receipt_no,this.paid_status,this.user_id});

  Map<String,dynamic> toJson()=>{
    'bill_no':this.bill_no,
    'customer_name':this.customer_name,
    'customer_address':this.customer_address,
    'customer_phone':this.customer_phone,
    'gross_amount':this.gross_amount,
    'qty':this.qty,
    'added_date':this.added_date,
    'service_charge':this.service_charge,
    'vat_charge_rate':this.vat_charge_rate,
    'net_amount':this.net_amount,
    'discount':this.discount,
    'type':this.type,
    'invoice_no':this.invoice_no,
    'receipt_no':this.receipt_no,
    'paid_status':this.paid_status,
    'user_id':this.user_id,
    'order_items': List<dynamic>.from(orderItems.map((x)=>x.toJson()))
  };

  resetOrders(){
    bill_no='';
    customer_name='';
    customer_address='';
    customer_phone='';
    gross_amount='';
    qty='';
    added_date='';
    service_charge='';
    vat_charge_rate='';
    net_amount='';
    discount='';
    type='';
    invoice_no='';
    receipt_no='';
    paid_status='';
    user_id='';
    orderItems=[];
    notifyListeners();
  }

  factory Orders.fromJson(Map<String,dynamic> parsedJson){
    List<OrderItems> list_order_items;
    if(parsedJson['order_items']!=null){
     /* var order_items_object=parsedJson['order_items'] as List;
      list_order_items=order_items_object.map((item) => OrderItems.fromJson(item)).toList();*/
      list_order_items=List<OrderItems>.from(parsedJson["order_items"].map((x) => OrderItems.fromJson(x)));
}
    else{
      list_order_items=[];
}
    return Orders(
      id: parsedJson['id'],
      bill_no: parsedJson['bill_no'],
      customer_name: parsedJson['customer_name'],
      customer_address: parsedJson['customer_address'],
      customer_phone: parsedJson['customer_phone'],
      gross_amount: parsedJson['gross_amount'],
      qty: parsedJson['qty'],
      added_date: parsedJson['added_date'],
      service_charge: parsedJson['service_charge'],
      vat_charge_rate: parsedJson['vat_charge_rate'],
      net_amount: parsedJson['net_amount'],
      discount: parsedJson['discount'],
      type: parsedJson['type'],
      invoice_no: parsedJson['invoice_no'],
      receipt_no: parsedJson['receipt_no'],
      paid_status: parsedJson['paid_status'],
      user_id: parsedJson['user_id'],
      orderItems: list_order_items
    );
  }

}

class OrderItems with ChangeNotifier{
  String id;
  String bill_no;
  String order_id;
  String product_id;
  String qty;
  String amount;
  String username;
  String store;
  List<Product> products;

  OrderItems({this.id,this.bill_no,this.order_id,this.product_id,this.qty,this.amount,this.username,this.store,this.products});
  Map<String,dynamic> toJson()=>{
    'bill_no':this.bill_no,
    'order_id':this.order_id,
    'product_id':this.product_id,
    'qty':this.qty,
    'amount':this.amount,
    'username':this.username,
    'store':this.store,
    'products':List<dynamic>.from(products.map((e) =>e.toJson()))
  };

  factory OrderItems.fromJson(Map<String,dynamic> parsedJson){
    List<Product> list_products;
    if (parsedJson['products'] != null) {
      /*var productObject = parsedJson['products'] as List;
       list_products = productObject
          .map((productJson) => Product.fromJson(productJson))
          .toList();*/
      list_products=List<Product>.from(parsedJson["products"].map((x) => Product.fromJson(x)));
    }

    else{
      list_products=[];
    }
    return OrderItems(
    id:parsedJson['id'],
    bill_no:parsedJson['bill_no'],
    order_id:parsedJson['order_id'],
    product_id:parsedJson['product_id'],
    qty:parsedJson['qty'],
    amount:parsedJson['amount'],
    username:parsedJson['username'],
    store:parsedJson['store'],
    products:list_products,
    );
}
}