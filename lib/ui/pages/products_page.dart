import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/di/injection_container.dart';
import 'package:lesson1_5/ui/bloc/product_bloc.dart';
import 'package:lesson1_5/ui/bloc/product_event.dart';
import 'package:lesson1_5/ui/bloc/product_state.dart';
import 'package:lesson1_5/ui/widgets/widget_product.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(LoadProduct()),
      child: Scaffold(appBar: AppBar(
        title: Text('Магазин'),
        
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(state is ProductError){
            return Center(child: Column(
              children: [
                Text(state.message),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  context.read<ProductBloc>().add(LoadProduct());
                }, child: Text('повторить загрузку'))
              ],
            )
            );
          }
          if(state is ProductLoaded){
            return RefreshIndicator(
              onRefresh: ()async => context. read<ProductBloc>().add(RefreshProductEvent()),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12, 
                  ), 
                itemCount: state.data.length,  
                itemBuilder: (context, index){
                  return 
                    WidgetProduct(product: state.data[index]);
                  }
                ) 
              );
          }
          return SizedBox.shrink();
        }
        )
      ),
      
      );
  }
}