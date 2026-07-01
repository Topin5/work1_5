import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/di/injection_container.dart';
import 'package:lesson1_5/ui/bloc/detail_product_bloc.dart';
import 'package:lesson1_5/ui/bloc/detail_product_event.dart';
import 'package:lesson1_5/ui/bloc/detail_state_product.dart';

class DetailPageProducts extends StatelessWidget {
  final int productId;
  const DetailPageProducts({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return    BlocProvider(
      create:(_)=>
      sl<DetailProductBloc>()..add(LoadDetailProduct(productId)),
      child: Scaffold(
        appBar: AppBar(title: Text('Подробное товара'),),
        body: BlocBuilder<DetailProductBloc, DetailProductState>(
          builder: (context, state){
            if(state is DetailProductLoading){
              return Center(child: CircularProgressIndicator());
            }
            if(state is DetailProductError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      context.read<DetailProductBloc>().add(RefreshDetailProduct(productId));
                    }, child: Text('повторить загрузку')),

                  ],
                ),
              );
            }
            if(state is DetailProductLoaded){
              final product = state.data.first;
              return RefreshIndicator( onRefresh: ()async => context.read<DetailProductBloc>()
              .add(RefreshDetailProduct(productId)),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    Padding(padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 8,),
                        Text('\$${product.price.toStringAsFixed(2)}',style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green
                        )),
                        const SizedBox(height: 8),
                        Chip(label: Text(product.category)),
                        const SizedBox(height: 15),
                        Text(product.desc, style: TextStyle(
                          fontSize: 14, height: 1.5
                        )),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${product.title} добавлен в корзину'))
                            );
                          },
                          icon: const Icon(Icons.shopping_cart), 
                          label: const Text('добвить в корзину')
                          ),
                        )
                      
                      ],
                    ),
                    )
                  ],
                ),
              ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
       );
    
  }
}