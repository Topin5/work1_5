import 'package:lesson1_5/core/base/base_state.dart';
import 'package:lesson1_5/domain/entity/prodict_detail_entity.dart';

typedef DetailProductInitial = InitialState<List<ProductDetailEntity>>;

typedef DetailProductLoading = LoadingState<List<ProductDetailEntity>>;

typedef DetailProductLoaded = LoadedState<List<ProductDetailEntity>>;

typedef DetailProductState = BaseState<List<ProductDetailEntity>>;

typedef DetailProductError = ErrorState<List<ProductDetailEntity>>; 