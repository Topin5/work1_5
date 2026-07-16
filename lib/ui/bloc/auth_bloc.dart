import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/core/base/base_bloc.dart';
import 'package:lesson1_5/core/base/base_state.dart';
import 'package:lesson1_5/core/storage/secure_storage.dart';
import 'package:lesson1_5/domain/entity/auth_entity.dart';
import 'package:lesson1_5/domain/usecase/login_usecase.dart';
import 'package:lesson1_5/domain/usecase/logout_usecace.dart';
import 'package:lesson1_5/ui/bloc/auth_event.dart';
import 'package:lesson1_5/ui/bloc/auth_state.dart';

class AuthBloc  extends BaseBloc<AuthEvent, AuthEntity>{
  final LoginUsecase loginUsecase;
  final LogoutUsecace logoutUsecace;
  final SecureStorage secureStorage;
  

  AuthBloc({
    required this.loginUsecase,
    required this.logoutUsecace,
    required this.secureStorage
    }){
      on<LoginEvent>(_onLogin);
      on<LogoutEvent>(_onLogout);
      on<CheckEvent>(_onCheck);
    }

    Future<void> _onLogin(
      LoginEvent event,
      Emitter<BaseState<AuthEntity>> emit,
    )async{
      emit(LoadingState<AuthEntity>());
      final result = await loginUsecase(
        username: event.username,
        password: event.password);
        await result.fold(
          (failure) { emit(ErrorState<AuthEntity>(failure.message));
        },
        (user) async{
          await secureStorage.saveToken(user.token);
       emit(AuthLoaded(user));
        }        
        );
    }

    Future<void> _onLogout(
      LogoutEvent event,
      Emitter<BaseState<AuthEntity>> emit,
    )async {
      await  logoutUsecace();
       emit(AuthError('logout'));
    }

    Future<void> _onCheck(
      CheckEvent event,
      Emitter<BaseState<AuthEntity>> emit,
    )async{
      final isLoggedIn = await secureStorage.isLoggedIn;
      if(isLoggedIn){
        emit(AuthLoaded(AuthEntity(token: '')));
      }else{
        emit(AuthError('не зарегестрирован'));
      }
    }


}