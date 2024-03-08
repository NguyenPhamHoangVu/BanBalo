import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:test_ban_balo/models/api2model.dart';
import 'package:test_ban_balo/screen/appbar.dart';
import 'package:test_ban_balo/screen/mycardpage.dart';
import 'package:test_ban_balo/screen/prdetails.dart';
import 'package:test_ban_balo/screen/profile.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:test_ban_balo/screen/searchs.dart';

final formatCurrency = NumberFormat('00,000', 'en_US');

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product1> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    // you can replace your api link with this link
    final response =
        await http.get(Uri.parse('https://localhost:7186/api/Products'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        products = jsonData.map((data) => Product1.fromJson(data)).toList();
      });
    } else {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showSearch(context: context, delegate: SearchProducts());
          },
          icon: Icon(
            Icons.search_sharp,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Fast Store',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            letterSpacing: 0.53,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 250, 156, 34),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: IconButton(
                  icon: const Icon(Icons.home_outlined),
                  iconSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {},
                ),
              ),
              Container(
                child: IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  iconSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => MyCartPage1()),
                      ),
                    );
                  },
                ),
              ),
              Container(
                child: IconButton(
                  icon: const Icon(Icons.person),
                  iconSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const Profile()),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Số cột trong grid
        children: List.generate(
          products.length,
          (index) {
            return GestureDetector(
              onTap: () {
                // Chuyển đến chi tiết sản phẩm khi nhấp vào mỗi sản phẩm
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      product: products[index],
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
                              'Giảm ${products[index].percentPromotion}\%',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: products[index].image1,
                        width: 200,
                        height: 150,
                      ),
                      Text(
                        '${products[index].name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${formatCurrency.format(products[index].price)} VNĐ',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black54),
                          ),
                          Text(
                            '${formatCurrency.format(products[index].price - ((products[index].price / 100) * products[index].percentPromotion))} \VNĐ',
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
      ),
    );
  }
}
