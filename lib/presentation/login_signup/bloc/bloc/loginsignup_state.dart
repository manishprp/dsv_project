part of 'loginsignup_bloc.dart';

sealed class LoginsignupState extends Equatable {
  const LoginsignupState();

  @override
  List<Object> get props => [];
}

final class LoginsignupInitial extends LoginsignupState {
  const LoginsignupInitial();
  @override
  List<Object> get props => [];
}

final class LoginsignupLoading extends LoginsignupState {
  const LoginsignupLoading();
  @override
  List<Object> get props => [];
}

final class LoginsignupSuccess extends LoginsignupState {
  final User user;

  const LoginsignupSuccess({required this.user});

  @override
  List<Object> get props => [user];

  LoginsignupSuccess copyWith(User? userIn) {
    return LoginsignupSuccess(user: userIn ?? user);
  }
}

final class LoginsignupFailure extends LoginsignupState {
  final String errorMessage;
  const LoginsignupFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];

  LoginsignupFailure copyWith(String? errorMessageIn) {
    return LoginsignupFailure(errorMessage: errorMessageIn ?? errorMessage);
  }
}
