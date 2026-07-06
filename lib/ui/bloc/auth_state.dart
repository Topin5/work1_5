import 'package:lesson1_5/core/base/base_state.dart';
import 'package:lesson1_5/domain/entity/auth_entity.dart';

typedef AuthInitil = InitialState<AuthEntity>;
typedef AuhtLoading = LoadingState<AuthEntity>;
typedef AuthLoaded = LoadedState<AuthEntity>;
typedef Authstate = BaseState<AuthEntity>;
typedef AuthError = ErrorState<AuthEntity>;