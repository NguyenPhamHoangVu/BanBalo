import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mycardpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_ban_balo/models/api2model.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/mycardpage.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

final formatCurrency = NumberFormat('000,000', 'en_US');

var idr = 1;
var idac = urlLink;
var quantity = 1;

class ProductDetailScreen extends StatelessWidget {
  final Product1 product;

  Future<void> postData(int value1) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://localhost:7186/api/Carts/post2?acc=${idac}&pro=${value1}&quant=1'),
        headers: {
          'Content-Type': 'text/plain', // Set the content type to plain text
        },
        body: '$idac\n$value1\n$quantity',
        // Concatenate the values with newline
      );

      if (response.statusCode == 201) {

        print('thêm vô giỏ hàng thành công');
        print('Response: ${response.body}');
      } else {
        print(
            'Failed to make POST request. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error making POST request: $error');
    }
  }

  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
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
              'Chi tiết sản phẩm',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.home_outlined,
              color: Colors.orange,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CarouselSlider(
              items: [
                Image.network(product.image1),
                Image.network(product.image2),
                Image.network(product.image3),
                Image.network(product.image4),
              ],
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${formatCurrency.format(product.price)} VNĐ',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${formatCurrency.format(product.price - ((product.price / 100) * product.percentPromotion))} \VNĐ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
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
                        'Giảm ${product.percentPromotion}\%',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('Số lượng sản phẩm: '),
                    Text(
                      product.stock.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Chi tiết sản phẩm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    idr = product.id;
                    postData(idr);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyCartPage1()),
                    );
                  },
                  child: Text(
                    'Thêm vào giỏ hàng',
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 4 / 10,
                        10,
                        MediaQuery.of(context).size.width * 4 / 10,
                        10,
                      ),
                    ),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.orange),
                  ),
                ),
              ],
            ),

            // Hiển thị các thông tin chi tiết khác của sản phẩm
          ],
        ),
      ),
    );
  }
}
