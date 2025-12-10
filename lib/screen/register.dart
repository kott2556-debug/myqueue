import 'package:booking/model/profile.dart';
import 'package:booking/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile(name: '', phone: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
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
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ชื่อ", style: TextStyle(fontSize: 20)),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (String? name) {
                    profile.name = name ?? "";
                  },
                ),
                SizedBox(height: 15),

                Text("เบอร์โทร", style: TextStyle(fontSize: 20)),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  onSaved: (String? phone) {
                    profile.phone = phone ?? "";
                  },
                ),
                SizedBox(height: 50),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("บันทึก", style: TextStyle(fontSize: 20)),
                    onPressed: () async {
                      formkey.currentState!.save();

                      // ⭐ ตรวจว่าช่องว่างไหม
                      if (profile.name.isEmpty || profile.phone.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text("กรุณากรอกข้อมูลให้ครบถ้วน"),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      // ⭐ บันทึกลง SharedPreferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString("username", profile.name);
                      await prefs.setString("phone", profile.phone);

                      // ⭐ กลับหน้าโฮมและไม่ย้อนกลับได้
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
