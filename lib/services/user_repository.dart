import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fashion_world/models/products.dart';
import 'package:fashion_world/models/domain_server.dart';

class UserRepository{
  final String url = "${DomainServer.name}androidfashion/create_user.php";


  Future<int> insertCustomers(){

  }
}