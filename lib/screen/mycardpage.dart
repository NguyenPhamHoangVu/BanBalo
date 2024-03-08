import 'dart:convert';
import 'dart:html';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_ban_balo/button.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/checkout.dart';
import 'package:test_ban_balo/screen/profile.dart';
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat('00,000', 'en_US');
var accountid1 = urlLink;
var quantity1 = 1;

class MyCartPage1 extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage1> {
  List<CartItem1> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    try {
      final response = await http.get(
          Uri.parse("https://localhost:7186/api/Carts/idac?id=${urlLink}"));
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

  Future<void> updateCartItemQuantity(
      int accountId, int productId, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse(
            "https://localhost:7186/api/Carts/put2?acc=${accountId}&pro=${productId}&quant=${quantity}"),
        headers: {
          'Content-Type': 'text/plain',
        },
        body: '$accountId\n$productId\n$quantity',
      );

      if (response.statusCode == 200) {
        print('Cart item quantity updated successfully');
      } else {
        print(
            'Failed to update cart item quantity. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating cart item quantity: $error');
    }
  }

  Future<void> removeCartItem(
    int accountId,
    int productId,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse(
            "https://localhost:7186/api/Carts/delete2?acc=${accountId}&pro=${productId}"),
        headers: {
          'Content-Type': 'text/plain', // Set the content type to plain text
        },
        body: '$accountId\n$productId',
      );

      if (response.statusCode == 204) {
        print('xoá sản phẩm giỏ hàng thành công');
      } else {
        print(
            'Failed to remove cart item. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error removing cart item: $error');
    }
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
      updateCartItemQuantity(cartItems[index].accountId,
          cartItems[index].productId, cartItems[index].quantity);
    });
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      setState(() {
        cartItems[index].quantity--;
        updateCartItemQuantity(cartItems[index].accountId,
            cartItems[index].productId, cartItems[index].quantity);
      });
    }
  }

  void removeProduct(int index) {
    setState(() {
      removeCartItem(cartItems[index].account.id, cartItems[index].productId);
      cartItems.removeAt(index);
    });
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Giỏ hàng',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ProductListScreen()),
                      ),
                    );
                  },
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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  subtitle: Container(
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 150,
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
                          imageUrl: '${cartItems[index].product.image1}',
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${cartItems[index].product.name}',
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
                              height: 20,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () => decreaseQuantity(index),
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(' ${cartItems[index].quantity}'),
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  onPressed: () => increaseQuantity(index),
                                  child: Icon(Icons.add),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                ElevatedButton(
                                  onPressed: () => removeProduct(index),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
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
          ElevatedButton(
              style: buttonprimary,
              onPressed: () {
                if (calculateTotalPrice2() == 0 && calculateTotalPrice() == 0) {
                  showAlert(
                    context,
                    'Thông báo ',
                    'Giỏ hàng chưa có sản phẩm vui lòng thêm sản phẩm vào giỏ hàng',
                  );
                } else if (calculateTotalPrice2() != 0 &&
                    calculateTotalPrice() != 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => checkout()),
                  );
                }
              },
              child: Text(
                'Đặt Hàng',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tạm tính: ${formatCurrency.format(toatl1)} VNĐ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Tiết kiệm: ${formatCurrency.format(promotion)} VNĐ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Thành tiền: ${formatCurrency.format(total2)} VNĐ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }

  void showAlert(BuildContext context, String title, String Content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(Content),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Đóng',
            ),
          )
        ],
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orange, width: 3),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
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
