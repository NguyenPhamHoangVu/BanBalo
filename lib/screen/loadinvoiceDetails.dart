import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/login_page.dart';

final formatCurrency = NumberFormat('00,000', 'en_US');

class VoiceDetails extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<VoiceDetails> {
  // ignore: non_constant_identifier_names
  List<invoiceDetail> Invoicesitem = [];

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  double dongia(int a, int b, int c) {
    return (a * (c - ((c / 100) * b)));
  }

  double dongiagiam(int a, int b) {
    return (a - ((a / 100) * b));
  }

  Future<void> fetchCartData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://localhost:7186/api/InvoiceDetails/idac?id=$urlLink"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        setState(() {
          Invoicesitem =
              data.map((item) => invoiceDetail.fromJson(item)).toList();
        });
      } else {
        print('Failed to load cart data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading cart data: $error');
    }
  }

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
              'Lịch sử mua hàng',
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
              itemCount: Invoicesitem.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    ' ${Invoicesitem[index].product.name}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.all(5),
                    width: 150,
                    height: 170,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          // this is to fetch the image
                          imageUrl: '${Invoicesitem[index].product.image1}',
                          height: 100,
                          width: 80,
                          //   fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Giá: ${formatCurrency.format(Invoicesitem[index].product.price)} VNĐ'),
                            Text(
                                'Giảm: ${Invoicesitem[index].product.percentPromotion}\%'),
                            Text(
                                'Giá sau khi giảm: ${formatCurrency.format(dongiagiam(Invoicesitem[index].product.price, Invoicesitem[index].product.percentPromotion))} VNĐ'),
                            Text('Số lượng: ${Invoicesitem[index].quantity}'),
                            Text(
                                'Địa chỉ nhận: ${Invoicesitem[index].invoice.shippingAddress}'),
                            Text(
                                'Số điện thoại người nhận: ${Invoicesitem[index].invoice.shippingPhone}'),
                            Row(
                              children: [
                                Text("Trạng thái đơn hàng:"),
                                Text(
                                  ' ${(() {
                                    if (Invoicesitem[index].invoice.status ==
                                        1) {
                                      return 'Chờ xác nhận';
                                    } else if (Invoicesitem[index]
                                            .invoice
                                            .status ==
                                        2) {
                                      return 'Đã Xác nhận';
                                    }else if (Invoicesitem[index]
                                            .invoice
                                            .status ==
                                        3){
                                        return 'Đang giao';
                                        }
                                        else if (Invoicesitem[index]
                                            .invoice
                                            .status ==
                                        4){
                                          return 'Hoàn tất';
                                        }
                                     else {
                                      return 'Đã Hủy';
                                    }
                                  })()}',
                                  style: TextStyle(
                                    color: (() {
                                      if (Invoicesitem[index].invoice.status ==
                                          1) {
                                        return Colors.orange; // Màu cho trạng thái "Chờ xác nhận"
                                      } else if (Invoicesitem[index]
                                              .invoice
                                              .status ==
                                          2) {
                                        return Colors.yellowAccent;
                                        // Màu cho trạng thái "Đã giao"
                                      }else if (Invoicesitem[index]
                                              .invoice
                                              .status ==
                                          3) {
                                        return Colors.yellowAccent[700];
                                        // Màu cho trạng thái "Đã giao"
                                      }else if (Invoicesitem[index]
                                              .invoice
                                              .status ==
                                          4) {
                                        return Colors.green;
                                        // Màu cho trạng thái "Đã giao"
                                      }
                                       else {
                                        return Colors.red; // Màu cho trạng thái "Hoàn tất"
                                      }
                                    })(),
                                    // Các thuộc tính style khác
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Thành tiền: ${formatCurrency.format(dongia(Invoicesitem[index].quantity, Invoicesitem[index].product.percentPromotion, Invoicesitem[index].product.price))} VNĐ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class invoiceDetail {
  int quantity;
  int unitPrice;
  productdt product;
  Invoicedt invoice;

  invoiceDetail({
    required this.quantity,
    required this.unitPrice,
    required this.product,
    required this.invoice,
  });

  factory invoiceDetail.fromJson(Map<String, dynamic> json) {
    return invoiceDetail(
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      product: productdt.fromJson(json['product']),
      invoice: Invoicedt.fromJson(json['invoice']),
    );
  }
}

class productdt {
  String name;
  String image1;
  int price;
  int percentPromotion;

  productdt({
    required this.name,
    required this.image1,
    required this.price,
    required this.percentPromotion,
  });

  factory productdt.fromJson(Map<String, dynamic> json) {
    return productdt(
      name: json['name'],
      image1: json['image1'],
      price: json['price'].toInt(),
      percentPromotion: json['percentPromotion'].toInt(),
    );
  }
}

class Invoicedt {
  String shippingPhone;
  String shippingAddress;
  int status;

  Invoicedt({
    required this.shippingPhone,
    required this.shippingAddress,
    required this.status,
  });

  factory Invoicedt.fromJson(Map<String, dynamic> json) {
    return Invoicedt(
      shippingPhone: json['shippingPhone'],
      shippingAddress: json['shippingAddress'],
      status: json['status'],
    );
  }
}
