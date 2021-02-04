import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class ShoppingCart extends StatefulWidget{
  ShoppingCart({Key key}): super(key:key);

  @override
  ShoppingCart_state  createState()=> new ShoppingCart_state();
}

class ShoppingCart_state extends State<ShoppingCart>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _shoppingCartBadge();
  }
}

Widget _shoppingCartBadge() {
  return Badge(
    position: BadgePosition.topEnd(top: 0, end: 3),
    animationDuration: Duration(milliseconds: 300),
    animationType: BadgeAnimationType.slide,
    badgeContent: Text(
      '1',
      style: TextStyle(color: Colors.white),
    ),
    child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
  );
}