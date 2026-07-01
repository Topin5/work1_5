import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/core/base/base_bloc.dart';
import 'package:lesson1_5/core/base/base_state.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';
import 'package:lesson1_5/domain/usecase/get_all_products_usecase.dart';
import 'package:lesson1_5/ui/bloc/product_event.dart';

class ProductBloc extends BaseBloc<ProductEvent, List<ProductEntity>>{
  final GetAllProductsUsecase getAllProductsUsecase;

  ProductBloc(this.getAllProductsUsecase) {
    on<LoadProduct>(_onLoad);
    on<RefreshProductEvent>(_onRefresh);
  }

  Future<void> _onLoad(
    LoadProduct event,
    Emitter <BaseState<List<ProductEntity>>> emit
  )async{
   await fetchData(useCase: () => getAllProductsUsecase(), emit: emit );
  }

  Future<void> _onRefresh(
    RefreshProductEvent event,
    Emitter<BaseState<List<ProductEntity>>> emit
  )async{
    await fetchData(useCase: () => getAllProductsUsecase(), emit: emit );

  }

  
}

