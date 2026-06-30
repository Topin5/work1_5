import 'package:lesson1_5/core/base/base_state.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';

typedef ProductInitial = InitialState<List<ProductEntity>>;

typedef ProductLoading = LoadingState<List<ProductEntity>>;

typedef ProductLoaded = LoadedState<List<ProductEntity>>;

typedef ProductState = BaseState<List<ProductEntity>>;

typedef ProductError = ErrorState<List<ProductEntity>>;