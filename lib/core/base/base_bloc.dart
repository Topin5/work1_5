import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/core/base/base_state.dart';

abstract class BaseBloc<Event, T> extends Bloc<Event, BaseState<T>>{
 BaseBloc() :super (InitialState<T>());

 Future<void> fetchData({
  required Future<dynamic> Function() useCase,
  required Emitter<BaseState<T>> emit
 })async{
  emit (LoadingState<T>());
  try{
    final result = await useCase();
    result.fold(
      (failure) => emit (ErrorState<T>(failure.message)),
      (data) => emit(LoadedState<T>(data)));
  }catch(e){
    emit(ErrorState<T>(e.toString()));
  }
 }

 Future<void> fetchPaginData<T> ({
  required Future<dynamic> Function() useCase,
  required Emitter<BaseState<List<T>>> emit,
  required int page,
  List<T> previosItems = const []

 })async{
  try{
    final result = await useCase();
    result.fold(
      (failure) => emit(ErrorState<List<T>>(failure.message)),
      (pagin){
        emit( PaginState<T>(
          items:[...previosItems, ...pagin.items as List<T>],
          currentPage: pagin.currentPage,
          hasnextPage: pagin.hasnextPage,
          ));
    
      }
      );
  }catch(e){
    emit(ErrorState<List<T>>(e.toString()));
  }
 }
}
