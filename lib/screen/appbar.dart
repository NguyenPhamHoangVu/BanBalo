import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    backgroundColor: Colors.orange,
    centerTitle: true,
    title: const Text(
      'Fast Store',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        letterSpacing: 0.53,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: InkWell(
      onTap: () {},
      child: const Icon(
        Icons.search,
        color: Colors.white,
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    actions: [
      InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.message_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    ],
  );
}
