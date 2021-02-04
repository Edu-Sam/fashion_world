import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget{
  ProductDetails({Key key}):super(key:key);

  @override
  ProductDetails_state createState()=>ProductDetails_state();

}

class ProductDetails_state extends State<ProductDetails>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       elevation: 0,
       backgroundColor: Color.fromRGBO(220, 153, 89,0.1),
     ),
     body: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         color: Color.fromRGBO(220, 153, 89,0.1),

         child: Padding(
           padding: EdgeInsets.symmetric(vertical: 100.0,horizontal: 0.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               GestureDetector(
                 child: Center(
                     child: Hero(
                       tag:'ImageHero',
                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         height: 200,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             image: DecorationImage(
                                 image: NetworkImage( "https://ke.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/44/415062/1.jpg?3552")
                             )
                         ),
                       ),
                     )
                 ),
               )
             ],
           ),
         )
     ),
   );
  }
}