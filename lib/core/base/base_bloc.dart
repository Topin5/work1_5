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
}
