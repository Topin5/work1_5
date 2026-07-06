import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lesson1_5/core/app_router.dart';
import 'package:lesson1_5/di/injection_container.dart';
import 'package:lesson1_5/ui/bloc/auth_bloc.dart';
import 'package:lesson1_5/ui/bloc/auth_event.dart';
import 'package:lesson1_5/ui/bloc/auth_state.dart';
import 'package:lesson1_5/ui/bloc/cart_bloc.dart';
import 'package:lesson1_5/ui/bloc/cart_state.dart';
import 'package:lesson1_5/ui/pages/cart_page.dart';
import 'package:lesson1_5/ui/pages/products_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CartBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>())
      ],
      child: Builder(builder: (context){
        return BlocListener<AuthBloc, Authstate>(
          listener: (context, state){
            if(state is AuthError && state.message == 'logout'){
              context.go(AppRouter.login);
            }
          },      
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          final totalCount = cartState is CartUpdated
              ? cartState.totalCount
              : 0;
              final pages = [
                ProductsPage(),
                CartPage()
              ];
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.green),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ListTile(
                          leading: Icon(Icons.logout, color: Colors.blueGrey),
                          title: Text('выйти'),
                          onTap: (){
                            Navigator.pop(context);
                            context.read<AuthBloc>().add(LogoutEvent());
                          },
                        )
                      ],
                    ))
                ],
              ),
            ),
            body: pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: 'Магазин',
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    isLabelVisible: totalCount > 0,
                    label: Text('$totalCount'),
                    child: Icon(Icons.shopping_cart),
                  ),
                  label: 'Корзина',
                ),
              ],
            ),
          
          );
        },
      ),
        );
      }
      )
    );
  }
}
