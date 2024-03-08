import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/profile.dart';
import 'package:test_ban_balo/screen/register_page.dart';

import 'package:test_ban_balo/contains.dart';

var urlLink;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Future<int> createAlbum(String username, String password) async {
  final response = await http.post(
    Uri.parse('${uir}api/Accounts/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final id = data['id'];

    return id;
    //  return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    return 0;
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    // throw Exception('Đăng Nhập thất bại');
  }
}

class Album {
  final String username;
  final String password;
  const Album({
    required this.username,
    required this.password,
  });
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  int _futureAlbum = 0;
  bool passwordObscured = true;
  bool ischecker = false;
  late Box box1;

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox('loadingdata');
    getdata();
  }

  void getdata() async {
    if (box1.get('username') != null && box1.get('password') != null) {
      username.text = box1.get('username');
      password.text = box1.get('password');
      ischecker = true;
      setState(
        () {},
      );
    } else {
      ischecker = false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Image(
            height: 124,
            image: AssetImage('assets/images/logotrang cam.jpg'),
          ),
          SizedBox(
            height: 15,
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
            height: 10,
          ),
          Text(
            'Chào mừng bạn đến với Fast Store',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            'Vui lòng đăng nhập',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 50,
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
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
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
                    hintText: ' Mật Khẩu',
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
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
              ),
              Checkbox(
                value: this.ischecker,
                onChanged: (value) {
                  setState(
                    () {
                      this.ischecker = !ischecker;
                    },
                  );
                },
              ),
              Text(
                ' Nhớ mật khẩu',
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              login();
              _futureAlbum = await createAlbum(
                username.text,
                password.text,
              );

              if (_futureAlbum != 0) {
                urlLink = _futureAlbum;
                username.clear();
                password.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              } else if (_futureAlbum == 0) {
                showAlert(context, 'Đăng nhập thất bại',
                    'Sai tên tài khoản hoặc mật khẩu');
                username.clear();
                password.clear();
              }
            },
            child: Text(
              'Đăng Nhập',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3,
                    right: MediaQuery.of(context).size.width / 3,
                    top: 20,
                    bottom: 20),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Color.fromRGBO(255, 153, 0, 1),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nếu bạn chưa có tài khoản?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text(
                    'Đăng Kí Ngay',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ])),
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

  void login() {
    if (ischecker == true) {
      box1.put('username', username.value.text);
      box1.put('password', password.value.text);
      ischecker = true;
    } else if (ischecker == false) {
      box1.put('username', null);
      box1.put('password', null);
      ischecker = false;
    }
  }
}
