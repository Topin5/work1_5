import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/di/injection_container.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';
import 'package:lesson1_5/ui/bloc/product_bloc.dart';
import 'package:lesson1_5/ui/bloc/product_event.dart';
import 'package:lesson1_5/ui/bloc/product_state.dart';
import 'package:lesson1_5/core/base/base_state.dart';
import 'package:lesson1_5/ui/widgets/widget_product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  late final ProductBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = sl<ProductBloc>()..add(LoadProduct(page: 1));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = _bloc.state;
      if (state is PaginState<ProductEntity> &&
          state.hasnextPage &&
          !state.isLoadinMore) {
        _bloc.add(LoadProduct(page: state.currentPage + 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Магазин')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _bloc.add(LoadProduct(page: 1));
                      },
                      child: Text('повторить загрузку'),
                    )
                  ],
                ),
              );
            }
            if (state is ProductLoaded) {
              final isLoadingMore =
                  state is PaginState<ProductEntity> && state.isLoadinMore;
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<ProductBloc>().add(RefreshProductEvent()),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: state.data.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.data.length) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return WidgetProduct(product: state.data[index]);
                  },
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