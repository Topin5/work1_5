import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Корзина')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 75,),
            SizedBox(height: 16),
            Text('Корзина пуста', style:  TextStyle(fontSize: 18, color: Colors.grey)),

          ],
        ),
      ),
    );
  }
}