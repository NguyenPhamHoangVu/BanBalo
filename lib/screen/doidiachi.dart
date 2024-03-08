import 'package:flutter/material.dart';
import 'package:test_ban_balo/button.dart';
import 'package:test_ban_balo/screen/confirmScreen.dart';
import 'package:test_ban_balo/screen/profile.dart';

String addresscf = addresspr.toString();
String phonetext = phonepr.toString();

class doidiachi extends StatefulWidget {
  const doidiachi({super.key});

  @override
  State<doidiachi> createState() => _DoiDiaChiPgaeState();
}

class _DoiDiaChiPgaeState extends State<doidiachi> {
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    address.text = addresscf.toString();
    phone.text = phonepr.toString();
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
              'Đổi địa chỉ và số điện thoại',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                
              },
              icon: Icon(
                Icons.home_outlined,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    child: TextField(
                      controller: address,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: ' Địa Chỉ ',
                        prefixIcon: Icon(Icons.location_city_outlined),
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
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: ' Số Điện thoại',
                        prefixIcon: Icon(Icons.phone_android_rounded),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  style: buttonprimary,
                  onPressed: () {
                    if (address.text == addresscf.toString() &&
                        phone.text == phonetext.toString()) {
                      addresscf = addresspr.toString();
                      phonetext = phonepr.toString();
                    } else {
                      addresscf = address.text;
                      phonetext = phone.text;
                    }
                    phone.clear();
                    address.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfirmScreen()),
                    );
                  },
                  child: Text(
                    'Cập Nhật',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
