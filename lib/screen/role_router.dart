import 'package:flutter/material.dart';

// ต้องนำเข้าหน้าจอที่คุณสร้างไว้ในโฟลเดอร์ screen/
// (โปรดตรวจสอบชื่อไฟล์ให้ตรงกับการตั้งชื่อของคุณ เช่น home.dart, admin_dashboard.dart)
import 'home.dart'; // หน้าจอหลักของลูกค้า
import 'admin_dashboard.dart'; // หน้าจอจัดการของร้านค้า

// Widget นี้จะทำหน้าที่เป็นตัวตัดสินเส้นทาง
class RoleRouterScreen extends StatelessWidget {
  // รับค่าบทบาท (Role) ที่ได้จากการ Login (เช่น 'admin', 'customer')
  final String userRole; 

  const RoleRouterScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    // 1. ตรวจสอบบทบาทว่าเป็น 'admin' หรือ 'staff'
    if (userRole == 'admin' || userRole == 'staff') {
      // ถ้าใช่: ให้แสดงหน้า Dashboard สำหรับร้านค้า
      return const AdminDashboardScreen();
    } 
    
    // 2. ถ้าไม่ใช่บทบาทร้านค้า ให้ถือว่าเป็นลูกค้า (หรือบทบาทอื่นๆ)
    else {
      // แสดงหน้า Home สำหรับลูกค้า
      return const HomeScreen(); 
    }
  }
}