import 'package:flutter/material.dart';
import 'package:test_ban_balo/screen/login_page.dart';
import 'package:test_ban_balo/screen/register_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 88, 30),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    height: 290,
                    width: 150,
                    image: AssetImage('assets/images/logodentrang.jpg'),
                  ),
                ],
              ),
              //chua logo
            ),
            Container(
              height: MediaQuery.of(context).size.height * 2 / 10,
              width: MediaQuery.of(context).size.width,
              //chua 2 nut dk/dn
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'Đăng Nhập',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 223, 88, 30),
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
                          (states) => Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      'Đăng Ký',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 223, 88, 30),
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith((states) =>
                          EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 3 + 9,
                              right: MediaQuery.of(context).size.width / 3 + 9,
                              top: 20,
                              bottom: 20)),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
