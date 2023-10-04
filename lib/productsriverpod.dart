import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'Products.dart';
import 'RepsMain.dart';
class ProductsProvider extends Notifier<List<Products>> {
  List<Products> products=[];
  @override
  List<Products> build() => products;

  void update(){
    fetchproducts();
  }
  Future<void> fetchproducts()  async {
    final response = await http.get(Uri.parse("https://dummyjson.com/products"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      var getTodosData = json.decode(response.body.toString());
      var res=RepsMain.fromJson(getTodosData);
      state  =res.products ;
      products=res.products;
      print(state.toString());

    } else {
      throw Exception('Failed to load products');
    }
  }
}
