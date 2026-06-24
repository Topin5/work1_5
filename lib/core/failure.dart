abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure{
  const ServerFailure(super.message);
}

class NetWorkFailure extends Failure{
  const NetWorkFailure(super.message);
}
