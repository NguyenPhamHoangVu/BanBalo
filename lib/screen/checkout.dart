import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_ban_balo/button.dart';
import 'package:test_ban_balo/contains.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/confirmScreen.dart';

import 'package:test_ban_balo/screen/login_page.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat('00,000', 'en_US');

var accountid1 = urlLink;
var quantity1 = 1;
var t1;
var t2;
var pr1;

class checkout extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<checkout> {
  List<CartItem1> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    try {
      final response =
          await http.get(Uri.parse("${uir}api/Carts/idac?id=${urlLink}"));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          cartItems = data.map((item) => CartItem1.fromJson(item)).toList();
        });
      } else {
        print('Failed to load cart data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Lỗi kết nối server: $error');
    }
  }

//tính tổng tiền ban đầu
  double calculateTotalPrice() {
    double totalPrice = 0.0;

    for (var item in cartItems) {
      totalPrice += item.product.price * item.quantity;
    }

    return totalPrice;
  }
  //tính  tổng tiền sau khi nhân %giảm giá

  double calculateTotalPrice2() {
    double totalPrice = 0.0;

    for (var item in cartItems) {
      totalPrice += (item.product.price -
              ((item.product.price / 100) * item.product.percentPromotion)) *
          item.quantity;
    }

    return totalPrice;
  }

  double hieu() {
    double a = 0.0, b = 0.0;
    for (var item in cartItems) {
      a += item.product.price * item.quantity;
    }

    for (var item in cartItems) {
      b += (item.product.price -
              ((item.product.price / 100) * item.product.percentPromotion)) *
          item.quantity;
    }

    return a - b;
  }

  @override
  Widget build(BuildContext context) {
    var toatl1 = calculateTotalPrice();
    var total2 = calculateTotalPrice2();
    var promotion = toatl1 - total2;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Thanh toán',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ProductListScreen()),
                  ),
                );
              },
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  subtitle: Container(
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          // this is to fetch the image
                          imageUrl: '${cartItems[index].product.image1}',
                          height: 100,
                          width: 100,
                          //   fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ' ${cartItems[index].product.name}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Giá: ${formatCurrency.format(cartItems[index].product.price)} VNĐ',
                            ),
                            Text(
                              'Giảm: ${cartItems[index].product.percentPromotion} \%',
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Số Lượng: ${cartItems[index].quantity}'),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tạm tính: ${formatCurrency.format(toatl1)} VNĐ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                "Tiết kiệm: ${formatCurrency.format(promotion)} VNĐ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                "Thành tiền: ${formatCurrency.format(total2)} VNĐ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: buttonprimary,
            onPressed: () {
              t1 = toatl1;
              t2 = total2;
              pr1 = promotion;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfirmScreen()),
              );
            },
            child: Text(
              'Thanh Toán',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem1 {
  int quantity;
  int productId;
  ProductCard product;
  int accountId;
  AccountCard account;

  CartItem1({
    required this.quantity,
    required this.productId,
    required this.product,
    required this.accountId,
    required this.account,
  });

  factory CartItem1.fromJson(Map<String, dynamic> json) {
    return CartItem1(
      quantity: json['quantity'],
      productId: json['productId'],
      product: ProductCard.fromJson(json['product']),
      accountId: json['accountId'],
      account: AccountCard.fromJson(json['account']),
    );
  }
}

class ProductCard {
  String name;
  String image1;
  int percentPromotion;
  int price;

  ProductCard({
    required this.name,
    required this.image1,
    required this.percentPromotion,
    required this.price,
  });

  factory ProductCard.fromJson(Map<String, dynamic> json) {
    return ProductCard(
      name: json['name'],
      image1: json['image1'],
      percentPromotion: json['percentPromotion'].toInt(),
      price: json['price'].toInt(),
    );
  }
}

class AccountCard {
  int id;
  String username;
  String address;

  AccountCard({
    required this.id,
    required this.username,
    required this.address,
  });

  factory AccountCard.fromJson(Map<String, dynamic> json) {
    return AccountCard(
      id: json['id'],
      username: json['username'],
      address: json['address'],
    );
  }
}
