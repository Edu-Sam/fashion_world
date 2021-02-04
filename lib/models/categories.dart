import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';


Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoryToJson(Categories data) => json.encode(data.toJson());

class Categories with ChangeNotifier{
  int id;
  String name;
  String description;
  int active;

  Categories({this.name,this.description});

  Map<String,dynamic> toJson()=>{
    'name':this.name,
    'description':this.description
  };

  factory Categories.fromJson(Map<String,dynamic> json){
    return Categories(
      name:json['name'],
      description: json['description']
    );
  }

  updateName(String new_name){
    this.name=new_name;
    notifyListeners();
  }

  flushName(){
    this.name='';
    notifyListeners();
  }


}