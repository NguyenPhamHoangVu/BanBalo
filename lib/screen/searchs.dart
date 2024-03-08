import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_ban_balo/screen/prdetails.dart';

import 'package:test_ban_balo/models/api2model.dart';

final formatCurrency = NumberFormat('00,000', 'en_US');
class fetchProducts {
  var data = [];
  List<Product1> results = [];
  String urlList = 'https://localhost:7186/api/Products';

  Future<List<Product1>> getproductsList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
      
        data = json.decode(response.body);
        results = data.map((e) => Product1.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.name.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("Lỗi feach");
      }
    } on Exception catch (e) {
      print('Lỗi: $e');
    }
    return results;
  }
}
class SearchProducts extends SearchDelegate {
  fetchProducts productslist = fetchProducts();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
        color: Colors.orange,
        iconSize: 30,
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.orange,
      iconSize: 30,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Product1>>(
      future: productslist.getproductsList(query: query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Product1>? data = snapshot.data;
        if (data!.length == 0) {
          return Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Không có sản phẩm ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    query,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return GridView.count(
          crossAxisCount: 2, // Số cột trong grid
          children: List.generate(
            data.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  // Chuyển đến chi tiết sản phẩm khi nhấp vào mỗi sản phẩm
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        product: data[index],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 200,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Positioned(
                            width: 20,
                            bottom: 20,
                            left: 30,
                            child: Container(
                              width: 100,
                              height: 35,
                              padding: EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color.fromARGB(255, 211, 200, 183),
                              ),
                              child: Text(
                                'Giảm ${data[index].percentPromotion}\%',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: data[index].image1,
                          width: 200,
                          height: 150,
                        ),
                        Text(
                          '${data[index].name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${formatCurrency.format(data[index].price)} VNĐ',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black54),
                            ),
                            Text(
                              '${formatCurrency.format(data[index].price - ((data[index].price / 100) * data[index].percentPromotion))} \VNĐ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Tìm kiếm sản phẩm'),
    );
  }
}
