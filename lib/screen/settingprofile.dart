import 'package:date_format_field/date_format_field.dart';
import 'package:flutter/material.dart';
import 'package:test_ban_balo/button.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:test_ban_balo/screen/profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class settingprofile extends StatefulWidget {
  const settingprofile({super.key});

  @override
  State<settingprofile> createState() => _settingprofileState();
}

var t = urlLink;
// dynamic us = emailpr;

class _settingprofileState extends State<settingprofile> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();

  void updateAccount() async {
    final response = await http.put(
      Uri.parse(
          'https://localhost:7186/api/Accounts/putid?id=${t}'), // Chắc chắn rằng bạn có thể truyền đúng đường dẫn API và userId
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id': t,
        'username': 'hoangvucv2',
        'password': "Aa@123456",
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'fullname': fullnameController.text,
        'avatar': "string",
      }),
    );

    if (response.statusCode == 200) {
      showAlert(context, 'Thông báo cập nhật', 'cập nhật tài khoản thành công');
      // Có thể thêm xử lý khác sau khi cập nhật tài khoản thành công
    } else {
      showAlert(context, 'Thông báo cập nhật',
          'Cập nhật tài khoản thất bại, vui lòng nhập đầy đủ thông tin');

      print('Nội dung phản hồi: ${response.body}');
      // Có thể thêm xử lý khác khi cập nhật tài khoản thất bại
    }
  }

  @override
  Widget build(BuildContext context) {
    // String hintText = us.toString();
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
                Navigator.pushReplacement(
                context,
                 MaterialPageRoute(builder: (context) => Profile()),
);
              },
            ),
            Text(
              'Cập nhật thông tin tài khoản',
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
      body: Container(
        color: const Color.fromARGB(137, 255, 255, 255),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 18, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 48, // Image radius
                    backgroundImage: AssetImage('assets/images/6195145.jpg'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Expanded(
                child: ListView(padding: EdgeInsets.all(15), children: [
                  TextField(
                    controller: fullnameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Họ và tên'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: addressController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.add_location),
                      border: OutlineInputBorder(),
                      labelText: 'Địa chỉ',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: buttonprimary,
                    onPressed: () {
                      updateAccount();
                      emailController.clear();
                      phoneController.clear();
                      addressController.clear();
                      fullnameController.clear();
                    },
                    child: const Text(
                      'Cập nhật thông tin',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
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
              child: Text('Đóng'))
        ],
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.orange, width: 3),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
