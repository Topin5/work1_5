abstract class BaseState<T> {}

class InitialState<T> extends BaseState<T>{}

class LoadingState<T> extends BaseState<T>{}

class LoadedState<T> extends BaseState<T>{
  final T data;
  LoadedState(this.data);
}

class ErrorState<T> extends BaseState<T>{
  final String message;
  ErrorState(this.message);
}

class PaginState<T> extends LoadedState<List<T>> {
  final int currentPage;
  final bool hasnextPage;
  final bool isLoadinMore;
  PaginState({
    required this.currentPage,
    required List<T> items,
    required this.hasnextPage,
    this.isLoadinMore = false
  }):super(items);

  PaginState<T> copyWith({
    List<T>? items,
    int? currentPage,
    bool? hasnextPage,
    bool? isLoadinMore
  }){
    return PaginState<T>(
      currentPage: currentPage ?? this.currentPage, 
      items: items ?? data, 
      hasnextPage: hasnextPage ?? this.hasnextPage,
      isLoadinMore: isLoadinMore ?? this.isLoadinMore
      );
  }
}