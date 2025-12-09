import 'package:booking/screen/jongqueue.dart';
import 'package:booking/screen/myqueue.dart';
import 'package:booking/screen/register.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: const Color.fromARGB(
          255,
          3,
          118,
          211,
        ), // <<< ใส่สี AppBar ที่นี่
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

      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/logo.png"),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(Icons.add),
                  label: Text("ลงชื่อ", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen();
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(Icons.login),
                  label: Text(
                    "จองคิวตัดผมวันพรุ่งนี้",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(Icons.queue),
                  label: Text(
                    "ดูคิวตัดผมวันนี้",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Myqueue();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
