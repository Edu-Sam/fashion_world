class OrderModel {
  String order_id;
  String qty;
  String amount;

  OrderModel({this.order_id,this.qty,this.amount});

  factory OrderModel.fromJson(final json){
    return OrderModel(
        order_id: json["order_id"],
        qty : json["qty"],
        amount: json["amount"]

    );


  }
}

class OrderSummary {
  String bill_no;
  String customer_name;
  String customer_address;
  String customer_phone;
  String gross_amount;
  String service_charge;
  String vat_charge_rate;
  String net_amount;
  String user_id;
  String order_id;
  String qty;
  String amount;
  String product_id;
  String name;
  String added_date;

  OrderSummary(
      {this.bill_no,this.name,this.added_date,this.product_id, this.order_id,this.qty,this.amount,this.customer_name, this.customer_address, this.customer_phone, this.gross_amount, this.net_amount, this.service_charge, this.vat_charge_rate, this.user_id});


  factory OrderSummary.fromJson(final json){
    return OrderSummary(
      bill_no: json["bill_no"],
      customer_name: json["customer_name"],
      customer_address:  json["customer_address"],
      customer_phone:  json["customer_phone"],
      gross_amount:  json["gross_amount"],
      net_amount: json["net_amount"],
      service_charge:  json["service_charge"],
      vat_charge_rate: json["vat_charge_rate"],
      user_id:  json["user_id"],
      order_id: json["order_id"],
      qty : json["qty"],
      amount: json["amount"],
      name : json["name"],
      added_date : json["added_date"],


    );
  }
}