import 'package:flutter/material.dart';
import 'package:lesson1_5/core/app_router.dart';
import 'di/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig:  AppRouter.router,  
    );
  }
}
