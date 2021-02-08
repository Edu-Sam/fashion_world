import 'package:flutter/material.dart';
import 'package:fashion_world/styles/CustomTextStyle.dart';
import 'package:fashion_world/styles/customUtils.dart';
import 'package:fashion_world/models/cart.dart';
//import 'package:home3_app/checkoutpage.dart';
import 'package:fashion_world/widgets/cart_counter.dart';
import 'package:provider/provider.dart';
import 'package:fashion_world/pages/user_container.dart';

class CartPage extends StatefulWidget {

  CartPage({Key key}):super(key:key);
  @override
  _CartPageState createState() => _CartPageState();

}
class _CartPageState extends State<CartPage> {
  //_CartPageState(this.cart);
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(220, 153, 89,0.1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            createHeader(),
            createSubTitle(),
            Container(width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height *3/5,
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: Provider.of<Cart>(context,listen: false).cart_size,
                itemBuilder: (context,index){
                  return createCartListItem(Provider.of<Cart>(context,listen: false).cart_items_data.elementAt(index),index);
                }),),
            footer(context)
          ],
        ),
      )
    );
  }

  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Text(
                  'Ksh ' + Provider.of<Cart>(context,listen: false).calculateTotal().toString(),
                  style: CustomTextStyle.textFormFieldBlack.copyWith(
                      color: /*Colors.greenAccent.shade700*/ Color.fromRGBO(214,24,195,1), fontSize: 14),
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 8),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>UserContainer()),);
            },
            color: Color.fromRGBO(214,24,195,1),
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Checkout",
              style: CustomTextStyle.textFormFieldSemiBold
                  .copyWith(color: Colors.white),
            ),
          ),
          Utils.getSizedBox(height: 8),
        ],
      ),
      margin: EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "SHOPPING CART",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 16, color: Color.fromRGBO(214,24,195,1)),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total (" + Provider.of<Cart>(context,listen: false).cart_size.toString() + ') items',
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }


  createCartListItem(CartItemsData data,int currentIndex) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: AssetImage("images/bag_1.png"))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          data.pName,
                          maxLines: 2,
                          softWrap: true,
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      Utils.getSizedBox(height: 6),
                      Text(
                         'Size: ' + data.size,
                        style: CustomTextStyle.textFormFieldRegular
                            .copyWith(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Ksh ' + data.price,
                                  style: CustomTextStyle.textFormFieldBlack
                                      .copyWith(color: Color.fromRGBO(214,24,195,1)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[

                                      IconButton(
                                       icon: Icon (Icons.remove, size: 24, color: Colors.grey.shade700,),
                                        onPressed: (){
                                         subtractQuantity(data);
                                        },
                                      ),

                                      Container(
                                        color: Colors.grey.shade200,
                                        padding: const EdgeInsets.only(
                                            bottom: 2, right: 12, left: 12),
                                        child: Text(
                                          data.quantity,
                                          style:
                                          CustomTextStyle.textFormFieldSemiBold,
                                        ),
                                      ),
                                     IconButton(
                                       icon:Icon(Icons.add, size: 24, color: Colors.grey.shade700,),
                                       onPressed: (){
                                         addQuantity(data);
                                       },
                                     ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Ksh ' + Provider.of<Cart>(context,listen: false).calculateLineTotal(data).toString(),
                                  style: CustomTextStyle.textFormFieldBlack
                                      .copyWith(color: Color.fromRGBO(214,24,195,1)),
                                ),
                              ],
                            ),
                          )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: (){
              setState(() {
                removeItem(currentIndex);
              });
            },
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10, top: 8),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Color.fromRGBO(214,24,195,1)),
            ),
          )
        )
      ],
    );
  }

  void removeItem(int current_index){
    setState(() {
      Provider.of<Cart>(context,listen:false).removeItem(current_index);
      Provider.of<Cart>(context,listen: false).cart_size--;
    });
  }

  void addQuantity(CartItemsData data){
    String temp_quantity=data.quantity;
    int new_quantity=int.parse(temp_quantity);
    new_quantity++;
    setState((){
      data.quantity=new_quantity.toString();
    });
}

void subtractQuantity(CartItemsData data){
  String temp_quantity=data.quantity;
  int new_quantity=int.parse(temp_quantity);
  if(new_quantity > 0){
    new_quantity--;
    setState(() {
      data.quantity=new_quantity.toString();
    });
  }
}

/*
* 86,38,138
* 113,200,103
* 197,62,46
* */
}