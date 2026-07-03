import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/di/injection_container.dart';
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
    return BlocProvider(
      create: (_) => sl<CartBloc>(),
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
}
