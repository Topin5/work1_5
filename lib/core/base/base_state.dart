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