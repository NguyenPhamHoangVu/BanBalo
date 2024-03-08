import 'package:flutter/material.dart';

final ButtonStyle buttonprimary = ElevatedButton.styleFrom( 
  backgroundColor: Colors.orange,
  minimumSize: Size(327, 50),
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    )
  )
);