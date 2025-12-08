import 'package:booking/model/profile.dart';
import 'package:booking/screen/home.dart';
import 'package:flutter/material.dart';

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
        leading: null,
        backgroundColor: Colors.green, // <<< ใส่สี AppBar ที่นี่
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
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Padding(
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .green, // เปลี่ยนสีปุ่มตรงนี้ (เช่น Colors.blue, Colors.orange)
                        foregroundColor:
                            Colors.white, // เปลี่ยนสีตัวอักษรและไอคอนเป็นสีขาว
                      ),
                      child: Text("บันทึก", style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        if (formkey.currentState != null) {
                          formkey.currentState!.save();
                        }
                        // ignore: avoid_print
                        print(
                          "name = ${profile.name} phone = ${profile.phone}",
                        );
                        formkey.currentState?.reset();
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
      ),
    );
  }
}
