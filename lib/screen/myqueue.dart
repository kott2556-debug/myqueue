import 'package:flutter/material.dart';

class Myqueue extends StatefulWidget {
  const Myqueue({super.key});

  @override
  State<Myqueue> createState() => _MyqueueState();
}

class _MyqueueState extends State<Myqueue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Colors.orange, // <<< ใส่สี AppBar ที่นี่
        centerTitle: true, // <<< จัดกลาง
        title: Text(
          'ร้านตัดผมชาย Barber.com',
          style: TextStyle(
            color: Colors.white, // <<< สีตัวหนังสือ
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}