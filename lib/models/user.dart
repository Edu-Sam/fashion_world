
import 'package:flutter/cupertino.dart';

class User with ChangeNotifier{
  int cust_id;
  String username;
  String credit;
  String fname;
  String lname;
  String phone;
  String location;
  String email;
  String avatar;
  String add_date;
  String logged;

  User.init({this.cust_id,this.username,this.credit,this.fname,this.lname,this.phone,this.location,this.email,this.avatar,
            this.add_date,this.logged});
  User.setup({this.username,this.credit,this.fname,this.lname,this.phone,this.location,this.email,this.logged});

  Map<String,dynamic> toJson()=>{
    'username':this.username,
    'credit':this.credit,
    'fname':this.fname,
    'lname':this.lname,
    'phone':this.phone,
    'location':this.location,
    'email':this.email,
    'logged':this.logged
  };

  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User.init(
      cust_id: parsedJson['cust_id'],
      username: parsedJson['username'],
      credit: parsedJson['credit'],
      fname: parsedJson['fname'],
      lname: parsedJson['lname'],
      phone:parsedJson['phone'],
      location: parsedJson['location'],
      email: parsedJson['email'],
      avatar: parsedJson['avatar'],
      add_date: parsedJson['add_date'],
      logged: parsedJson['logged']
    );
  }



}