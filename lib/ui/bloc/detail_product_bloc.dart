import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/core/base/base_bloc.dart';
import 'package:lesson1_5/domain/entity/prodict_detail_entity.dart';
import 'package:lesson1_5/domain/usecase/get_all_products_usecase.dart';
import 'package:lesson1_5/ui/bloc/detail_product_event.dart';
import 'package:lesson1_5/ui/bloc/detail_state_product.dart';

class DetailProductBloc extends BaseBloc<DetailProductEvent, List<ProductDetailEntity>>{
  final GetAllDetailProductsUsecace getAllDetailProductsUsecace;

  DetailProductBloc(this.getAllDetailProductsUsecace){
    on<LoadDetailProduct>(_onDetlLoad);
    on<RefreshDetailProduct>(_onDetRefresh);
  }

  Future<void> _onDetlLoad(
    LoadDetailProduct event,
    Emitter <DetailProductState> emit 
  )async{
    await fetchData(useCase: ()=> getAllDetailProductsUsecace(event.productId), emit: emit);
  }

  Future<void> _onDetRefresh(
    RefreshDetailProduct  event,
    Emitter<DetailProductState> emit
  )async{
    await fetchData(useCase: ()=> getAllDetailProductsUsecace(event.productId), emit: emit);
  }
}
