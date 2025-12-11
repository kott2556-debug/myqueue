// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
// ignore: deprecated_member_use
import 'dart:js' as js;

class ExitScreen extends StatelessWidget {
  const ExitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.exit_to_app, size: 80, color: Colors.red),
              SizedBox(height: 20),
              Text(
                "แอปถูกปิดแล้ว",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "กดปุ่มด้านล่างเพื่อปิดแท็บนี้",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 40),

              // ปุ่ม X กดแล้วพยายามปิดแท็บ
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                icon: Icon(Icons.close),
                label: Text(
                  "ปิดแท็บนี้",
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () {
                  // พยายามปิดแท็บ
                  js.context.callMethod("close");

                  // ถ้าปิดไม่ได้ → กลับไปหน้าว่างแทน
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
