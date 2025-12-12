import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Colors.blue, // <<< ใส่สี AppBar ที่นี่
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

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // เวลาทั้งหมด 10 ช่อง
  final List<String> timeSlots = [
    "8.00 - 8.45",
    "8.45 - 9.30",
    "9.30 - 10.15",
    "10.15 - 11.00",
    "11.00 - 11.45",
    "13.00 - 13.45",
    "13.45 - 14.30",
    "14.30 - 15.15",
    "15.15 - 16.00",
    "16.00 - 16.45",
  ];

  int? selectedIndex;        // ผู้ใช้เลือก
  List<int> reservedByOthers = []; // ที่คนอื่นจองไว้

  @override
  void initState() {
    super.initState();
    loadReservedTimes();
  }

  Future<void> loadReservedTimes() async {
    // **ตัวอย่าง** จำลองว่าคนอื่นจองคิวที่ 3 และ 7 ไว้
    // คุณสามารถเชื่อม Firebase แทนได้
    reservedByOthers = [2, 6];

    final prefs = await SharedPreferences.getInstance();
    selectedIndex = prefs.getInt("my_booking");

    if (mounted) setState(() {});
  }

  Future<void> confirmBooking() async {
    if (selectedIndex == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("my_booking", selectedIndex!);

    if (!mounted) return;

    // ไปหน้า Home แล้วกลับมาไม่ได้
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffef1f4),
      appBar: AppBar(
        title: const Text("ร้านตัดผมชาย Barber.com"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 10),

            const Text(
              "กดเลือกช่วงเวลาตัดผมที่ท่านต้องการ\n"
              "เมื่อเลือกได้แล้วให้กดยืนยัน\n"
              "*หมายเหตุ* เมื่อกดยืนยันแล้ว ไม่สามารถเปลี่ยนแปลงได้",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(6),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2.2,
                ),
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final isReserved = reservedByOthers.contains(index);
                  final isSelected = selectedIndex == index;

                  Color bgColor;
                  bool enabled = true;

                  if (isReserved) {
                    bgColor = Colors.grey.shade400;
                    enabled = false;
                  } else if (isSelected) {
                    bgColor = Colors.grey.shade500;
                  } else {
                    bgColor = Colors.white;
                  }

                  return ElevatedButton(
                    onPressed: enabled
                        ? () {
                            setState(() {
                              selectedIndex = index;
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("คิวที่ ${index + 1} เวลา",
                            style: const TextStyle(fontSize: 16)),
                        Text(timeSlots[index],
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: selectedIndex == null ? null : confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
                child: const Text(
                  "ยืนยัน",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "จองวันนี้ ตัดวันพรุ่งนี้",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
