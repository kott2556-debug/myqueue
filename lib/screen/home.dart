// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:booking/screen/jongqueue.dart';
import 'package:booking/screen/myqueue.dart';
import 'package:booking/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: deprecated_member_use
import 'dart:html' as html;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  bool isRegistered = false;
  bool isBooked = false;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('name');
      isRegistered = prefs.getBool('registered') ?? false;
      isBooked = prefs.getBool('booked') ?? false;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("ยืนยันการออกจากระบบ"),
        content: const Text("คุณต้องการออกจากระบบหรือไม่?"),
        actions: [
          TextButton(
            child: const Text("ยกเลิก"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("OK"),
            onPressed: () async {
              Navigator.pop(context);
              await logout();

              html.window.open("about:blank", "_self");
              html.window.close();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 3, 118, 211),
        centerTitle: true,
        title: const Text(
          'ร้านตัดผมชาย Barber.com',
          style: TextStyle(
            color: Colors.white,
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
              const SizedBox(height: 16.0),

              // ⭐ ปุ่มลงชื่อ
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.add),
                  label: Text(
                    username == null ? "ลงชื่อ" : "ยินดีต้อนรับคุณ $username",
                    style: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if (username != null) return;

                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setBool("registered", true);
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // ⭐ ปุ่มจองคิว — ต้องลงชื่อก่อน
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isRegistered ? Colors.blue : Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.login),
                  label: const Text(
                    "จองคิวตัดผมวันพรุ่งนี้",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: isRegistered
                      ? () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool("booked", true);

                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(builder: (_) => Login()),
                          );
                        }
                      : null, // ❗ ปิดปุ่มถ้ายังไม่ลงชื่อ
                ),
              ),

              const SizedBox(height: 16.0),

              // ⭐ ปุ่มดูคิว — ต้องจองคิวแล้ว
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isBooked ? Colors.orange : Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.queue),
                  label: const Text(
                    "ดูคิวตัดผมวันนี้",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: isBooked
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Myqueue()),
                          );
                        }
                      : null, // ❗ ปิดปุ่มจนกว่าจะจองคิวแล้ว
                ),
              ),

              // ⭐ ปุ่มออกจากระบบ (โค้ดเดิม)
              const SizedBox(height: 70.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.logout),
                  label:
                      const Text("ออกจากระบบ", style: TextStyle(fontSize: 20)),
                  onPressed: confirmLogout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
