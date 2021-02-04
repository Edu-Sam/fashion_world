import 'package:flutter/material.dart';

class CategoriesDashboard extends StatefulWidget{
  CategoriesDashboard({Key key}):super(key:key);

  @override
  CategoriesDashboard_state createState()=> CategoriesDashboard_state();
}

class CategoriesDashboard_state extends State<CategoriesDashboard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height:   MediaQuery.of(context).size.height,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.vertical,

        children: <Widget>[

          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,horizontal: 20.0
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width *1/3,
                  height: MediaQuery.of(context).size.height * 1/7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,

                  ),
                  child: Column(
                    children: [
                      Text("Jackets")
                    ],
                  ),
                ),
              )
            ],
          )

        ],
      ),
    );

  }
}