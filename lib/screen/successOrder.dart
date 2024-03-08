import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:test_ban_balo/screen/api2screen.dart';
import 'package:test_ban_balo/screen/chitietdonhang.dart';
import 'package:test_ban_balo/screen/loadinvoiceDetails.dart';

class SuccessOrder_Screen extends StatelessWidget {
  const SuccessOrder_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 6 / 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                  'https://lottie.host/5780e7e3-4f18-4ea0-8f5a-68197cf8355f/Gmbb6azzhA.json',
                  repeat: false,
                  height: 300),
              Text(
                'Đặt hàng thành công!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bạn đã đặt hàng thành công. Để biết thêm thông tin chi tiết vui lòng xem trạng thái đơn hàng!',
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 196, 196, 196),
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 2 / 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Tiếp tục mua hàng',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromRGBO(255, 153, 0, 1)),
                      padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 3,
                            20,
                            MediaQuery.of(context).size.width / 3,
                            20),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => chitietdonhang(),
                        ),
                      );
                    },
                    child: Text(
                      'Trạng thái đơn hàng',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromRGBO(255, 153, 0, 1)),
                      padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width / 3,
                            20,
                            MediaQuery.of(context).size.width / 3,
                            20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VoiceDetails(),
                          ),
                        );
                      },
                      child: Text(
                        'Lịch sử mua hàng',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(255, 224, 213, 213),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
