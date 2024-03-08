import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:test_ban_balo/screen/profile.dart';

final formatCurrency = NumberFormat('00,000', 'en_US');
var urhuy = urlLink;
var huy = 5;

class chitietdonhang extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<chitietdonhang>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Invoice> invoices = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // Fetch all invoices when the widget is first created
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    final response = await http
        .get(Uri.parse('https://localhost:7186/api/Invoices/idac?id=$urhuy'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        invoices = jsonResponse.map((data) => Invoice.fromJson(data)).toList();
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('load api thất bại');
    }
  }

  Future<void> puttinvoices(int idinvoice) async {
    try {
      final response = await http.put(
        Uri.parse(
            "https://localhost:7186/api/Invoices/putid?idinvoice=$idinvoice&status=5"),
        headers: {
          'Content-Type': 'text/plain',
        },
        body: '$idinvoice\n$huy',
      );

      if (response.statusCode == 200) {
        print('Huy thanh cong don hang');
      } else {
        print(
            'Failed to update cart item quantity. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating cart item quantity: $error');
    }
  }

  List<Invoice> getInvoicesByStatus(int status) {
    return invoices.where((invoice) => invoice.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Text(
          'Trạng thái đơn hàng',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Chờ xác nhận',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Xác nhận',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Đang giao',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Đã hoàn thành',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Đơn hàng đã huỷ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildInvoiceList(1), // Chờ xác nhận
          buildInvoiceList(2), // Xác nhận
          buildInvoiceList(3), // Đang giao
          buildInvoiceList(4), // Hoàn tất
          buildInvoiceList(5), // Huỷ
        ],
      ),
    );
  }

  Widget buildInvoiceList(int status) {
    List<Invoice> filteredInvoices = getInvoicesByStatus(status);
    return ListView.builder(
      itemCount: filteredInvoices.length,
      itemBuilder: (context, index) {
        return ListTile(
          //title:
          subtitle: Container(
            margin: EdgeInsets.all(5),
            width: 160,
            height: 130,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Mã đơn hàng: '),
                    Text(
                      '${filteredInvoices[index].code}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Tên người nhận: '),
                    Text(
                      '${filteredInvoices[index].account.fullName}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Tổng tiền: '),
                    Text(
                      '${formatCurrency.format(filteredInvoices[index].total)} VNĐ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Số điện thoại: '),
                    Text(
                      '${filteredInvoices[index].shippingPhone}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Địa chỉ nhận hàng: '),
                    Text(
                      '${filteredInvoices[index].shippingAddress}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            
          ),
          //  Text('Quantity: ${filteredInvoices[index].shippingAddress}'),
          // Display other invoice information as needed
          trailing: status == 1
              ? Container(
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Huỷ đơn hàng",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              "Bạn có muốn huỷ đơn hàng này?",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.orange, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text("Xác nhận"),
                                onPressed: () {
                                  puttinvoices(
                                      (filteredInvoices[index].id).toInt());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => super.widget),
                                  );
                                  // Return true
                                },
                              ),
                              ElevatedButton(
                                child: Text("Đóng"),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                            ],
                          );
                        },
                      );
                      // Perform cancel operation when the button is pressed
                      // You can implement the logic for canceling an invoice here
                      cancelInvoice(filteredInvoices[index].id);
                    },
                    child: Text(
                      'Huỷ đơn hàng',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
              )
              : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InvoiceDetailsScreen(invoiceId: filteredInvoices[index].id),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> cancelInvoice(int invoiceId) async {
    print('Canceling invoice with ID: $invoiceId');
  }
}

class Invoice {
  final int id;
  final Accountprdeta account;
  final String code;
  final String shippingAddress;
  final String shippingPhone;

  final int total;
  final int status;

  Invoice({
    required this.id,
    required this.account,
    required this.code,
    required this.shippingAddress,
    required this.shippingPhone,
    required this.total,
    required this.status,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      account: Accountprdeta.fromJson(json['account']),
      code: json['code'],
      shippingAddress: json['shippingAddress'],
      shippingPhone: json['shippingPhone'],
      total: json['total'],
      status: json['status'],
    );
  }
}

class InvoiceDetailsScreen extends StatelessWidget {
  final int invoiceId;

  InvoiceDetailsScreen({required this.invoiceId});

  @override
  Widget build(BuildContext context) {
    // Fetch invoice details based on the provided invoiceId
    // Display the details in a similar manner as the invoices list
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng'),
      ),
      body: FutureBuilder(
        future: fetchInvoiceDetails(invoiceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Display the details using a widget (e.g., ListView.builder)
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                // Display invoice details as needed
                return ListTile(
                  // title: Text('Product: ${snapshot.data?[index].unitPrice}'),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        // this is to fetch the image
                        imageUrl: '${snapshot.data?[index].product.image1}',
                        height: 100,
                        width: 80,
                        //   fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' ${snapshot.data?[index].product.name}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Số lượng: ${snapshot.data?[index].quantity}'),
                          Text(
                              'Giá bán: ${formatCurrency.format(snapshot.data?[index].product.price)} VNĐ'),
                          Text(
                              'Giảm giá: ${snapshot.data?[index].product.percentPromotion}\%'),
                          Text(
                            'Thành tiền: ${formatCurrency.format(snapshot.data?[index].unitPrice)} VNĐ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<InvoiceDetail>> fetchInvoiceDetails(int invoiceId) async {
    final response = await http.get(Uri.parse(
        'https://localhost:7186/api/InvoiceDetails/invoicedtails?id=$invoiceId'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => InvoiceDetail.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load invoice details');
    }
  }
}

class InvoiceDetail {
  final productinvoce product;
  final int unitPrice;
  final int quantity;
  // Add other properties as needed

  InvoiceDetail({
    required this.product,
    required this.unitPrice,
    required this.quantity,
    // Add other properties as needed
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) {
    return InvoiceDetail(
      unitPrice: json['unitPrice'],
      quantity: json['quantity'],
      product: productinvoce.fromJson(json['product']),
      // Parse other properties as needed
    );
  }
}

class productinvoce {
  String name;
  String image1;
  int price;
  int percentPromotion;

  productinvoce({
    required this.name,
    required this.image1,
    required this.price,
    required this.percentPromotion,
  });

  factory productinvoce.fromJson(Map<String, dynamic> json) {
    return productinvoce(
      name: json['name'],
      image1: json['image1'],
      price: json['price'].toInt(),
      percentPromotion: json['percentPromotion'].toInt(),
    );
  }
}

class Accountprdeta {
  String fullName;

  Accountprdeta({
    required this.fullName,
  });

  factory Accountprdeta.fromJson(Map<String, dynamic> json) {
    return Accountprdeta(
      fullName: json['fullName'],
    );
  }
}
