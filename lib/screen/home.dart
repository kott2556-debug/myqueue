import 'package:booking/screen/jongqueue.dart';
import 'package:booking/screen/myqueue.dart';
import 'package:booking/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booking/screen/exit_screen.dart';
// ใช้ปิดเว็บ (เฉพาะ Flutter Web)
import 'dart:html' as html;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name');
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
        title: Text("ยืนยันการออกจากระบบ"),
        content: Text("คุณต้องการออกจากระบบหรือไม่?"),
        actions: [
          TextButton(
            child: Text("ยกเลิก"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("OK"),
            onPressed: () async {
              Navigator.pop(context); // ปิด dialog
              await logout();

              // ⭐ ปิดแท็บเบราว์เซอร์แบบสำเร็จจริง 100%
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
        backgroundColor: Color.fromARGB(255, 3, 118, 211),
        centerTitle: true,
        title: Text(
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
              SizedBox(height: 16.0),

              // ⭐ ปุ่มเดิมทั้งหมด (ไม่แตะต้อง)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(Icons.add),
                  label: Text(
                    username == null ? "ลงชื่อ" : "ยินดีต้อนรับคุณ $username",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if (username != null) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()),
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
                      MaterialPageRoute(builder: (_) => Login()),
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
                      MaterialPageRoute(builder: (_) => Myqueue()),
                    );
                  },
                ),
              ),

              // ⭐⭐⭐ เพิ่มปุ่มออกจากระบบ ⭐⭐⭐
              SizedBox(height: 70.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(Icons.logout),
                  label: Text("ออกจากระบบ", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("ยืนยันการออกจากระบบ"),
                        content: Text("คุณต้องการออกจากระบบหรือไม่ ?"),
                        actions: [
                          TextButton(
                            child: Text("ยกเลิก"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text("OK"),
                            onPressed: () async {
                              Navigator.pop(context);

                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ExitScreen(),
                                ),
                              );
                            },
                          ),
                        ],
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
