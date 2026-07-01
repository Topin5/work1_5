import 'package:flutter/material.dart';
import 'package:lesson1_5/ui/pages/main_page.dart';
import 'di/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),  
    );
  }
}
