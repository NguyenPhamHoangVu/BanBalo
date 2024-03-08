import 'package:flutter/material.dart';
import 'package:test_ban_balo/button.dart';
import 'package:test_ban_balo/contains.dart';
import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/changepassword.dart';
import 'package:test_ban_balo/screen/chitietdonhang.dart';
import 'package:test_ban_balo/screen/loadinvoiceDetails.dart';
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:test_ban_balo/screen/mycardpage.dart';
import 'package:test_ban_balo/screen/settingprofile.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

var usernamepr;
var emailpr;
var phonepr;
var addresspr;
var fullNamepr;
var img;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Future<Account> fetchAlbum() async {
  final response = await http.get(Uri.parse('${uir}api/Accounts/${urlLink}'));
  // final response = await http.get(Uri.parse('${uir}api/Accounts/1'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Account.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('không kết nối đc api');
  }
}

class Account {
  // final int userId;
  final int id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String fullName;
  final String address;
  final String avatar;

  const Account({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.address,
    required this.fullName,
    required this.avatar,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String,
    );
  }
}

class _ProfileState extends State<Profile> {
  late Future<Account> futureAlbum;
  Widget popupmenu() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: buttonprimary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => settingprofile()),
              );
            },
            child: Text(
              'Cập nhật thông tin',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: buttonprimary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ),
              );
            },
            child: Text(
              'Đổi mật khẩu',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: buttonprimary,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
            },
            child: Text(
              'Đăng Xuất',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            Text(
              'Thông tin tài khoản',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              iconSize: 30,
              selectedIcon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => popupmenu(),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 250, 156, 34),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // nối tới trang chủ
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
              // nối tới trang giỏ hàng
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
                  icon: const Icon(Icons.account_circle),
                  iconSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(137, 255, 255, 255),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 18, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48),
                      child: Image.asset('assets/images/6195145.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: FutureBuilder<Account>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          usernamepr = snapshot.data!.username;
                          emailpr = snapshot.data!.email;
                          phonepr = snapshot.data!.phone;
                          addresspr = snapshot.data!.address;
                          fullNamepr = snapshot.data!.fullName;
                          img = snapshot.data!.avatar;
                          // String im2 = snapshot.data!.image2;
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  'Tên: ${snapshot.data!.fullName}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Email: ${snapshot.data!.email}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'SĐT: ${snapshot.data!.phone}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Địa chỉ: ${snapshot.data!.address}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  )
                ],
              ),
            ),
            // ignore: avoid_print

            const SizedBox(
              height: 20,
              width: 10,
            ),
            Container(
              child: Text(
                'Trạng thái đơn hàng',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        child: IconButton(
                          icon: Image.asset(
                            'assets/icons/chogiao.png',
                            width: 100,
                            height: 50,
                          ),
                          selectedIcon: Image.asset('assets/icons/chogiao.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => chitietdonhang()),
                            );
                          },
                        ),
                      ),
                      Text(
                        'Đơn hàng',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.history_outlined,
                            color: Colors.orange[600],
                            size: 60,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VoiceDetails()),
                            );
                          },
                        ),
                      ),
                      Text(
                        'Lịch sử',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Container(
            //     child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //         style: buttonprimary,
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => HistoryOrderScreen()),
            //           );
            //         },
            //         child: Text(
            //           'Lịch Sử Mua Hàng',
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         )),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     ElevatedButton(
            //         style: buttonprimary,
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => settingprofile()),
            //           );
            //         },
            //         child: Text(
            //           'Cập nhật tài khoản',
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         )),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     ElevatedButton(
            //         style: buttonprimary,
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => LoginPage()),
            //           );
            //         },
            //         child: Text(
            //           'Đăng Xuất',
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         )),
            //   ],
            // )),
          ],
        ),
      ),
    );
  }
}
