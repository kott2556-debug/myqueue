import 'package:flutter/material.dart';

// สมมติฐาน: นี่คือข้อมูลคิวของวันนี้ที่จะดึงมาจาก Firestore
class QueueItem {
  final String id;
  final String customerName;
  final String time;
  String status; // สถานะที่สามารถเปลี่ยนแปลงได้: 'รอ', 'กำลังตัด', 'เสร็จสิ้น'
  final String service;
  final String barberName;

  QueueItem({
    required this.id,
    required this.customerName,
    required this.time,
    required this.status,
    required this.service,
    required this.barberName,
  });
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // ข้อมูลจำลอง (Mock Data) สำหรับเริ่มต้น
  List<QueueItem> todayQueue = [
    QueueItem(
      id: 'Q001',
      customerName: 'คุณสมศักดิ์',
      time: '10:00',
      status: 'รอ',
      service: 'ตัดผม',
      barberName: 'ช่างบอย',
    ),
    QueueItem(
      id: 'Q002',
      customerName: 'คุณมานี',
      time: '11:30',
      status: 'กำลังตัด',
      service: 'ตัด+ย้อม',
      barberName: 'ช่างบอย',
    ),
    QueueItem(
      id: 'Q003',
      customerName: 'คุณชูใจ',
      time: '13:00',
      status: 'เสร็จสิ้น',
      service: 'ตัดผม',
      barberName: 'ช่างบอย',
    ),
  ];

  // ฟังก์ชันสำหรับเปลี่ยนสถานะคิว
  void _updateStatus(String queueId, String newStatus) {
    setState(() {
      final index = todayQueue.indexWhere((item) => item.id == queueId);
      if (index != -1) {
        todayQueue[index].status = newStatus;
      }
    });
    // TODO: ในแอปพลิเคชันจริงต้องทำการอัปเดตสถานะนี้ไปยัง Firestore ด้วย
    // ignore: avoid_print
    print('Updated $queueId status to $newStatus');
  }

  // ตัวช่วยในการกำหนดสีตามสถานะ
  Color _getStatusColor(String status) {
    switch (status) {
      case 'รอ':
        return Colors.blue.shade300;
      case 'กำลังตัด':
        return Colors.orange.shade600;
      case 'เสร็จสิ้น':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade400;
    }
  }

  // Widget สำหรับแสดงรายการคิวแต่ละรายการ
  Widget _buildQueueCard(QueueItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // เวลาและชื่อลูกค้า
                Text(
                  '${item.time} - ${item.customerName}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // สถานะ
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(item.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.status,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // รายละเอียด
            Text('บริการ: ${item.service}',
                style: TextStyle(color: Colors.grey.shade700)),
            Text('ช่าง: ${item.barberName}',
                style: TextStyle(color: Colors.grey.shade700)),
            const Divider(height: 20),
            // ปุ่มดำเนินการ
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ปุ่ม "เริ่มบริการ"
                if (item.status == 'รอ')
                  ElevatedButton.icon(
                    onPressed: () => _updateStatus(item.id, 'กำลังตัด'),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('เริ่มบริการ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                // ปุ่ม "เสร็จสิ้น"
                if (item.status == 'กำลังตัด')
                  ElevatedButton.icon(
                    onPressed: () => _updateStatus(item.id, 'เสร็จสิ้น'),
                    icon: const Icon(Icons.check),
                    label: const Text('เสร็จสิ้น'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // กรองคิวที่ยังไม่เสร็จสิ้นเพื่อสรุป
    final remainingQueue =
        todayQueue.where((item) => item.status != 'เสร็จสิ้น').toList();
    final finishedQueue =
        todayQueue.where((item) => item.status == 'เสร็จสิ้น').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('แดชบอร์ดร้านค้า (ช่างบอย)', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal.shade800, // ใช้สีเข้มเพื่อแยกจากแอปลูกค้า
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false, // หน้าแรกของร้านค้าจึงไม่มีลูกศรย้อนกลับ
      ),
      body: Column(
        children: [
          // ส่วนสรุปวันนี้
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.teal.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                    'คิวที่ต้องทำต่อ', remainingQueue.length.toString()),
                _buildSummaryItem('คิวที่เสร็จแล้ว', finishedQueue.toString()),
              ],
            ),
          ),
          // รายการคิว
          Expanded(
            child: ListView.builder(
              itemCount: todayQueue.length,
              itemBuilder: (context, index) {
                return _buildQueueCard(todayQueue[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับแสดงสรุปข้อมูล
  Widget _buildSummaryItem(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800)),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
      ],
    );
  }
}