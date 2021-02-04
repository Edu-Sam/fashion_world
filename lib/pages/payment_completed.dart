import 'package:flutter/material.dart';
import 'package:fashion_world/styles/customUtils.dart';
import 'package:fashion_world/styles/CustomTextStyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentCompleted extends StatefulWidget{
  PaymentCompleted({Key key}):super(key:key);

  @override
  PaymentCompletedState createState()=> PaymentCompletedState();
}

class PaymentCompletedState extends State<PaymentCompleted>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color:Colors.white,
         border: Border.all(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                   child: Padding(
                     padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                     child: Text('Transaction successful',style: TextStyle(color: Color.fromRGBO(214,24,195,1),
                         fontSize: 15,fontWeight: FontWeight.w700
                     ),),
                   ),
                  ),
            //      Icon(Icons.check,size: 50,),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                          "\n\nThank you for your purchase. We strive to provide state-of-the-art designs that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                          style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 16),
                        )
                      ])),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 4/5,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Continue Shopping",
                        style: CustomTextStyle.textFormFieldMedium
                            .copyWith(color: Colors.white),
                      ),
                      color: Color.fromRGBO(214,24,195,1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    ),
                  ),
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
                   child:  Container(
                     width: MediaQuery.of(context).size.width * 4/5,
                     height: 50,
                     child: OutlineButton(
                       onPressed: () {},
                       padding: EdgeInsets.only(left: 48, right: 48),
                       child: Text(
                         "Exit",
                         style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'Open Sans',color: Colors.black54),
                       ),
                       //    color: Color.fromRGBO(214,24,195,1),
                       borderSide: BorderSide(color: Colors.black54),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(24))),
                     ),
                   ),
                 )
                ],
              ),
            ),
            flex: 5,
          )
        ],
      ),
    );
  }

}