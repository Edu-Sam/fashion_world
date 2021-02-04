import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:fashion_world/models//data.dart';
//import 'package:googleapis/adsense/v1_4.dart';
import 'package:http/http.dart' as http;
import 'package:fashion_world/styles/CustomTextStyle.dart';
import 'package:fashion_world/models/orders.dart';
import 'package:fashion_world/services/order_repository.dart';
import 'package:provider/provider.dart';

class PreviousOrders extends StatefulWidget{
  PreviousOrders({Key key,@required this.list_orders,@required this.button_status}):super(key:key);
  List<Orders> list_orders;
  var button_status;

  @override
  PreviousOrderState createState()=>PreviousOrderState(list_orders,button_status);
}

class PreviousOrderState extends State<PreviousOrders>{
  List UserOrder;
  String phone_number;
  List<Orders> list_orders;
  var button_status;

  PreviousOrderState(this.list_orders,this.button_status);

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('The list size is ' + list_orders.length.toString());
    return SingleChildScrollView(
        child: Container(
            color: Color.fromRGBO(220, 153, 89, 0.1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                createHeader(),
                createSubTitle(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 3/4 ,
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context,index){
                        return  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                                child:  AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width: MediaQuery.of(context).size.width,
                                  height: button_status[index] ? MediaQuery.of(context).size.height * 1/3 : MediaQuery.of(context).size.height * 1/8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(1.0,1.0),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        color: Colors.black12
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: ExpansionTile(
                                    onExpansionChanged: (item){
                                      if(item){
                                        setState(() {
                                          button_status[index]=true;
                                        });
                                      }
                                      else{
                                        setState(() {
                                          button_status[index]=false;
                                        });
                                      }
                                    },
                                    title:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 1.0),
                                                  child: Text("Order no: " + list_orders.elementAt(index).invoice_no,style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                                                      fontSize: 14,
                                                      color: Color.fromRGBO(214, 24, 195, 1),
                                                      fontWeight: FontWeight.w400),),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10.0),
                                                  child: Text("Ksh " + list_orders.elementAt(index).net_amount,style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w400),),),
                                              ],
                                            )
                                        ),
                                        Divider(),




                                      ],
                                    ),
                                    children:[
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height * 1/6,
                                     //     color: Colors.black54,
                                          child: ListView(
                                            children: list_orders.elementAt(index).orderItems.map((e){
                                              return Padding(
                                                padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 30.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 2/5,
                                                          height: 15,
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                            child: Text(e.products.elementAt(0).name,style: TextStyle(
                                                                color: Colors.black54,fontSize: 10,fontWeight: FontWeight.w600
                                                            ),),
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 1/6,
                                                          height: 15,
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                            child: Text(e.qty,style: TextStyle(
                                                                color: Colors.black54,fontSize: 10,fontWeight: FontWeight.w600
                                                            ),),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 1/7,
                                                          height: 15,
                                                          child:  Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                            child: Text(e.amount,style: TextStyle(
                                                                color: Colors.black54,fontSize: 10,fontWeight: FontWeight.w600
                                                            ),),
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 30.0),
                                        child:  Container(
                                    //      color: Colors.red,
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height * 1/18,
                                          child: Column(
                                            children: [
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 2/5,
                                                        height: 15,
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                          child: Text("Total",style: TextStyle(
                                                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800
                                                          ),),
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 1/6,
                                                        height: 15,
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                          child: Text(list_orders.elementAt(index).qty,style: TextStyle(
                                                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800
                                                          ),),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 1/7,
                                                        height: 15,
                                                        child:  Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                          child: Text(list_orders.elementAt(index).net_amount,style: TextStyle(
                                                              color: Colors.black,fontSize: 11,fontWeight: FontWeight.w800
                                                          ),),
                                                        ),
                                                      )
                                                    ],
                                                  ),


                                                ],
                                              ),
                                            ],
                                          )
                                        )
                                      )
                                    ]
                                    ,
                                  )
                                )
                              )
                            ],
                          ),
                          /*child:ExpansionTile(
                                title: Text(user_orders.elementAt(index).bill_no),
                                children: [

                              ],),*/);
                      })
                )
              ],
            )
        )
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
    //  color: Color.fromRGBO(220, 153, 89, 0.1),
      child: Text(
        "Order history",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Color.fromRGBO(214,24,195,1)),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
     // color: Color.fromRGBO(220, 153, 89, 0.1),
      child: Text(
        "Displaying the last 2 orders",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }


}



/*
* Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                              child:  Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 1.0),
                                                    child: Text("Order no:00002",style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(214, 24, 195, 1),
                                                        fontWeight: FontWeight.w400),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10.0),
                                                    child: Text("Ksh 2000",style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                                                        fontSize: 12,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w400),),),
                                                ],
                                              )
                                          ),
                                          Divider(),




                                        ],
                                      ),
* */
