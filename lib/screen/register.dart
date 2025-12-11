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
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ชื่อ", style: TextStyle(fontSize: 20)),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (name) => profile.name = name ?? "",
                ),

                const SizedBox(height: 15),
                const Text("เบอร์โทร", style: TextStyle(fontSize: 20)),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  onSaved: (phone) => profile.phone = phone ?? "",
                ),

                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("บันทึก", style: TextStyle(fontSize: 20)),
                    onPressed: () async {
                      formkey.currentState?.save();

                      // ❗ ตรวจช่องว่าง
                      if (profile.name.isEmpty || profile.phone.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text("กรุณากรอกข้อมูลให้ครบถ้วน"),
                            actions: [
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      // ⭐ บันทึกข้อมูลลง SharedPreferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString("name", profile.name);
                      await prefs.setString("phone", profile.phone);

                      // ignore: avoid_print
                      print(">>> SAVE USER : name=${profile.name} , phone=${profile.phone}");

                      // ⭐ ป้องกัน use_build_context_synchronously
                      if (!context.mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
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
