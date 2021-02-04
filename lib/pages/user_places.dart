import 'package:flutter/material.dart';

class UserPlaces extends StatefulWidget{
  UserPlaces({Key key}): super(key:key);

  @override
  UserPlacesState createState()=>new UserPlacesState();
}

class UserPlacesState extends State<UserPlaces>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(220, 153, 89, 0.1),

      child: Column(
        children: [

        ],
      ),
    );
  }
}