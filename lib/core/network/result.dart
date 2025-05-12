import 'error.dart';

sealed class Result<D, E extends AppError> {
  const Result();
}

class Success<D, E extends AppError> extends Result<D, E> {
  final D data;
  const Success(this.data);
}

class Failure<D, E extends AppError> extends Result<D, E> {
  final E error;
  const Failure(this.error);
}

typedef EmptyResult<E extends AppError> = Result<void, E>;

extension ResultExtensions<T, E extends AppError> on Result<T, E> {
  Result<R, E> map<R>(R Function(T data) transform) {
    if (this is Success<T, E>) {
      final data = (this as Success<T, E>).data;
      return Success<R, E>(transform(data));
    } else {
      return this as Failure<R, E>;
    }
  }

  EmptyResult<E> asEmptyDataResult() {
    return map((_) {});
  }

  Result<T, E> onSuccess(void Function(T data) action) {
    if (this is Success<T, E>) {
      action((this as Success<T, E>).data);
    }
    return this;
  }

  Result<T, E> onError(void Function(E error) action) {
    if (this is Failure<T, E>) {
      action((this as Failure<T, E>).error);
    }
    return this;
  }
}
