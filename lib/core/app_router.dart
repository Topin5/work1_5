import 'package:go_router/go_router.dart';
import 'package:lesson1_5/core/storage/secure_storage.dart';
import 'package:lesson1_5/di/injection_container.dart';
import 'package:lesson1_5/ui/pages/login_page.dart';
import 'package:lesson1_5/ui/pages/main_page.dart';

class AppRouter{
 static const login = '/login';
 static const home = '/home';

 static final router = GoRouter(
  initialLocation: login,
  redirect: (context, state) async{
    final isLoggedIn = await sl<SecureStorage>().isLoggedIn;
    if(isLoggedIn) return home;
    return null;
  
  },
  routes: [
    GoRoute(path: login,
    builder: (context, state) => LoginPage(),
     ),
    GoRoute(path: home,
    builder: (context, state) => MainPage(),) 
  ]);
}