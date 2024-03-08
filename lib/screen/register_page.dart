import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:test_ban_balo/contains.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

Future<int> createAlbum(String username, String password, String email,
    String phone, String address, String fullName) async {
  final response = await http.post(
    Uri.parse('${uir}api/Accounts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
        'address': address,
        'fullName': fullName,
        'avatar': "",
      },
    ),
  );

  if (response.statusCode == 201) {
    return 1;
  } else {
    return 0;
  }
}

class Album {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String fullName;

  const Album({
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.address,
    required this.fullName,
  });
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      fullName: json['fullname'] as String,
    );
  }
}

class _RegisterState extends State<Register> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordconfirm = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController fullName = TextEditingController();

  int _futureAlbum = 0;
  bool passwordObscured = true;
  bool passwordObscured1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                height: 124,
                image: AssetImage('assets/images/logotrang cam.jpg'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'FAST STORE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color.fromARGB(255, 218, 67, 7),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Chào mừng đến với Fast Store vui lòng đăng Ký!',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: fullName,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Họ và tên',
                        prefixIcon: Icon(Icons.account_box),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Tài Khoản',
                          prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Số điện thoại',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: address,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.location_on),
                        hintText: 'Địa chỉ',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: password,
                      obscureText: passwordObscured,
                      decoration: InputDecoration(
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
                        hintText: ' Mật khẩu',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: passwordconfirm,
                      obscureText: passwordObscured1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                        hintText: ' Nhập lại mật khẩu',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              ElevatedButton(
                onPressed: () async {
                  _futureAlbum = await createAlbum(
                    username.text,
                    password.text,
                    email.text,
                    phone.text,
                    address.text,
                    fullName.text,
                  );
                  if (password.text != passwordconfirm.text) {
                    showAlert(
                      context,
                      'Thông báo',
                      'Mật khẩu không trùng khớp',
                    );
                  } else {
                    if (_futureAlbum == 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Đăng ký thành công",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              "Bạn có muốn chuyển sang trang đăng nhập?",
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                              ),
                              ElevatedButton(
                                child: Text("Đóng"),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                  fullName.clear();
                                  username.clear();
                                  email.clear();
                                  phone.clear();
                                  address.clear();
                                  password.clear();
                                  passwordconfirm.clear();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      // urlLink = _futureAlbum;
                    } else if (_futureAlbum == 0) {
                      showAlert(
                        context,
                        'Thông báo',
                        'Vui lòng nhập đầy đủ thông tin!',
                      );
                      fullName.clear();
                      username.clear();
                      email.clear();
                      phone.clear();
                      address.clear();
                      password.clear();
                      passwordconfirm.clear();
                    }
                  }
                },
                child: Text(
                  'Đăng Ký',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) =>
                      EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 3,
                          right: MediaQuery.of(context).size.width / 3,
                          top: 20,
                          bottom: 20)),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Color.fromRGBO(255, 153, 0, 1)),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nếu bạn đã có tài khoản?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Đăng nhập',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
