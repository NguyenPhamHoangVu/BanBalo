import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_ban_balo/button.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:test_ban_balo/screen/profile.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordcofirmController =
      TextEditingController();
  bool passwordObscured = true;
  bool passwordObscured1 = true;
  bool passwordObscured2 = true;
  void changePassword(
      String oldPasswordController, String newPasswordController) async {
    final response = await http.put(
      Uri.parse(
          "https://localhost:7186/api/Accounts/ChangePassword?id=${urlLink}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'oldPassword': oldPasswordController,
        'newPassword': newPasswordController,
      }),
    );

    if (response.statusCode == 200) {
      showAlert(
          context, 'Thông báo cập nhật thành công', 'Đổi mật khẩu thành công');
      // Có thể thêm xử lý khác sau khi đổi mật khẩu thành công
    } else {
      showAlert(context, 'Thông báo cập nhật thất bại',
          'Đổi mật khẩu thất bại,mật khẩu cũ không đúng');
      // Có thể thêm xử lý khác khi đổi mật khẩu thất bại
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
              'Đổi mật khẩu',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: oldPasswordController,
                  obscureText: passwordObscured,
                  decoration: InputDecoration(
                    labelText: 'Mật Khẩu cũ',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordObscured = !passwordObscured;
                        });
                      },
                      child: new Icon(
                        passwordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: newPasswordController,
                  obscureText: passwordObscured1,
                  decoration: InputDecoration(
                    labelText: 'Mât khẩu mới',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordObscured1 = !passwordObscured1;
                        });
                      },
                      child: new Icon(
                        passwordObscured1
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: newPasswordcofirmController,
                  obscureText: passwordObscured2,
                  decoration: InputDecoration(
                    labelText: 'Nhập lại mật khẩu mới',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordObscured2 = !passwordObscured2;
                        });
                      },
                      child: new Icon(
                        passwordObscured2
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: buttonprimary,
              onPressed: () {
                if (newPasswordController.text !=
                    newPasswordcofirmController.text) {
                  showAlert(
                    context,
                    'Cập nhật thất bại',
                    'Mật khẩu nhập lại không trùng khớp',
                  );
                } else {
                  changePassword(
                    oldPasswordController.text,
                    newPasswordController.text,
                  );
                  newPasswordController.clear();
                  newPasswordcofirmController.clear();
                  oldPasswordController.clear();
                }
              },
              child: Text(
                'Đổi mật khẩu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
