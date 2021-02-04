import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_world/services/product_repository.dart';

class UserContainer extends StatefulWidget{
  UserContainer({Key key}): super(key: key);

  @override
  UserContainer_state createState()=> UserContainer_state();
}

class UserContainer_state extends State<UserContainer>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductRepository productRepository=new ProductRepository();
    productRepository.getProducts();
  }
  int _payment_value=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      elevation: 0,
       backgroundColor:Color.fromRGBO(220, 153, 89,0.1),
        title: Text('Checkout',style: TextStyle(color: Color.fromRGBO(214,24,195,1))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(214,24,195,1)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color:Color.fromRGBO(220,153,89,0.1),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1/6,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0,3.0),
                      blurRadius: 5.0,
                      spreadRadius: 3.0,
                      color: Colors.black12
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0,right: 10.0,left: 10.0,),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text('Order details',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,
                                color: Color.fromRGBO(214,24,195,1)),),
                              IconButton(icon:Icon(Icons.close_outlined,color: Color.fromRGBO(214,24,195,1),
                              size: 20,),
                              onPressed: (){

                              },
                              )
                          ],),

                          /*Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                            child: Column(
                              children: [
                                Text('Edwin S.Ngugi',style: TextStyle(fontFamily: 'roboto',fontSize: 14,color: Colors.black,
                                fontWeight: FontWeight.w600),)
                              ],
                            ),
                          )*/
                        ],
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 5.0),
                        child: Icon(Icons.shopping_cart,color: Color.fromRGBO(214,24,195,1),size: 70,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right:0),
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
                            child: Text('000001',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,
                                color:Colors.black54 ),),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 5.0),
                            child: Text('10 items',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,
                                color:Colors.black45 ),),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                            child: Text('21/12/2020',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,
                                color:Colors.black38 ),),),



                        ],),

                      ),
                        Padding(
                          padding:EdgeInsets.only(left: MediaQuery.of(context).size.width *2/5),

                          child: Text("Ksh 1000",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(214,24,195,1)),),
                        )
                    ],),



                   /*
                    ),*/
                  ],
                ),
              ),


            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height *3/5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0,3.0),
                      blurRadius: 5.0,
                      spreadRadius: 3.0,
                      color: Colors.black12
                    )
                  ]
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                      child: Column(
                        children: [
                          Text('Payment Info',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,
                              color: Color.fromRGBO(214,24,195,1)),),
                          Divider(color: Colors.black12,)
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                      child: Column(
                        children: [
                          DropdownButtonHideUnderline(child:
                          DropdownButton(
                            value: _payment_value,
                            iconEnabledColor: Color.fromRGBO(214,24,195,1),
                            items: [
                              DropdownMenuItem(child: Text('Select Mode Of Payment',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,
                                    color: Color.fromRGBO(214,24,195,1)),),
                                value: 1,),
                              DropdownMenuItem(child: Text("Cash",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w700,color: Colors.black54),),value: 2,),
                              DropdownMenuItem(child: Text("MPESA",style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w700,color: Colors.green),),value: 3,),
                            ],
                            onChanged: (value){
                              setState((){
                                _payment_value=value;
                              });
                            },
                          ))
                        ],
                      ),
                    ),

                    _payment_value!=1 ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1/4,
                      child: _payment_value==3 ? Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                            child: Column(children: [
                              TextField(
                                style: TextStyle(fontSize: 14.0),
                                autofocus: false,
                                decoration: InputDecoration(hintText: 'Enter Mpesa phone number',
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                  filled: true,
                                  fillColor: Color.fromRGBO(220, 153, 89,0.1),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(214,24,195,1)),
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),


                                ),

                              ),
                            ],),
                          ),

                          Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                            child: Column(children: [
                              TextField(
                                style: TextStyle(fontSize: 14.0),
                                autofocus: false,
                                decoration: InputDecoration(hintText: 'Enter Amount due in Ksh',
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                  filled: true,
                                  fillColor: Color.fromRGBO(220, 153, 89,0.1),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromRGBO(214,24,195,1)),
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),


                                ),

                              ),
                            ],),
                          ),

                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 8/10,
                                height: 50,
                                child: RaisedButton(
                                  child: Text("Confirm Payment",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,
                                      color: Colors.white),),
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  onPressed: (){},
                                ),
                              )
                          )
                        ],
                      ):
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                              child: Text('Amount in cash to be paid:',
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.green),)),
                              Padding(padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                  child: Text('Ksh 1000',
                                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.green),)),
                              Padding(padding:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: RaisedButton(
                                  child: Text("Confirm and Continue",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,
                                      color: Colors.white),),
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  onPressed: (){},
                                ),
                              )
                              )
                            ],
                          )

                    ) :
                        Container()


                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}