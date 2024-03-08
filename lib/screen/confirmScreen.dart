import 'package:flutter/material.dart';
import 'package:test_ban_balo/button.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:test_ban_balo/screen/mycardpage.dart';
import 'package:test_ban_balo/screen/profile.dart';
import 'package:test_ban_balo/screen/successOrder.dart';
import 'package:test_ban_balo/screen/doidiachi.dart';
import 'package:http/http.dart' as http;
import 'checkout.dart';
import 'package:intl/intl.dart';

final formatCurrency = NumberFormat('00,000', 'en_US');

var fullNamepr1 = fullNamepr.toString();
var accountid1 = urlLink;

class ConfirmScreen extends StatelessWidget {
  Future<void> postinvoices(
      int accountId, String ShippingAddress, String ShippingPhone) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://localhost:7186/api/Invoices/post2?accountid=${accountId}&ShippingAddress=${ShippingAddress}&ShippingPhone=${ShippingPhone}"),
        headers: {
          'Content-Type': 'text/plain',
        },
        body: '$accountId\n$ShippingAddress\n$ShippingPhone',
      );

      if (response.statusCode == 201) {
        print('thanh toán thành công');
      } else {
        print(
            'Failed to update cart item quantity. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating cart item quantity: $error');
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
              'Xác nhận thanh toán',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                width: 450,
                height: 250,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên: ${fullNamepr.toString()}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Số điện thoại: ${phonetext.toString()}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Địa chỉ nhận hàng: ${addresscf.toString()}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65),
                      child: ElevatedButton(
                        style: buttonprimary,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => doidiachi(),
                            ),
                          );
                        },
                        child: Text(
                          'Đổi Địa Chỉ và số điện thoại',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 1 / 10,
              bottom: MediaQuery.of(context).size.height * 2 / 10,
            ),
            height: MediaQuery.of(context).size.height * 1 / 8,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1),
                top: BorderSide(width: 1),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tạm tính: ${formatCurrency.format(t1)} VNĐ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tiết kiệm: ${formatCurrency.format(pr1)} VNĐ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Tổng tiền: ${formatCurrency.format(t2)} VNĐ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              postinvoices(
                accountid1,
                addresscf.toString(),
                phonetext.toString(),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessOrder_Screen(),
                ),
              );
            },
            child: Text(
              'Xác Nhận Thanh toán',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Color.fromRGBO(255, 153, 0, 1),
              ),
              padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 3,
                  20,
                  MediaQuery.of(context).size.width / 3,
                  20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
