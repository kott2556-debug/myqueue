import 'package:booking/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),

        maxWidth: 450,
        minWidth: 360,
        defaultScale: true,

        // ⭐⭐ พื้นหลังรอบนอกของเว็บ ⭐⭐
        background: Container(color: Colors.grey.shade300),

        breakpoints: const [
          ResponsiveBreakpoint.resize(360, name: MOBILE),
          ResponsiveBreakpoint.resize(450, name: MOBILE),
        ],
      ),

      theme: ThemeData(primarySwatch: Colors.blue),

      home: HomeScreen(),
    );
  }
}
