import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fashion_world/models/domain_server.dart';
import 'package:fashion_world/models/orders.dart';
import 'package:fashion_world/models/user.dart';
import 'package:fashion_world/models/cart.dart';

class OrderRepository{
  final String url_insert_orders=
      "${DomainServer.name}androidfashion/insert_orders.php";
  final String url_insert_customer=
      "${DomainServer.name}androidfashion/insert_customer.php";
  final String url_insert_order_items="${DomainServer.name}androidfashion/insert_order_items.php";
  final String url_check_user="${DomainServer.name}androidfashion/check_user.php";
  final String url_get_previous_receipt_no="${DomainServer.name}androidfashion/check_max_order.php";
  final String url_order_history="${DomainServer.name}androidfashion/fetchorderhistory.php";

  OrderRepository() {

  }
  Future<String> insertOrders(Orders orders) async{
    http.Response response=await http.post(
      url_insert_orders,
      headers: {"Accept":"application/json"},
        body: {'bill_no':orders.bill_no,'customer_name':orders.customer_name,
          'customer_address':orders.customer_address,'customer_phone':orders.customer_phone,
          'gross_amount':orders.gross_amount.toString(),'service_charge':orders.service_charge,
          'vat_charge_rate':orders.vat_charge_rate,'net_amount':orders.net_amount.toString(),
          'discount':orders.discount,'type':orders.type,'invoice_no':orders.invoice_no,
          'receipt_no':orders.receipt_no,'paid_status':orders.paid_status,'user_id':orders.user_id
        }
    );

    var result=response.body;
    String userResponse=result.toString();
    if(userResponse=='201'){
      print('Order Response is ' + userResponse);
      String final_result='OK';
      return final_result;
    }
    else{
      print('Order Response is ' + userResponse);
      return 'FAILED';

    }
     }

  Future<String> insertOrderItems(CartItemsData data,Orders orders) async{
    print('The product id is ' + data.pId);
    print('The line total is ' + data.line_total.toString());
    http.Response response=await http.post(
        url_insert_order_items,
        headers: {"Accept":"application/json"},
        body: {'bill_no':orders.bill_no,'order_id':orders.receipt_no,
          'product_id':data.pId.toString(),'qty':data.quantity,
          'amount':data.line_total.toString(),'username':orders.customer_name, "store":'G12'
        }
    );

    var result=response.body;
    String userResponse=result.toString();
    if(userResponse=='203'){
      String final_result='OK';
      return final_result;
    }
    else{
      return 'FAILED';
    }
  }

  Future<bool> checkUser(String phone_number) async{
    http.Response response=await http.post(
        url_check_user,
        headers: {"Accept":"application/json"},
        body: {'phone_number':phone_number}
    );

    var result=response.body;
    String userResponse=result.toString();
    if(userResponse=='NOT OK'){
      print('The value of the user is ' + userResponse);
      return true;
    }
    else{
      print('The value of the user is ' + userResponse);
      return false;
    }
  }

  Future<String> getPreviousReceiptNo() async{
    http.Response response=await http.post(
        url_get_previous_receipt_no,
        headers: {"Accept":"application/json"},
    );

    var result=response.body;
    String userResponse=result.toString();
    print('User1 response is ' + userResponse);
    return userResponse;
  }

  Future<bool> insertCustomer(User user) async{
    http.Response response=await http.post(url_insert_customer,headers: {"Accept":"Application/json",},
        body:{"username":user.username,"phone":user.phone,"email":user.email
    }
    );

    var result=response.body;
    String userResponse=result.toString();
    if(userResponse=="OK"){
      print('Response is '+ userResponse);
      return true;
    }
    else{
      print('Response is '+ userResponse);
      return false;
    }
  }

  Future<List<Orders>> getOrders(String phone_number) async{
    final url= "https://queensclassycollections.com/androidfashion/fetchorderhistory.php";
   try{
     final response = await http.post(url_order_history,
         headers: {"Accept":"Application/json"},
         body: {'phone':phone_number}
     );

     var orders = jsonDecode(response.body);
  //   print(orders["orders"]["order_items"]);
     var list_orders = orders["orders"] as List;
     List<Orders> user_orders = list_orders.map<Orders>((json) => Orders.fromJson(json)).toList();
     return user_orders;
   }

   catch(e,stacktrace){
     print(stacktrace);
    }
  }
}


